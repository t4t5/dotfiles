local telescope_actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-j>'] = telescope_actions.move_selection_next,
        ['<C-k>'] = telescope_actions.move_selection_previous,
        ['<esc>'] = telescope_actions.close,
      },
    },
  },
}

-- Use telescope UI for code actions:
require("telescope").load_extension("ui-select")

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Show buffers:
vim.keymap.set('n', '<C-b>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

-- Show files:
vim.keymap.set('n', '<C-f>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

-- Search by grep:
vim.keymap.set('n', '<C-p>', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })

vim.keymap.set('n', '<leader>sr', '<cmd>Telescope lsp_references<cr>', { desc = "find references" })
