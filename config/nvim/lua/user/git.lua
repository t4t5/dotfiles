-- git status (diffview)
if vim.g.vscode then
  vim.keymap.set('n', '<leader>gs', "<Cmd>call VSCodeNotify('workbench.view.scm')<CR>")
else
  vim.keymap.set('n', '<leader>gs', '<cmd>DiffviewOpen<cr>', { desc = "git status (diffview)" })
end

-- git blame (with vim-gh-line)
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0
