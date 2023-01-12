-- open splits with vv:
vim.api.nvim_set_keymap("n", "vv", ":vnew<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "--", ":new<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tt", ":LspRestart<cr>", { noremap = true, silent = true })

-- find and replace:
-- these don't show a preview in the command bar if we use <leader>:
vim.api.nvim_set_keymap("n", "fr", ":%s//g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "fr", ":s//g<left><left>", { noremap = true })

-- stop highlighting last search:
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>", { noremap = true, silent = true })

-- play macros with <space>:
vim.api.nvim_set_keymap("n", "<space>", "@q", { noremap = true, silent = true })

lvim.keys.normal_mode = {
  -- better window movement
  ["<C-h>"] = "<C-w>h",
  ["<C-j>"] = "<C-w>j",
  ["<C-k>"] = "<C-w>k",
  ["<C-l>"] = "<C-w>l",
  -- resize windows with arrow keys
  ["<left>"] = ":vertical resize -10<cr>",
  ["<right>"] = ":vertical resize +10<cr>",
  -- center cursor when jumping up/down
  ["<C-d>"] = "<C-d>zz",
  ["<C-u>"] = "<C-u>zz",
}

----------- leader commands ---------------------
-- ranger (rnvimr)
lvim.builtin.which_key.mappings["r"] = { "<cmd>RnvimrToggle<cr>", "Ranger" }

-- find and replace:
lvim.builtin.which_key.mappings.f = nil
lvim.builtin.which_key.mappings.w = nil

lvim.builtin.which_key.mappings["f"] = {
  name = "find and replace",
  f = { "<cmd>lua require('spectre').open()<cr>", "find and replace across files" },
}

-- view all installable treesitter libraries
lvim.builtin.which_key.mappings.T.l = { "<cmd>TSInstallInfo<cr>", "view all installable Treesitter packages" }

-- search Google:
lvim.builtin.which_key.mappings.s.s = { "<cmd>OpenURL https://google.com<cr>", "Open Google" }

-- search ChatGPT:
lvim.builtin.which_key.mappings.s.a = { "<cmd>OpenURL https://chat.openai.com/chat<cr>", "Open ChatGPT" }

-- disable lunarvim buffer defaults
lvim.builtin.which_key.mappings.b = nil
lvim.builtin.which_key.mappings.c = nil
lvim.builtin.which_key.mappings["/"] = nil
lvim.builtin.which_key.mappings.h = nil -- disable "no highlight" action
lvim.builtin.which_key.mappings.q = nil -- disable "quit" action

-- disable some lunarvim search defaults:
lvim.builtin.which_key.mappings.s.r = nil -- disable recent file
lvim.builtin.which_key.mappings.s.M = nil -- disable MAN pages
lvim.builtin.which_key.mappings.s.f = nil -- disable telescope (using <C-f> instead)
lvim.builtin.which_key.mappings.s.t = nil -- disable live grep (using <C-p> instead)
lvim.builtin.which_key.mappings.s.H = nil -- disable highlight group

-- find references (gr)
lvim.builtin.which_key.mappings.s.r = { "<cmd>Telescope lsp_references<cr>", "find references" }

-- undotree
lvim.builtin.which_key.mappings.u = { "<cmd>UndotreeToggle<cr>", "UndoTree" }

-- <leader>t mapping:
lvim.builtin.which_key.mappings["t"] = {
  name = "test",
  f = { "<cmd>TestFile<cr>", "test current file" },
  n = { "<cmd>TestNearest<cr>", "test nearest" },
}
