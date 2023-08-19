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
  { import = 'user.plugins.git' },
  { import = 'user.plugins.ui' },
  { import = 'user.plugins.navigation' },

  -- respect camelcase/underscores
  { 'chaoren/vim-wordmotion' },

  -- Detect tabstop and shiftwidth automatically:
  { 'tpope/vim-sleuth' },

  -- startup screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("user.plugins.startify").setup()
    end
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- clipboard + macro history in telescope
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('neoclip').setup({
        -- sync with unnamedplus
        default_register = { '+', '*', '"' },
        keys = {
          telescope = {
            i = {
              -- to prevent overriding of <c-k>
              paste_behind = '<c-P>',
            }
          },
        }
      })
      require('telescope').load_extension('neoclip')
    end,
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

  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    -- Don't add "config" here, or neovim will take a long time to load
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

  -- run tests
  {
    "klen/nvim-test",
    config = function()
      require("nvim-test").setup({})
      require('nvim-test.runners.jest'):setup {
        command = "./node_modules/.bin/vitest",
      }
    end
  },
}, {})
