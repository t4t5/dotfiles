-- Diagnostic keymaps (jump to errors)
if vim.g.vscode then
  -- VSCode-specific settings
  vim.api.nvim_set_keymap('n', '<leader>ak', "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>",
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>aj', "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>",
    { noremap = true, silent = true })
else
  -- Regular Neovim settings
  vim.keymap.set('n', '<leader>ak', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
  vim.keymap.set('n', '<leader>aj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
  vim.keymap.set('n', '<leader>ae',
    function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end,
    { desc = 'Go to next error' })
end

-- Show bordered window for errors:
vim.diagnostic.config {
  float = { border = "rounded" },
}

-- Use better icons for diagnosics:
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Copy error messages:
vim.api.nvim_set_keymap('n', '<leader>e', [[:lua YankDiagnosticError()<CR>]],
  { noremap = true, silent = true, desc = "copy error" })

function YankDiagnosticError()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid()    -- get the window ID of the floating window
  vim.cmd("normal! j")                 -- move down one row
  vim.cmd("normal! VG")                -- select everything from that row down
  vim.cmd("normal! y")                 -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end
