return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'tokyonight-moon',
      component_separators = '|',
      section_separators = '',
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {
        { 'filename', path = 1 },
      },
      lualine_c = {},
      lualine_x = {}
    },
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
      lualine_y = { 'filetype' },
      lualine_z = {}
    }
  },
}
