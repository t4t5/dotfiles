require "user.options"
require "user.mappings"
require "user.plugins"
require "user.lsp"
require "user.telescope"
require "user.goodies"
require "user.tabs"

vim.keymap.set('n', '<leader>r', "<cmd>RnvimrToggle<cr>")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
