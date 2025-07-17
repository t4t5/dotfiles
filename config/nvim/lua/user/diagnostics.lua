-- Diagnostic keymaps (jump to errors)
if vim.g.vscode then
  -- VSCode-specific settings
  vim.api.nvim_set_keymap('n', '<leader>ak', "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>",
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>aj', "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>",
    { noremap = true, silent = true })
else
  -- Regular Neovim settings
  require("which-key").add({
    {
      "<leader>ak",
      vim.diagnostic.goto_prev,
      desc = "go to previous diagnostic",
      mode = "n",
      icon = "󰒮"
    },
    {
      "<leader>aj",
      vim.diagnostic.goto_next,
      desc = "go to next diagnostic",
      mode = "n",
      icon = "󰒭"
    },
    {
      "<leader>ae",
      function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end,
      desc = "go to next error",
      mode = "n",
      icon = ""
    },
    {
      "<leader>ay",
      vim.diagnostic.enable,
      desc = "enable diagnostics",
      mode = "n",
      icon = ""
    },
    {
      "<leader>an",
      vim.diagnostic.enable,
      desc = "disable diagnostics",
      mode = "n",
      icon = ""
    },
  })
end

-- Show bordered window for errors:
vim.diagnostic.config {
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
}

local function yank_diagnostic_error()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid()    -- get the window ID of the floating window
  vim.cmd("normal! j")                 -- move down one row
  vim.cmd("normal! VG")                -- select everything from that row down
  vim.cmd("normal! y")                 -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end

-- Copy error messages:
require("which-key").add({
  {
    -- open file explorer at position of current file:
    "<leader>e",
    yank_diagnostic_error,
    desc = "copy error",
    mode = "n",
    icon = ""
  },
})

------------------
-- AI WORKFLOW: --

-- concatenate code yanked to "a" register
-- with error yanked to default register:
local function generate_ai_prompt()
  -- 'a' register:
  local reg_a_contents = vim.fn.getreg('a')

  -- default register:
  local default_reg_contents = vim.fn.getreg('"')

  local prompt = string.format("This is my code:\n```\n%s\n```\n\nBut I'm getting this error:\n```\n%s\n```",
    reg_a_contents, default_reg_contents)

  vim.fn.setreg('"', prompt)

  -- show non-blocking notification:
  vim.schedule(function()
    vim.notify("✨ Copied AI prompt to clipboard!", vim.log.levels.INFO)
  end)
end

local function yank_ai_prompt()
  -- Yank the selected text to register 'a'
  vim.api.nvim_command('normal! gv"ay')

  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Convert positions to (row, col) format
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  -- Get all diagnostics in the current buffer
  local diagnostics = vim.diagnostic.get(0)

  -- Filter diagnostics to those within the visual selection
  local diagnostics_in_selection = {}
  for _, diagnostic in ipairs(diagnostics) do
    local d_line, d_col = diagnostic.lnum + 1, diagnostic.col + 1
    if (d_line > start_line or (d_line == start_line and d_col >= start_col)) and
        (d_line < end_line or (d_line == end_line and d_col <= end_col)) then
      table.insert(diagnostics_in_selection, diagnostic)
    end
  end

  -- Jump to the first diagnostic in the selection, if any
  if #diagnostics_in_selection > 0 then
    local first_diagnostic = diagnostics_in_selection[1]
    vim.api.nvim_win_set_cursor(0, { first_diagnostic.lnum + 1, first_diagnostic.col })
    yank_diagnostic_error()
    generate_ai_prompt()
  else
    vim.schedule(function()
      print("❌ No diagnostics found in selection")
    end)
  end
end

-- Create a command to call the function
vim.api.nvim_create_user_command('YankAiErrorPrompt', yank_ai_prompt,
  { range = true })

-- Visual mode only:
require("which-key").add({
  {
    "<leader>ae",
    ':YankAiErrorPrompt<CR>',
    desc = "generate prompt for error",
    mode = "x",
    icon = "🐞"
  },
})
