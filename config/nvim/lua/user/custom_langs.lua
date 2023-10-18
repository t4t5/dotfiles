--- Some languages don't have their own LSP
--- or syntax files, so we need to configure them manually:

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local comment = require('Comment.ft')

-- .env files
vim.api.nvim_command("au! BufNewFile,BufRead .env.* set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead zshrc set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead *.conf set filetype=ini")

-- hbs (html.handlebars)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.hbs", "*.handlebars" }, command = "set ft=html.handlebars" }
)
vim.api.nvim_command("autocmd FileType html.handlebars setlocal noeol binary") -- no newline at end of hbs files

-- Caddyfile
vim.api.nvim_command("au! BufNewFile,BufRead *Caddyfile set ft=caddyfile syntax=nginx")

-- tmux.conf
vim.api.nvim_command("au! BufNewFile,BufRead tmux.conf set ft=tmux syntax=tmux")

-- justfile
vim.api.nvim_command("au! BufNewFile,BufRead *justfile set ft=justfile syntax=make")
comment.set('justfile', '#%s')

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
