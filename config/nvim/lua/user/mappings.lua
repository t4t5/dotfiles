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
vim.api.nvim_set_keymap("v", "<space>", "'<,'>normal @q", { noremap = true, silent = true })

-- better window movement
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- resize windows with arrow keys
vim.keymap.set('n', '<left>', ':vertical resize -10<cr>')
vim.keymap.set('n', '<right>', ':vertical resize +10<cr>')

-- center cursor when jumping up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- test file
vim.keymap.set('n', '<leader>T', "<cmd>TestFile<cr>", {
  desc = "Test file"
})

-- Spectre (find and replace across files)
vim.keymap.set('n', '<leader>F', require("spectre").open, {
  desc = "Open Spectre"
  -- Use <leader>R to replace
})

-- Ranger
vim.keymap.set('n', '<leader>r', "<cmd>RnvimrToggle<cr>")
