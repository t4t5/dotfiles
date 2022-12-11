-- general
lvim.leader = ","

-- relative line numbers:
vim.api.nvim_command("set relativenumber")

-- open splits with vv:
vim.api.nvim_set_keymap("n", "vv", ":vnew<cr>", { noremap = true, silent = true })

lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "onedark"

lvim.keys.normal_mode = {
  -- Better window movement
  ["<C-h>"] = "<C-w>h",
  ["<C-j>"] = "<C-w>j",
  ["<C-k>"] = "<C-w>k",
  ["<C-l>"] = "<C-w>l",
}

lvim.keys.normal_mode["<C-f>"] = ":Telescope git_files<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
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

lvim.builtin.telescope.pickers = { find_files = { find_command = {
  "rg", "--files", "--hidden", "-g", "!.git",
}}}

-- Gitsigns
lvim.builtin.gitsigns.opts.signs = {
  add = { text = "+" },
  change = { text = "~" },
  changedelete = { text = "~" },
  topdelete = { text = "_" },
  delete = { text = "_" },
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

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings
-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- da

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "aserowy/tmux.nvim",
    config = function() require("tmux").setup() end
  },
}
