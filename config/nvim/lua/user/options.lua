vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.wo.relativenumber = true

-- Use 2 spaces by default for tabs:
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- Disable swap files, they're annoying:
vim.opt.swapfile = false

-- Highlight current line:
vim.opt.cursorline = true

-- Make line numbers default
vim.wo.number = true

-- disable mouse:
vim.opt.mouse = ""

-- wrap long lines
vim.opt.wrap = true

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
vim.o.undofile = true

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
