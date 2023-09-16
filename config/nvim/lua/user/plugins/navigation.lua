return {
  -- ranger
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },

  -- nvimtree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      -- disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        git = {
          -- Include files in gitignore (like .env):
          ignore = false,
        },
        on_attach = function(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          local api = require "nvim-tree.api"
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', 'p', api.node.navigate.parent, opts('Up'))
        end
      })
    end
  },

  -- joshuto
  { "theniceboy/joshuto.nvim" },

  -- find and replace across files
  {
    "nvim-pack/nvim-spectre",
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- jump between vim/tmux
  {
    "aserowy/tmux.nvim",
    config = function() require("tmux").setup() end
  },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- jump to words with "s"
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').set_default_keymaps()
    end
  },
}
