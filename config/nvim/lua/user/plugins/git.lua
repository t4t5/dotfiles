return {
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      changedelete = { text = "~" },
      topdelete = { text = "_" },
      delete = { text = "_" },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '[[', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
      vim.keymap.set('n', ']]', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
      vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
    end,
  },

  { "sindrets/diffview.nvim" },  -- git status
  { "ruanyl/vim-gh-line" },      -- open blame in github
  { "f-person/git-blame.nvim" }, -- show last commit per line in editor
  {
    "tpope/vim-fugitive",        -- needed for vim-conflicted
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },

}
