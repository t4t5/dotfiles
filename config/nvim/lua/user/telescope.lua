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

function ShowBuffers()
  require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })
end

-- Show buffers:
vim.keymap.set('n', '<C-b>', ShowBuffers, { desc = '[ ] Find existing buffers' })

-- Show files:
vim.keymap.set('n', '<C-f>', ':lua require("telescope.builtin").find_files({ hidden = true })<cr>',
  { desc = '[S]earch [F]iles' })

-- Search by grep:
vim.keymap.set('n', '<C-p>', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })

-- Show clipboard history
vim.keymap.set('n', '<leader>lc', '<cmd>Telescope neoclip<cr>', { desc = 'Clipboard history' })

-- Show macros history
vim.keymap.set('n', '<leader>lm', require('telescope').extensions.macroscope.default, { desc = 'Macros history' })
