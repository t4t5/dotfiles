local parsers = require('nvim-treesitter.parsers')
local op_effects = require("bitcoin_script_hints.op_codes")

local M = {}

--[[ local function debug_log(msg)
  local log_file = '/tmp/bitcoin_script_hints.log'
  local f = io.open(log_file, 'a')
  if f then
    f:write(os.date('%Y-%m-%d %H:%M:%S') .. ': ' .. msg .. '\n')
    f:close()
  end
end ]]

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
  -- debug_log("Parsing comment: " .. comment)

  -- Try to match both stacks first
  local main_str, alt_str = comment:match("%s*(%[[^%]]*%]),%s*(%[[^%]]*%])")

  -- If that fails, try to match just one stack
  if not main_str then
    main_str = comment:match("%s*(%[[^%]]*%])")
    alt_str = "[]" -- Default empty altstack
  end

  if not main_str then
    -- debug_log("Failed to parse stacks from comment")
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
  -- debug_log("Parsed initial state: main=" .. vim.inspect(state.main) .. ", alt=" .. vim.inspect(state.alt))
  return state
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
          local content = vim.treesitter.get_node_text(node, bufnr)
          -- debug_log("Processing script content: " .. content)

          -- Split content into lines
          local lines = {}
          for line in content:gmatch("[^\r\n]+") do
            table.insert(lines, line)
          end

          -- Find the Example comment and initial state
          local initial_state
          local start_row = node:range()
          for i, line in ipairs(lines) do
            if line:match("^%s*//.*%[") then -- Matches any line starting with comment and containing [
              initial_state = parse_initial_state(line)
              start_row = start_row + i - 1
              break
            end
          end

          if initial_state then
            local current_state = initial_state
            -- debug_log("Initial state: " .. format_state(current_state))

            -- Add branch tracking
            local branch_state = {
              in_if = false,
              in_else = false,
              executing = true -- whether we're in a branch that should execute
            }

            -- Process each operation
            for i, line in ipairs(lines) do
              local op = line:match("OP_%w+")
              if op then
                local should_execute = true

                -- Handle branch operations
                if op == "OP_IF" or op == "OP_NOTIF" then
                  branch_state.in_if = true
                  current_state = op_effects[op](current_state)
                  -- Set execution state based on IF condition
                  branch_state.executing = not current_state.error and current_state.if_result
                  should_execute = false -- IF itself doesn't need a hint
                elseif op == "OP_ELSE" then
                  branch_state.in_if = false
                  branch_state.in_else = true
                  -- Invert execution state
                  branch_state.executing = not branch_state.executing
                  should_execute = false -- ELSE itself doesn't need a hint
                elseif op == "OP_ENDIF" then
                  branch_state.in_if = false
                  branch_state.in_else = false
                  branch_state.executing = true
                  should_execute = false -- ENDIF itself doesn't need a hint
                end

                -- Only execute and show hints for operations in the active branch
                if should_execute and branch_state.executing and op_effects[op] then
                  -- Calculate new state
                  current_state = op_effects[op](current_state)
                  -- debug_log("After " .. op .. ": " .. format_state(current_state))

                  -- Add virtual text
                  vim.api.nvim_buf_set_extmark(bufnr, M.namespace, start_row + i - 2, 0, {
                    virt_text = { { " → " .. format_state(current_state), current_state.error and "ErrorMsg" or "Comment" } },
                    virt_text_pos = "eol",
                  })

                  -- If we got an error, stop processing
                  if current_state.error then
                    break
                  end
                end
              end
            end
          end
        end
      end
    end
  })
end

return M
