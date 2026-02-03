-- Load colorscheme from Omarchy theme
local function load_omarchy_theme()
  local theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
  if vim.fn.filereadable(theme_path) == 1 then
    local ok, theme_spec = pcall(dofile, theme_path)
    if ok and type(theme_spec) == "table" then
      local plugins = {}
      local colorscheme = nil

      for _, spec in ipairs(theme_spec) do
        if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
          colorscheme = spec.opts.colorscheme
        else
          -- Add the plugin spec, but we'll set the colorscheme in config
          table.insert(plugins, spec)
        end
      end

      -- Add config to the first plugin to set colorscheme
      if colorscheme and #plugins > 0 then
        plugins[1].lazy = false
        plugins[1].config = function()
          vim.cmd("colorscheme " .. colorscheme)
        end
      end

      return plugins
    end
  end

  -- Fallback to tokyonight if no Omarchy theme found
  return {
    {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd [[colorscheme tokyonight-night]]
      end,
    }
  }
end

local theme_plugins = load_omarchy_theme()

return vim.list_extend(theme_plugins, {
  -- startup screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("user.startify").setup()
    end
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
        -- Get scrollbar color from current colorscheme's LineNr highlight
        local function get_scrollbar_color()
          local hl = vim.api.nvim_get_hl(0, { name = "LineNr" })
          if hl.fg then
            return string.format("#%06x", hl.fg)
          end
          return "#3b4261" -- fallback
        end

        require('scrollbar').setup {
          handle = {
            color = get_scrollbar_color(),
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
})
