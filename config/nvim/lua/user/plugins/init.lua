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
  { import = 'user.plugins.lualine' },
  { import = 'user.plugins.git' },
  { import = 'user.plugins.ui' },
  { import = 'user.plugins.navigation' },
  { import = 'user.plugins.ai' },
  { import = 'user.plugins.testing' },
  { import = 'user.plugins.misc' },
}, {})
