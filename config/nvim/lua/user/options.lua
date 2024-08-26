vim.g.mapleader = ','

vim.wo.relativenumber = true

-- Use 2 spaces by default for tabs:
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Recommended by avante.nvim:
-- vim.opt.laststatus = 3
-- vim.opt.splitkeep = "screen"

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

-- Disable swap files, they're annoying:
vim.opt.swapfile = false

-- Highlight current line:
-- vim.opt.cursorline = true

-- Make line numbers default
vim.wo.number = true

-- disable mouse:
-- vim.opt.mouse = ""

-- wrap long lines
vim.opt.wrap = true

-- don't use syntax highlighting for very wide files
-- (e.g. minified JSON files)
vim.opt.synmaxcol = 500
vim.api.nvim_command("syntax sync minlines=256")

-- wordmotion
-- make sure cW doesn't include special chars
vim.g.wordmotion_spaces = "['_']"
vim.g.wordmotion_uppercase_spaces =
"['-', '.', ',', '<', '>', '(', ')', '[', ']', '{', '}', '&', '*', '=', '!', '+', ';', ':', '/', '\"']"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
-- vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
