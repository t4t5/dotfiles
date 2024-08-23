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
vim.api.nvim_set_keymap("v", "<space>", ":<C-U>'<,'>norm! @q<CR>", { noremap = true, silent = true })

-- better window movement (supporting tmux)
vim.keymap.set("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })

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
  desc = "Find + replace (spectre)"
  -- Use <leader>R to replace
})

-- Toggle file tree:
if vim.g.vscode then
  vim.api.nvim_set_keymap('n', ',t', '<Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>',
    { noremap = true, silent = true })
else
  vim.keymap.set('n', '<leader>t', "<cmd>NvimTreeToggle<cr>", {
    desc = "Tree (toggle explorer)",
  })
end

-- Joshuto
vim.keymap.set('n', '<leader>r', function() require("joshuto").joshuto({ edit_in_tab = true }) end,
  { desc = "Ranger (Joshuto)" })

-- Set group names for which-key:
require("which-key").register({
  ["<leader>j"] = {
    name = "jump (go to)"
  },
  ["<leader>g"] = {
    name = "git"
  },
  ["<leader>a"] = {
    name = "diagnostics"
  },
  ["<leader>l"] = {
    name = "list"
  },
})
