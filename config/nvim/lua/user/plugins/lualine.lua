return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'filename',
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
