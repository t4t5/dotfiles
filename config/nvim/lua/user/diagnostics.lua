-- Diagnostic keymaps (jump to errors)
if vim.g.vscode then
  -- VSCode-specific settings
  vim.api.nvim_set_keymap('n', '<leader>ak', "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>",
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>aj', "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>",
    { noremap = true, silent = true })
else
  -- Regular Neovim settings
  require("which-key").add({
    {
      "<leader>ak",
      vim.diagnostic.goto_prev,
      desc = "go to previous diagnostic",
      mode = "n",
      icon = "󰒮"
    },
    {
      "<leader>aj",
      vim.diagnostic.goto_next,
      desc = "go to next diagnostic",
      mode = "n",
      icon = "󰒭"
    },
    {
      "<leader>ae",
      function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end,
      desc = "go to next error",
      mode = "n",
      icon = ""
    },
    {
      "<leader>ay",
      vim.diagnostic.enable,
      desc = "enable diagnostics",
      mode = "n",
      icon = ""
    },
    {
      "<leader>an",
      vim.diagnostic.enable,
      desc = "disable diagnostics",
      mode = "n",
      icon = ""
    },
  })
end

-- Show bordered window for errors:
vim.diagnostic.config {
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
}

