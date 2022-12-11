-- general
lvim.leader = ","
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "onedark"

-- relative line numbers:
vim.api.nvim_command("set relativenumber")
-- always use system clipboard to paste from:
vim.opt.clipboard = "unnamed"

-- show vim error messages on startup:
-- https://github.com/LunarVim/LunarVim/issues/3502
vim.schedule(function()
  vim.cmd "messages"
end)

-- open splits with vv:
vim.api.nvim_set_keymap("n", "vv", ":vnew<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "--", ":new<cr>", { noremap = true, silent = true })

-- stop highlighting last search:
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>", { noremap = true, silent = true })

-- basic navigation
lvim.keys.normal_mode = {
  -- better window movement
  ["<C-h>"] = "<C-w>h",
  ["<C-j>"] = "<C-w>j",
  ["<C-k>"] = "<C-w>k",
  ["<C-l>"] = "<C-w>l",
  -- resize windows with arrow keys
  ["<left>"] = ":vertical resize -10<cr>",
  ["<right>"] = ":vertical resize +10<cr>",
}

----------- telescope ---------------------
-- find files = <C-f>
lvim.keys.normal_mode["<C-f>"] = ":Telescope git_files<cr>"
-- fuzzy grep = <C-p>
lvim.keys.normal_mode["<C-p>"] = ":Telescope live_grep<cr>"
-- buffers = <C-b>
lvim.keys.normal_mode["<C-b>"] = ":Telescope buffers<cr>"
-- move through suggestions = <C-j>/<C-k>
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
 -- for input mode
 i = {
   ["<C-j>"] = actions.move_selection_next,
   ["<C-k>"] = actions.move_selection_previous,
   ["<C-n>"] = actions.cycle_history_next,
   ["<C-p>"] = actions.cycle_history_prev,
   ["<esc>"] = actions.close,
 },
 -- for normal mode
 n = {
   ["<C-j>"] = actions.move_selection_next,
   ["<C-k>"] = actions.move_selection_previous,
 },
}
-- filter results:
lvim.builtin.telescope.pickers = {
  -- don't show all files
  find_files = { find_command = {
    "rg", "--files", "--hidden", "-g", "!.git",
  }},
  buffers = { sort_lastused = true, ignore_current_buffer = true },
}

----------- tabs ---------------------
-- Bufferline: Use real vim tabs instead of all buffers:
lvim.builtin.bufferline.options = {
  mode = "tabs",
  close_icon = '',
  buffer_close_icon = '',
  modified_icon = '~',
  diagnostics = "coc",
  separator_style = "thin",
  always_show_bufferline = false
}
-- open/close tabs
vim.api.nvim_set_keymap("n", "tn", ":tabe<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "tx", ":tabclose<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "tb", "<C-w>T", { silent = true })
-- switch between tabs with ctrl + arrow keys
lvim.keys.normal_mode["<C-Left>"] = ":tabprevious<cr>"
lvim.keys.normal_mode["<C-Right>"] = ":tabnext<cr>"

----------- git ---------------------
lvim.builtin.gitsigns.opts.signs = {
  add = { text = "+" },
  change = { text = "~" },
  changedelete = { text = "~" },
  topdelete = { text = "_" },
  delete = { text = "_" },
}
-- git status (diffview)
lvim.builtin.which_key.mappings["g"] = {
  name = "git",
  s = { "<cmd>DiffviewOpen<cr>", "git status (diffview)" },
  l = { "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", "show on github"}
}
-- git blame (with vim-gh-line)
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0
vim.g.gh_line_blame_map = '<leader>gb'

----------- leader commands ---------------------
-- ranger (rnvimr)
lvim.builtin.which_key.mappings["r"] = { "<cmd>RnvimrToggle<cr>", "Ranger" }
-- find and replace:
lvim.builtin.which_key.mappings.f = nil
lvim.builtin.which_key.mappings["f"] = {
  name = "find and replace",
  f = { "<cmd>lua require('spectre').open()<cr>", "find and replace across files" },
  r = { ":%s/<C-r>h", "find and replace in single file" },
}
-- go to errors:
lvim.builtin.which_key.mappings["a"] = {
  name = "Diagnostics",
  j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next" },
  k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev" },
}

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings
-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- da

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "aserowy/tmux.nvim", -- jump to tmux windows
    config = function() require("tmux").setup() end
  },
  { "kevinhwang91/rnvimr", -- ranger
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  { "github/copilot.vim" },
  { "hrsh7th/cmp-copilot" },
  { "windwp/nvim-spectre" }, -- find and replace across files
  { "sindrets/diffview.nvim" }, -- git status
  { "ruanyl/vim-gh-line" }, -- open blame in github
  { "ruifm/gitlinker.nvim" }, -- open file in github
  { "f-person/git-blame.nvim" }, -- show last commit per line in editor
  { "chaoren/vim-wordmotion" }, -- respect camelcase/underscores
}
