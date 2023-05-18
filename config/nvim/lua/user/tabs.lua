-- Bufferline: Use real vim tabs instead of all buffers:
require("bufferline").setup {
  options = {
    mode = "tabs",
    close_icon = '',
    buffer_close_icon = '',
    modified_icon = '~',
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    always_show_bufferline = false,
  }
}

-- open/close tabs
vim.api.nvim_set_keymap("n", "tn", ":tabe<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "tx", ":tabclose<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "tb", "<C-w>T", { silent = true })

-- switch between tabs with ctrl + arrow keys
vim.keymap.set('n', "<C-Left>", ":tabprevious<cr>")
vim.keymap.set('n', "<C-Right>", ":tabnext<cr>")
