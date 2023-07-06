-- Install package manager (lazy.nvim)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Plugins:
require('lazy').setup({
  { import = 'user.plugins.lsp' },
  { import = 'user.plugins.autoformat' },
  { import = 'user.plugins.lualine' },
  { import = 'user.plugins.gitsigns' },

  -- telescope for code action
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- respect camelcase/underscores
  { "chaoren/vim-wordmotion" },

  -- swap windows with <leader>ww
  { "wesQ3/vim-windowswap" },

  { "sindrets/diffview.nvim" },  -- git status
  { "ruanyl/vim-gh-line" },      -- open blame in github
  { "f-person/git-blame.nvim" }, -- show last commit per line in editor
  {
    "tpope/vim-fugitive",        -- needed for vim-conflicted
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

  -- Bufferline:
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },

  -- Detect tabstop and shiftwidth automatically:
  'tpope/vim-sleuth',

  -- Theme:
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end
  },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("user.plugins.startify").setup()
    end
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    "kevinhwang91/rnvimr", -- ranger
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "aserowy/tmux.nvim", -- jump to tmux windows
    config = function() require("tmux").setup() end
  },

  -- GitHub Copilot:
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },


  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    -- Don't add "config" here, or neovim will take a long time to load
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

  {
    "klen/nvim-test",
    config = function()
      require("nvim-test").setup({})
      require('nvim-test.runners.jest'):setup {
        command = "./node_modules/.bin/vitest",
      }
    end
  },
  {
    "ggandor/leap.nvim", -- jump to words with "s"
    config = function()
      require('leap').set_default_keymaps()
    end
  },
  {
    'norcalli/nvim-colorizer.lua', -- Show color preview for hex strings
    config = function()
      require 'colorizer'.setup()
    end
  }
}, {})


-- Spectre (find and replace across files)
vim.keymap.set('n', '<leader>F', require("spectre").open, {
  desc = "Open Spectre"
})

-- Test
vim.keymap.set('n', '<leader>T', "<cmd>TestFile<cr>", {
  desc = "Test file"
})

vim.keymap.set('n', '<leader>r', "<cmd>RnvimrToggle<cr>")

local function init_chatgpt()
  local chatgpt = require("chatgpt")
  chatgpt.setup({
    api_key_cmd = "op read op://personal/knxrmu7gwcbmv4ht4sr3pai7ta/credential --no-newline",
    popup_input = {
      submit = "<CR>"
    },
    actions_paths = {
      "~/dotfiles/config/nvim/lua/user/chatgpt_actions.json",
    },
  })

  return chatgpt
end

-- vim.api.nvim_create_user_command('AI', require('chatgpt').edit_with_instructions, {})
vim.api.nvim_create_user_command('AI', function()
  local chatgpt = init_chatgpt()
  chatgpt.edit_with_instructions()
end, {})

vim.api.nvim_create_user_command('TailwindMigrate', function()
  init_chatgpt()
  vim.api.nvim_command('ChatGPTRun tailwind_migrate')
end, {})
