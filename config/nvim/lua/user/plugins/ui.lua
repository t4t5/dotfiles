return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup({
        style = 'moon',
        on_colors = function(colors)
          -- colors are here: https://github.com/folke/tokyonight.nvim/discussions/453
          colors.border = colors.dark3
        end
      })

      if not vim.g.vscode then
        vim.cmd [[colorscheme tokyonight]]
      end
    end
  },

  -- simple toast system:
  {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({
        stages = "fade",
        render = "minimal",
      })
    end
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
    }
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

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
    main = "ibl",
    opts = {},
    config = function()
      local ibl = require("ibl")

      ibl.setup({
        indent = { char = '┊', highlight = "LineNr" }
      })
    end
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      if not vim.g.vscode then
        local colors = require("tokyonight.colors").setup()

        require("scrollbar").setup({
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
        })
      end
    end
  }
}
