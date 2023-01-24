-- better highlighting with Treesitter
lvim.builtin.treesitter.highlight.enable = true

-- go to errors:
lvim.builtin.which_key.mappings["a"] = {
  name = "Diagnostics",
  j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
  k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev diagnostic" },
}
-- show documentation:
lvim.builtin.which_key.mappings["k"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show documentation" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "glimmer",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "html",
  "rust",
  "ruby",
  "yaml",
  "prisma",
}

-- formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettier",
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html.handlebars" } },
}

-- linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } }
}

-- set hbs file type to html.handlebars
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.hbs", "*.handlebars" }, command = "set ft=html.handlebars" }
)
-- no newline at end of hbs files:
vim.api.nvim_command("autocmd FileType html.handlebars setlocal noeol binary")

-- Set syntax highlighting for .env.local, .env.development, .env.production...
vim.api.nvim_command("au! BufNewFile,BufRead .env.* set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead zshrc set filetype=sh")

-- show suggestions:
lvim.keys.insert_mode["<C-c>"] = "<cmd>lua require('cmp').complete()<cr>"

-- github copilot
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
