-- Bufferline: Use real vim tabs instead of all buffers:
lvim.builtin.bufferline.options = {
  mode = "tabs",
  close_icon = '',
  buffer_close_icon = '',
  modified_icon = '~',
  diagnostics = "coc",
  separator_style = "thin",
  always_show_bufferline = false,
}

-- open/close tabs
vim.api.nvim_set_keymap("n", "tn", ":tabe<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "tx", ":tabclose<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "tb", "<C-w>T", { silent = true })

-- switch between tabs with ctrl + arrow keys
lvim.keys.normal_mode["<C-Left>"] = ":tabprevious<cr>"
lvim.keys.normal_mode["<C-Right>"] = ":tabnext<cr>"
