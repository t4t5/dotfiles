--- Some languages don't have their own LSP
--- or syntax files, so we need to configure them manually:

local comment = require('Comment.ft')

-- .env files
vim.api.nvim_command("au! BufNewFile,BufRead .env.* set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead zshrc set filetype=sh")

vim.api.nvim_command("au! BufNewFile,BufRead .cursorrules* set filetype=markdown")

-- hbs (html.handlebars)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.hbs", "*.handlebars" }, command = "set ft=html.handlebars" }
)
vim.api.nvim_command("autocmd FileType html.handlebars setlocal noeol binary") -- no newline at end of hbs files

vim.api.nvim_command("au! BufNewFile,BufRead *.conf set filetype=ini")

-- Caddyfile
vim.api.nvim_command("au! BufNewFile,BufRead *Caddyfile set ft=caddyfile syntax=nginx")

-- tmux.conf
vim.api.nvim_command("au! BufNewFile,BufRead tmux.conf set ft=tmux syntax=tmux")

-- justfile
vim.api.nvim_command("au! BufNewFile,BufRead *justfile set ft=justfile syntax=make")
comment.set('justfile', '#%s')

-- config files
vim.api.nvim_command("au! BufNewFile,BufRead *config set ft=sshconfig syntax=sshconfig")
vim.api.nvim_command("au! BufNewFile,BufRead *gitconfig set filetype=ini")

-- mdx
vim.api.nvim_command("au! BufNewFile,BufRead *.mdx set ft=markdown")

-- snippets files - disable folding to show content properly
vim.api.nvim_command("au! BufNewFile,BufRead *.snippets setlocal nofoldenable foldmethod=manual")

-- Cairo:
vim.lsp.config('cairo_lsp', {
  cmd = { 'scarb', 'cairo-language-server' },
  root_dir = vim.fs.root(0, { '.git' }),
  filetypes = { 'cairo' },
})
vim.lsp.enable('cairo_lsp')

-- FuelVM:
vim.lsp.config('sway_lsp', {
  cmd = { 'forc-lsp' },
  filetypes = { 'sway' },
  init_options = {
    logging = { level = 'trace' }
  },
  root_dir = vim.fs.root(0, { '.git' }),
  settings = {},
})
vim.lsp.enable('sway_lsp')

-- Arduino:
local MY_FQBN = "arduino:avr:uno"

vim.lsp.config('arduino_language_server', {
  cmd = {
    "arduino-language-server",
    "-cli-config", "/path/to/arduino-cli.yaml",
    "-fqbn",
    MY_FQBN
  }
})
vim.lsp.enable('arduino_language_server')

-- not working:
-- require('conform').formatters.sway = {
--   inherit = false,
--   -- command = 'echo',
--   -- args = { 'hello', 'world' },
--   command = 'forc',
--   args = { 'fmt', '-f', '$FILENAME' },
-- }
