-- show vim error messages on startup:
-- https://github.com/LunarVim/LunarVim/issues/3502
vim.schedule(function()
  vim.cmd "messages"
end)

----------- general settings -----------
lvim.leader = ","
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "tokyonight-moon"

-- relative line numbers:
vim.api.nvim_command("set relativenumber")
-- always use system clipboard to paste from:
vim.opt.clipboard = "unnamedplus"

-- wrap long lines
vim.opt.wrap = true

-- disable mouse:
vim.opt.mouse = ""

-- split to left
vim.opt.splitright = false

----------- mappings ----------
-- open splits with vv:
vim.api.nvim_set_keymap("n", "vv", ":vnew<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "--", ":new<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tt", ":LspRestart<cr>", { noremap = true, silent = true })

-- find and replace:
-- these don't show a preview in the command bar if we use <leader>:
vim.api.nvim_set_keymap("n", "fr", ":%s//g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "fr", ":s//g<left><left>", { noremap = true })

-- stop highlighting last search:
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>", { noremap = true, silent = true })

-- play macros with <space>:
vim.api.nvim_set_keymap("n", "<space>", "@q", { noremap = true, silent = true })

lvim.keys.normal_mode = {
  -- better window movement
  ["<C-h>"] = "<C-w>h",
  ["<C-j>"] = "<C-w>j",
  ["<C-k>"] = "<C-w>k",
  ["<C-l>"] = "<C-w>l",
  -- resize windows with arrow keys
  ["<left>"] = ":vertical resize -10<cr>",
  ["<right>"] = ":vertical resize +10<cr>",
  -- center cursor when jumping up/down
  ["<C-d>"] = "<C-d>zz",
  ["<C-u>"] = "<C-u>zz",
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
  } },
  buffers = { sort_lastused = true, ignore_current_buffer = true },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "ui-select")
end

----------- tabs ---------------------
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
  l = { "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
    "show on github" },
  c = {
    name = "git conflicts",
    l = { "<cmd>GitConflictListQf<cr>", "list git conflicts" },
    n = { "<cmd>GitConflictNextConflict<cr>", "go to next conflict" },
    p = { "<cmd>GitConflictPrevConflict<cr>", "go to previous conflict" },
    m = { "<cmd>GitConflictChooseOurs<cr>", "choose my change" },
    t = { "<cmd>GitConflictChooseTheirs<cr>", "choose their change" },
    b = { "<cmd>GitConflictChooseBoth<cr>", "choose both changes" },
  }
}
-- git blame (with vim-gh-line)
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0
vim.g.gh_line_blame_map = '<leader>gb'

-- make sure cW doesn't include special chars
vim.g.wordmotion_spaces = "['_']"
vim.g.wordmotion_uppercase_spaces = "['-', '.', ',', '<', '>', '(', ')', '[', ']', '{', '}', '&', '*', '=', '!', '+', ';', ':', '/', '\"']"

----------- leader commands ---------------------
-- ranger (rnvimr)
lvim.builtin.which_key.mappings["r"] = { "<cmd>RnvimrToggle<cr>", "Ranger" }
-- find and replace:
lvim.builtin.which_key.mappings.f = nil
lvim.builtin.which_key.mappings.w = nil

-- view all installable treesitter libraries
lvim.builtin.which_key.mappings.T.l = { "<cmd>TSInstallInfo<cr>", "view all installable Treesitter packages" }

-- open Google/StackOverflow/ChatGPT
lvim.builtin.which_key.mappings.s.s = { "<cmd>OpenURL https://google.com<cr>", "Open Google" }
lvim.builtin.which_key.mappings.s.a = { "<cmd>OpenURL https://chat.openai.com/chat<cr>", "Open ChatGPT" }

-- disable some lunarvim search defaults:
lvim.builtin.which_key.mappings.s.r = nil -- disable recent file
lvim.builtin.which_key.mappings.s.M = nil -- disable MAN pages
lvim.builtin.which_key.mappings.s.f = nil -- disable telescope (using <C-f> instead)
lvim.builtin.which_key.mappings.s.t = nil -- disable live grep (using <C-p> instead)
lvim.builtin.which_key.mappings.s.H = nil -- disable highlight group
-- find references (gr)
lvim.builtin.which_key.mappings.s.r = { "<cmd>Telescope lsp_references<cr>", "find references" }

----------- lsp --------
lvim.builtin.treesitter.highlight.enable = true

-- go to errors:
lvim.builtin.which_key.mappings["a"] = {
  name = "Diagnostics",
  j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next" },
  k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev" },
}
-- show documentation:
lvim.builtin.which_key.mappings["k"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show documentation" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "glimmer",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "html",
  "rust",
  "ruby",
  "yaml",
  "prisma",
}

-- formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettierd",
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html.handlebars" } },
}

-- linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } }
}

-- set hbs file type to html.handlebars
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.hbs", "*.handlebars" }, command = "set ft=html.handlebars" }
)
-- no newline at end of hbs files:
vim.api.nvim_command("autocmd FileType html.handlebars setlocal noeol binary")

-- show suggestions:
lvim.keys.insert_mode["<C-c>"] = "<cmd>lua vim.lsp.omnifunc()<cr>"

---------- lualine --------
lvim.builtin.lualine.sections.lualine_b = {
  { 'filename', path = 1 }
}
lvim.builtin.lualine.sections.lualine_y = {}
lvim.builtin.lualine.sections.lualine_z = {}

----------- github copilot ---------------------
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

----------- testing (nvim-test) -----------------
-- vitest:
require('nvim-test.runners.jest'):setup {
  command = "./node_modules/.bin/vitest",
}
-- rspec:
require('nvim-test.runners.rspec'):setup({
  command = "bundle",
  args = { "exec", "rspec" },
})
-- <leader>t mapping:
lvim.builtin.which_key.mappings["t"] = {
  name = "test",
  f = { "<cmd>TestFile<cr>", "test current file" },
  n = { "<cmd>TestNearest<cr>", "test nearest" },
}

-- luasnip
function OpenLuaSnipFile()
  local snippet_file = vim.bo.filetype .. '.snippets'
  local path = '~/dotfiles/config/lvim/luasnippets/' .. snippet_file
  vim.api.nvim_command("vsplit " .. path)
end

lvim.builtin.which_key.mappings["S"] = { "<cmd>lua OpenLuaSnipFile()<cr>", "Edit snippets" }

require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/lvim/luasnippets" })

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
  { "ggandor/leap.nvim", -- jump to words with "s"
    config = function()
      require('leap').set_default_keymaps()
    end
  },
  { "klen/nvim-test", -- run tests
    config = function()
      require('nvim-test').setup()
    end
  },
  { "nvim-telescope/telescope-ui-select.nvim" }, -- telescope for code action
  { "wesQ3/vim-windowswap" }, -- swap windows with <leader>ww
  { "dhruvasagar/vim-open-url" },
  { "akinsho/git-conflict.nvim",
    config = function()
      require('git-conflict').setup()
    end
  },
  {
    "tpope/vim-fugitive", -- needed for vim-conflicted
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
}
