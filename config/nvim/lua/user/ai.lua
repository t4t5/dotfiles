-- ============ Basic command for Claude Code (<leader>C) =============
local function open_claude_in_tmux(prompt)
  if prompt then
    vim.fn.system('tmux split-window -h "claude \\"' .. prompt .. '\\"" \\; resize-pane -x 80')
  else
    vim.fn.system 'tmux split-window -h "claude" \\; resize-pane -x 80'
  end
end

require("which-key").add {
  {
    "<leader>C",
    function()
      local mode = vim.api.nvim_get_mode().mode

      -- visual mode:
      if mode == "v" or mode == "V" then
        -- Copy the selection (same as <leader>aa)
        vim.cmd "normal! :"
        vim.cmd "CopyClaudeContextRef"

        -- Open Claude:
        open_claude_in_tmux()

        -- Wait for Claude to load, then paste from clipboard:
        vim.fn.system 'sleep 2 && tmux send-keys "$(pbpaste)"'
        return
      else
        -- normal mode:
        open_claude_in_tmux()
      end
    end,
    desc = "Claude Code",
    mode = { "n", "v" },
    icon = "🤖",
  },
}

-- ============ Get @ref for Claude context (<leader>aa) =============
local function copy_claude_context_ref(register)
  -- Get the start and end line numbers of the visual selection
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  -- Get the current file path
  local file_path = vim.fn.expand "%:p"

  if file_path == "" then
    print "Error: No file is currently open"
    return nil
  end

  -- Get git root directory
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")

  if vim.v.shell_error ~= 0 then
    print "Error: Not in a git repository"
    return nil
  end

  -- Make file path relative to git root
  local relative_path = file_path:gsub("^" .. git_root .. "/", "")

  -- Create the formatted string
  local result
  if start_line == end_line then
    result = string.format("@%s#L%d", relative_path, start_line)
  else
    result = string.format("@%s#L%d-%d", relative_path, start_line, end_line)
  end

  -- Copy to specified register if provided
  if type(register) == "string" then
    vim.fn.setreg(register, result)
  end

  -- Copy to clipboard (both + and * registers for maximum compatibility)
  vim.fn.setreg("+", result)
  vim.fn.setreg("*", result)

  print("Copied to clipboard: " .. result)

  return result
end

vim.api.nvim_create_user_command("CopyClaudeContextRef", copy_claude_context_ref, {
  range = true,
  desc = "Copy Claude context ref (with @)",
})

require("which-key").add {
  {
    "<leader>aa",
    ":CopyClaudeContextRef<CR>",
    desc = "get claude @ref",
    mode = "v",
  },
}

-- ============ Get prompt with error + reference (<leader>ae) =============

local function yank_diagnostic_error(show_log)
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid() -- get the window ID of the floating window
  vim.cmd "normal! j" -- move down one row
  vim.cmd "normal! VG" -- select everything from that row down
  vim.cmd "normal! y" -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID

  if show_log then
    print "Copied diagnostic error to clipboard"
  end
end

-- Copy error messages:
require("which-key").add {
  {
    -- open file explorer at position of current file:
    "<leader>e",
    function()
      yank_diagnostic_error(true)
    end,
    desc = "copy error",
    mode = "n",
    icon = "",
  },
}

local function generate_ai_prompt()
  -- 'a' register contains the reference:
  local ref = vim.fn.getreg "a"

  -- default register contains the error:
  local error = vim.fn.getreg '"'

  local prompt = string.format("At %s I'm getting this error: \n%s", ref, error)

  return prompt
end

local function fix_error_with_claude()
  -- Copy the reference to register 'a'
  copy_claude_context_ref "a"

  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  -- Convert positions to (row, col) format
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  -- Get all diagnostics in the current buffer
  local diagnostics = vim.diagnostic.get(0)

  -- Filter diagnostics to those within the visual selection
  local diagnostics_in_selection = {}
  for _, diagnostic in ipairs(diagnostics) do
    local d_line, d_col = diagnostic.lnum + 1, diagnostic.col + 1
    if (d_line > start_line or (d_line == start_line and d_col >= start_col)) and (d_line < end_line or (d_line == end_line and d_col <= end_col)) then
      table.insert(diagnostics_in_selection, diagnostic)
    end
  end

  -- Jump to the first diagnostic in the selection, if any
  if #diagnostics_in_selection > 0 then
    local first_diagnostic = diagnostics_in_selection[1]
    vim.api.nvim_win_set_cursor(0, { first_diagnostic.lnum + 1, first_diagnostic.col })
    yank_diagnostic_error()
    local prompt = generate_ai_prompt()

    -- Copy to clipboard (both + and * registers for maximum compatibility)
    vim.fn.setreg("+", prompt)
    vim.fn.setreg("*", prompt)

    print("Copied to clipboard: " .. prompt)
    -- open_claude_in_tmux(prompt)
  else
    vim.schedule(function()
      print "❌ No diagnostics found in selection"
    end)
  end
end

-- Create a command to call the function
vim.api.nvim_create_user_command("FixErrorWithAI", fix_error_with_claude, { range = true })

-- Visual mode only:
require("which-key").add {
  {
    "<leader>ae",
    ":FixErrorWithAI<CR>",
    desc = "fix error with AI",
    mode = "x",
    icon = "🐞✨",
  },
}
