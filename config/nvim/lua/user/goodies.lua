-- Remap for dealing with word wrap in long lines:
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Show current file in finder:
vim.cmd [[
  command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
]]
require("which-key").add({
  {
    -- Show current file in finder:
    "<leader>o",
    ':Silent open %:h<cr>',
    desc = "open in finder",
    mode = "n",
    icon = "󰀶"
  },
})

-- Highlight copied text when yanking:
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Paste inline with <leader>p:
require("which-key").add({
  { "<leader>p", "<Plug>UnconditionalPasteInlinedAfter", desc = "paste inline", mode = "n", icon = "" },
})

-- Set syntax highlighting for .env.local, .env.development, .env.production...
vim.api.nvim_command("au! BufNewFile,BufRead .env.* set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead zshrc set filetype=sh")

-- set hbs file type to html.handlebars
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.hbs", "*.handlebars" }, command = "set ft=html.handlebars" }
)
-- no newline at end of hbs files:
vim.api.nvim_command("autocmd FileType html.handlebars setlocal noeol binary")

-- write file without triggering autocommands (like formatting):
require("which-key").add({
  {
    "<leader>w",
    [[:noautocmd w<cr>]],
    desc = "write without formatting",
    mode = "n",
    icon = ""
  },
})

-- Caddyfile
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*Caddyfile" }, command = "set ft=caddyfile syntax=nginx" }
)

-- mdx
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.mdx" }, command = "set ft=markdown syntax=markdown" }
)

-- For ruby files:
-- See: https://github.com/testdouble/standard/wiki/IDE:-neovim
vim.opt.signcolumn = "yes" -- otherwise it bounces in and out, not strictly needed though
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice
  callback = function()
    vim.lsp.start {
      name = "standard",
      cmd = { "/opt/homebrew/opt/rbenv/shims/standardrb", "--lsp" },
    }
  end,
})

local function copy_claude_context_ref()
  -- Get the start and end line numbers of the visual selection
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  -- Get the current file path
  local file_path = vim.fn.expand('%:p')

  if file_path == '' then
    print("Error: No file is currently open")
    return
  end

  -- Get git root directory
  local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')

  if vim.v.shell_error ~= 0 then
    print("Error: Not in a git repository")
    return
  end

  -- Make file path relative to git root
  local relative_path = file_path:gsub('^' .. git_root .. '/', '')

  -- Create the formatted string
  local result
  if start_line == end_line then
    result = string.format("@%s#L%d", relative_path, start_line)
  else
    result = string.format("@%s#L%d-%d", relative_path, start_line, end_line)
  end

  -- Copy to clipboard (both + and * registers for maximum compatibility)
  vim.fn.setreg('+', result)
  vim.fn.setreg('*', result)

  print("Copied to clipboard: " .. result)
end

vim.api.nvim_create_user_command('CopyClaudeContextRef', copy_claude_context_ref, {
  range = true,
  desc = "Copy Claude context ref (with @)"
})

require("which-key").add({
  {
    "<leader>C",
    function()
      vim.fn.system(
        'tmux split-window -h "~/.claude/local/claude" \\; resize-pane -x 80')
      -- keep window open:
      --'tmux split-window -h -c "#{pane_current_path}" "~/.claude/local/claude; exec $SHELL" \\; resize-pane -x 80')
    end,
    desc = "Claude Code",
    mode = "n",
    icon = "🤖"
  },
})
