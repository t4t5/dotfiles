local parsers = require('nvim-treesitter.parsers')

local M = {}

local function debug_log(msg)
  local log_file = '/tmp/bitcoin_script_hints.log'
  local f = io.open(log_file, 'a')
  if f then
    f:write(os.date('%Y-%m-%d %H:%M:%S') .. ': ' .. msg .. '\n')
    f:close()
  end
end
-- Helper to create error state
-- Helper to create error state
local function make_error(message, prev_state)
  return {
    error = message,
    main = prev_state.main, -- keep previous state for context
    alt = prev_state.alt
  }
end

-- Helper to safely convert to number
local function to_number(val)
  if type(val) == "number" then
    return val
  end
  local num = tonumber(val)
  if num then
    return num
  end
  return nil, "Cannot convert '" .. tostring(val) .. "' to number"
end

-- Stack operations
local op_effects = {
  OP_TOALTSTACK = function(state)
    if #state.main == 0 then
      return make_error("Stack underflow", state)
    end
    local new_state = vim.deepcopy(state)
    local val = table.remove(new_state.main)
    table.insert(new_state.alt, val)
    return new_state
  end,

  OP_DEPTH = function(state)
    local new_state = vim.deepcopy(state)
    table.insert(new_state.main, #new_state.main)
    return new_state
  end,

  OP_0 = function(state)
    local new_state = vim.deepcopy(state)
    table.insert(new_state.main, 0)
    return new_state
  end,

  OP_1 = function(state)
    local new_state = vim.deepcopy(state)
    table.insert(new_state.main, 1)
    return new_state
  end,

  OP_2 = function(state)
    local new_state = vim.deepcopy(state)
    table.insert(new_state.main, 2)
    return new_state
  end,

  OP_DUP = function(state)
    if #state.main == 0 then
      return make_error("Stack underflow", state)
    end
    local new_state = vim.deepcopy(state)
    local val = new_state.main[#new_state.main]
    table.insert(new_state.main, val)
    return new_state
  end,

  OP_ADD = function(state)
    if #state.main < 2 then
      return make_error("Need two items for ADD", state)
    end
    local new_state = vim.deepcopy(state)
    local a = table.remove(new_state.main)
    local b = table.remove(new_state.main)

    local num_a, err_a = to_number(a)
    if not num_a then
      return make_error(err_a, state)
    end

    local num_b, err_b = to_number(b)
    if not num_b then
      return make_error(err_b, state)
    end

    table.insert(new_state.main, num_b + num_a)
    return new_state
  end,

  OP_GREATERTHAN = function(state)
    if #state.main < 2 then
      return make_error("Need two items for GREATERTHAN", state)
    end
    local new_state = vim.deepcopy(state)
    local a = table.remove(new_state.main)
    local b = table.remove(new_state.main)

    local num_a, err_a = to_number(a)
    if not num_a then
      return make_error(err_a, state)
    end

    local num_b, err_b = to_number(b)
    if not num_b then
      return make_error(err_b, state)
    end

    -- Bitcoin script uses reverse order for comparison
    table.insert(new_state.main, num_b > num_a and 1 or 0)
    return new_state
  end,

  OP_IF = function(state)
    if #state.main < 1 then
      return make_error("Need one item for IF", state)
    end
    local new_state = vim.deepcopy(state)
    local condition = table.remove(new_state.main)

    local num_condition, err_condition = to_number(condition)
    if not num_condition then
      return make_error(err_condition, state)
    end

    -- Store the condition result in the state for ENDIF to use
    new_state.if_result = num_condition ~= 0
    return new_state
  end,

  OP_ELSE = function(state)
    if state.if_result == nil then
      return make_error("ELSE without matching IF", state)
    end
    local new_state = vim.deepcopy(state)
    -- Just invert the if_result flag
    new_state.if_result = not new_state.if_result
    return new_state
  end,

  OP_ENDIF = function(state)
    -- Just remove the if_result flag, no stack changes
    local new_state = vim.deepcopy(state)
    new_state.if_result = nil
    return new_state
  end,

  OP_FROMALTSTACK = function(state)
    if #state.alt == 0 then
      return make_error("Alt stack underflow", state)
    end
    local new_state = vim.deepcopy(state)
    local val = table.remove(new_state.alt)
    table.insert(new_state.main, val)
    return new_state
  end,

  OP_SWAP = function(state)
    if #state.main < 2 then
      return make_error("Need two items for SWAP", state)
    end
    local new_state = vim.deepcopy(state)
    local a = table.remove(new_state.main)
    local b = table.remove(new_state.main)
    table.insert(new_state.main, a)
    table.insert(new_state.main, b)
    return new_state
  end,

  OP_SHA256 = function(state)
    if #state.main < 1 then
      return make_error("Stack underflow", state)
    end
    local new_state = vim.deepcopy(state)
    local val = table.remove(new_state.main)
    -- Create hashed representation by wrapping in H()
    table.insert(new_state.main, "H(" .. tostring(val) .. ")")
    return new_state
  end,

  OP_CAT = function(state)
    if #state.main < 2 then
      return make_error("Need two items for CAT", state)
    end
    local new_state = vim.deepcopy(state)
    local a = table.remove(new_state.main)
    local b = table.remove(new_state.main)

    table.insert(new_state.main, tostring(a) .. tostring(b))
    return new_state
  end,
}

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
-- Parse initial stack state from comment
local function parse_initial_state(comment)
  debug_log("Parsing comment: " .. comment)

  -- Try to match both stacks first
  local main_str, alt_str = comment:match("Example:%s*(%[[^%]]*%]),%s*(%[[^%]]*%])")

  -- If that fails, try to match just one stack
  if not main_str then
    main_str = comment:match("Example:%s*(%[[^%]]*%])")
    alt_str = "[]" -- Default empty altstack
  end

  if not main_str then
    debug_log("Failed to parse stacks from comment")
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
  debug_log("Parsed initial state: main=" .. vim.inspect(state.main) .. ", alt=" .. vim.inspect(state.alt))
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
          debug_log("Processing script content: " .. content)

          -- Split content into lines
          local lines = {}
          for line in content:gmatch("[^\r\n]+") do
            table.insert(lines, line)
          end

          -- Find the Example comment and initial state
          local initial_state
          local start_row = node:range()
          for i, line in ipairs(lines) do
            if line:match("Example:") then
              initial_state = parse_initial_state(line)
              start_row = start_row + i - 1
              break
            end
          end

          if initial_state then
            local current_state = initial_state
            debug_log("Initial state: " .. format_state(current_state))

            -- Process each operation
            for i, line in ipairs(lines) do
              local op = line:match("OP_%w+")
              if op and op_effects[op] then
                -- Calculate new state
                current_state = op_effects[op](vim.deepcopy(current_state))
                debug_log("After " .. op .. ": " .. format_state(current_state))

                -- Add virtual text
                vim.api.nvim_buf_set_extmark(bufnr, M.namespace, start_row + i - 2, 0, {
                  virt_text = { {
                    " → " .. format_state(current_state),
                    current_state.error and "ErrorMsg" or "Comment"
                  } },
                  virt_text_pos = "eol",
                })
              end
            end
          end
        end
      end
    end
  })
end

return M
