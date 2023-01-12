lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "aserowy/tmux.nvim", -- jump to tmux windows
    config = function() require("tmux").setup() end
  },
  { "kevinhwang91/rnvimr", -- ranger
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  { "github/copilot.vim" },
  { "hrsh7th/cmp-copilot" },
  { "windwp/nvim-spectre" }, -- find and replace across files
  { "sindrets/diffview.nvim" }, -- git status
  { "ruanyl/vim-gh-line" }, -- open blame in github
  { "ruifm/gitlinker.nvim" }, -- open file in github (works better than vim-gh-line)
  { "f-person/git-blame.nvim" }, -- show last commit per line in editor
  { "chaoren/vim-wordmotion" }, -- respect camelcase/underscores
  { "ggandor/leap.nvim", -- jump to words with "s"
    config = function()
      require('leap').set_default_keymaps()
    end
  },
  { "klen/nvim-test", -- run tests
    config = function()
      require('nvim-test').setup()
    end
  },
  { "nvim-telescope/telescope-ui-select.nvim" }, -- telescope for code action
  { "wesQ3/vim-windowswap" }, -- swap windows with <leader>ww
  { "dhruvasagar/vim-open-url" },
  { "mbbill/undotree" },
  { "akinsho/git-conflict.nvim",
    config = function()
      require('git-conflict').setup()
    end
  },
  {
    "tpope/vim-fugitive", -- needed for vim-conflicted
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
  { "norcalli/nvim-colorizer.lua",
    config = function()
      require 'colorizer'.setup()
    end
  }
}
