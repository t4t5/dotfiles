return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'linrongbin16/lsp-progress.nvim',
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      component_separators = '|',
      section_separators = '',
    },
    -- for windows not in focus:
    inactive_sections = {
      lualine_a = {},
      lualine_b = {
        { 'filename', path = 1 },
      },
      lualine_c = {},
      lualine_x = {}
    },
    -- window in focus:
    sections = {
      -- lualine_a = { 'mode' },
      lualine_a = {},
      lualine_b = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = '',
            readonly = '',
            unnamed = 'unnamed',
          }
        }
      },
      lualine_c = {},
      lualine_x = {
        {
          function()
            local ok, kulala = pcall(require, 'kulala')
            if not ok then return '' end

            local env = kulala.get_selected_env()
            if env and env ~= '' then
              return '🐨 ' .. env
            end
            return ''
          end,
          cond = function()
            return vim.bo.filetype == 'http'
          end,
          color = { fg = '#7aa2f7', gui = 'bold' },
        },
        "require('lsp-progress').progress()"
      },
      lualine_y = {
        {
          'diagnostics',
          sources = { 'nvim_lsp' },
          sections = { 'error', 'warn', 'info', 'hint' },
          symbols = {
            error = '✘ ',
            warn = '⚠ ',
            info = 'ⓘ  ',
            hint = 'ⓘ  '
          },
          colored = true,
          always_visible = false,
        }
      },
      lualine_z = { 'filetype' },
    }
  },
}
