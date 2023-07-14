return {
  -- Theme:
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end
  },

  -- telescope for code action
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- Bufferline:
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',                   opts = {} },

  -- Show color preview for hex strings
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup()
    end
  },

  -- Show indentation guides (┊)
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      local colors = require("tokyonight.colors").setup()

      require("scrollbar").setup({
        handle = {
          color = colors.bg_highlight,
        },
        handlers = {
          cursor = false,
          diagnostic = false,
          gitsigns = false,
          handle = true,
          search = false,
          ale = false,
        },
      })
    end
  }
}
