local parsers = require('nvim-treesitter.parsers')
local op_effects = require("bitcoin_script_hints.op_codes")

local M = {}

-- Modified format_state function to handle errors
local function format_state(state)
  if state.error then
    return "ERROR: " .. state.error
  end
  local main_str = "[" .. table.concat(state.main, ", ") .. "]"
  local alt_str = "[" .. table.concat(state.alt, ", ") .. "]"
  return main_str .. ", " .. alt_str
end

-- Parse initial stack state from comment
local function parse_initial_state(comment)
  -- Try to match both stacks first
  local main_str, alt_str = comment:match("%s*(%[[^%]]*%]),%s*(%[[^%]]*%])")

  -- If that fails, try to match just one stack
  if not main_str then
    main_str = comment:match("%s*(%[[^%]]*%])")
    alt_str = "[]" -- Default empty altstack
  end

  if not main_str then
    return nil
  end

  -- Convert string representations to tables
  local function parse_stack(str)
    local items = {}
    -- Only try to parse items if there's content between the brackets
    local content = str:match("%[([^%]]*)%]")
    if content and content:len() > 0 then
      for item in content:gmatch("[^,%s]+") do
        table.insert(items, item)
      end
    end
    return items
  end

  local state = {
    main = parse_stack(main_str),
    alt = parse_stack(alt_str or "[]") -- Handle case where alt_str is nil
  }

  return state
end

local function handle_branch_operation(op, branch_state, current_state)
  if op == "OP_IF" or op == "OP_NOTIF" then
    branch_state.in_if = true
    current_state = op_effects[op](current_state)
    branch_state.executing = not current_state.error and current_state.if_result
    return current_state, false -- false means don't show hint
  elseif op == "OP_ELSE" then
    branch_state.in_if = false
    branch_state.in_else = true
    branch_state.executing = not branch_state.executing
    return current_state, false
  elseif op == "OP_ENDIF" then
    branch_state.in_if = false
    branch_state.in_else = false
    branch_state.executing = true
    return current_state, false
  end
  return current_state, true -- true means show hint
end


local function render_hint(bufnr, namespace, row, current_state)
  vim.api.nvim_buf_set_extmark(bufnr, namespace, row, 0, {
    virt_text = { { " → " .. format_state(current_state), current_state.error and "ErrorMsg" or "Comment" } },
    virt_text_pos = "eol",
  })
end

local function process_script_content(node, bufnr, namespace)
  local content = vim.treesitter.get_node_text(node, bufnr)

  -- Getting the start position and content
  local start_row = node:range()

  -- Split content into lines, keeping empty lines
  local lines = vim.split(content, "\n", { plain = true })

  -- Find the Example comment and initial state
  local initial_state
  local op_start_line = start_row
  for i, line in ipairs(lines) do
    if line:match("^%s*//.*%[") then -- Matches any line starting with comment and containing [
      initial_state = parse_initial_state(line)
      start_row = start_row + i - 1
      break
    end
  end

  if initial_state then
    local current_state = initial_state
    local current_line = op_start_line

    -- Add branch tracking
    local branch_state = {
      in_if = false,
      in_else = false,
      executing = true -- whether we're in a branch that should execute
    }

    -- Process each operation
    for i, line in ipairs(lines) do
      -- Clean the line of whitespace
      local cleaned_line = line:match("^%s*(.-)%s*$")

      -- Only process and render for lines with operations
      local op = cleaned_line:match("OP_%w+")

      if op then
        local should_execute
        current_state, should_execute = handle_branch_operation(op, branch_state, current_state)

        -- Only execute and show hints for operations in the active branch
        if should_execute and branch_state.executing and op_effects[op] then
          -- Calculate new state
          current_state = op_effects[op](current_state)

          -- Add virtual text
          render_hint(bufnr, namespace, start_row + i - 2, current_state)

          -- If we got an error, stop processing
          if current_state.error then
            break
          end
        end
      end

      current_line = current_line + 1
    end
  end
end

function M.setup()
  M.namespace = vim.api.nvim_create_namespace('bitcoin_script_hints')

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWrite", "InsertLeave" }, {
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      if vim.bo[bufnr].filetype ~= 'rust' then return end

      -- Clear existing virtual text
      vim.api.nvim_buf_clear_namespace(bufnr, M.namespace, 0, -1)

      local query = vim.treesitter.query.parse('rust', [[
        (macro_invocation
          macro: (identifier) @macro (#eq? @macro "script")
          (token_tree) @script_content
        )
      ]])

      local parser = parsers.get_parser(bufnr)
      local tree = parser:parse()[1]
      local root = tree:root()

      for _, node in query:iter_captures(root, bufnr, 0, -1) do
        if node:type() == "token_tree" then
          process_script_content(node, bufnr, M.namespace)
        end
      end
    end
  })
end

return M
