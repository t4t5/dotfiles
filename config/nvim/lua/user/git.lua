-- git status (diffview)
if vim.g.vscode then
  vim.keymap.set('n', '<leader>gs', "<Cmd>call VSCodeNotify('workbench.view.scm')<CR>")
else
  require("which-key").add({
    {
      "<leader>gs",
      '<cmd>DiffviewOpen<cr>',
      desc = "git status",
      mode = "n",
      icon = ""
    },
  })
end

-- git blame (with vim-gh-line)
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0

require("which-key").add({
  {
    "<leader>gb",
    desc = "blame on github",
    mode = "n",
    icon = ""
  },
  {
    "<leader>gh",
    desc = "show line in github",
    mode = "n",
    icon = ""
  },
  {
    "<leader>go",
    desc = "open repo on github",
    mode = "n",
    icon = ""
  },
})
