-- git status (diffview)
vim.keymap.set('n', '<leader>gs', '<cmd>DiffviewOpen<cr>', { desc = "git status (diffview)" })

-- git blame (with vim-gh-line)
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0
