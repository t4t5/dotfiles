--- Some languages don't have their own LSP
--- or syntax files, so we need to configure them manually:

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local comment = require('Comment.ft')

-- .env files
vim.api.nvim_command("au! BufNewFile,BufRead .env.* set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead zshrc set filetype=sh")

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

-- Noir:
vim.api.nvim_command("au! BufNewFile,BufRead *.nr set ft=noir syntax=rust")

if not configs.noir_lsp then
  configs.noir_lsp = {
    default_config = {
      cmd = { 'nargo', 'lsp' },
      root_dir = lspconfig.util.root_pattern('.git'),
      filetypes = { 'noir' },
    },
  }
end

lspconfig.noir_lsp.setup {}

comment.set('noir', '//%s')

-- Cairo:
if not configs.cairo_lsp then
  configs.cairo_lsp = {
    default_config = {
      cmd = { 'scarb', 'cairo-language-server' },
      root_dir = lspconfig.util.root_pattern('.git'),
      filetypes = { 'cairo' },
    },
  }
end

lspconfig.cairo_lsp.setup {}

-- FuelVM:
if not configs.sway_lsp then
  configs.sway_lsp = {
    default_config = {
      cmd = { 'forc-lsp' },
      filetypes = { 'sway' },
      init_options = {
        logging = { level = 'trace' }
      },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end,
      settings = {},
    },
  }
end

lspconfig.sway_lsp.setup {}

-- Arduino:
local MY_FQBN = "arduino:avr:uno"

lspconfig.arduino_language_server.setup {
  cmd = {
    "arduino-language-server",
    "-cli-config", "/path/to/arduino-cli.yaml",
    "-fqbn",
    MY_FQBN
  }
}

-- not working:
-- require('conform').formatters.sway = {
--   inherit = false,
--   -- command = 'echo',
--   -- args = { 'hello', 'world' },
--   command = 'forc',
--   args = { 'fmt', '-f', '$FILENAME' },
-- }
