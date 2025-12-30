return {
  -- startup screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("user.startify").setup()
    end
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight-night]]
    end,
  },

  -- simple toast system:
  {
    'rcarriga/nvim-notify',
    config = function()
      local nvim_notify = require 'notify'
      nvim_notify.setup {
        stages = 'fade',
        render = 'wrapped-default',
      }

      -- Redirect all LSP errors to a less intrusive location
      vim.notify = function(msg, level, opts)
        return nvim_notify(msg, level, opts)
      end
    end,
  },

  -- telescope for code action
  -- { "malbertzard/telescope-ui-select.nvim" },

  -- better ui for select etc
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  -- Bufferline:
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- Show color preview for hex strings
  {
    'catgoose/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- Show indentation guides (┊)
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      if not vim.g.vscode then
        local ibl = require 'ibl'

        ibl.setup {
          indent = { char = '┊', highlight = 'LineNr' },
        }
      end
    end,
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      if not vim.g.vscode then
        local colors = require('tokyonight.colors').setup()

        require('scrollbar').setup {
          handle = {
            color = colors.fg_gutter,
          },
          handlers = {
            cursor = false,
            diagnostic = false,
            gitsigns = false,
            handle = true,
            search = false,
            ale = false,
          },
        }
      end
    end,
  },
}
