-- Lunarvim Options
lvim.leader = ","
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "tokyonight-moon"

-- relative line numbers:
vim.api.nvim_command("set relativenumber")

-- always use system clipboard to paste from:
vim.opt.clipboard = "unnamedplus"

-- wrap long lines
vim.opt.wrap = true

-- disable mouse:
vim.opt.mouse = ""

-- split to left
vim.opt.splitright = false

-- wordmotion
-- make sure cW doesn't include special chars
vim.g.wordmotion_spaces = "['_']"
vim.g.wordmotion_uppercase_spaces = "['-', '.', ',', '<', '>', '(', ')', '[', ']', '{', '}', '&', '*', '=', '!', '+', ';', ':', '/', '\"']"
