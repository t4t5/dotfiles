-- git status (diffview)
vim.keymap.set('n', '<leader>gs', '<cmd>DiffviewOpen<cr>', { desc = "git status (diffview)" })

-- lvim.builtin.which_key.mappings["g"] = {
--   name = "git",
--   s = { "<cmd>DiffviewOpen<cr>", "git status (diffview)" },
--   l = {
--     "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
--     "show line (on github)" },
--   b = { "<cmd>GB<cr>", "git blame (on github)" },
--   c = {
--     name = "git conflicts",
--     l = { "<cmd>GitConflictListQf<cr>", "list git conflicts" },
--     n = { "<cmd>GitConflictNextConflict<cr>", "go to next conflict" },
--     p = { "<cmd>GitConflictPrevConflict<cr>", "go to previous conflict" },
--     m = { "<cmd>GitConflictChooseOurs<cr>", "choose my change" },
--     t = { "<cmd>GitConflictChooseTheirs<cr>", "choose their change" },
--     b = { "<cmd>GitConflictChooseBoth<cr>", "choose both changes" },
--   }
-- }

-- git blame (with vim-gh-line)
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0
