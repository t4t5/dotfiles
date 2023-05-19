-- Install package manager (lazy.nvim)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Plugins:
require('lazy').setup({
  { import = 'user.plugins.lsp' },
  { import = 'user.plugins.autoformat' },
  { import = 'user.plugins.lualine' },
  { import = 'user.plugins.gitsigns' },

  -- telescope for code action
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- respect camelcase/underscores
  { "chaoren/vim-wordmotion" },

  -- swap windows with <leader>ww
  { "wesQ3/vim-windowswap" },

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

  -- Bufferline:
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },

  -- Detect tabstop and shiftwidth automatically:
  'tpope/vim-sleuth',

  -- Theme:
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end
  },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("user.plugins.startify").setup()
    end
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    "kevinhwang91/rnvimr", -- ranger
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "aserowy/tmux.nvim", -- jump to tmux windows
    config = function() require("tmux").setup() end
  },

  -- GitHub Copilot:
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
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
}, {})


-- Spectre (find and replace across files)
vim.keymap.set('n', '<leader>F', require("spectre").open, {
  desc = "Open Spectre"
})
