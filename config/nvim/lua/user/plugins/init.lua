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
  { import = 'user.plugins.git' },
  { import = 'user.plugins.ui' },
  { import = 'user.plugins.navigation' },

  -- respect camelcase/underscores
  { 'chaoren/vim-wordmotion' },

  -- Detect tabstop and shiftwidth automatically:
  { 'tpope/vim-sleuth' },

  -- startup screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("user.plugins.startify").setup()
    end
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

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

  -- run tests
  {
    "klen/nvim-test",
    config = function()
      require("nvim-test").setup({})
      require('nvim-test.runners.jest'):setup {
        command = "./node_modules/.bin/vitest",
      }
    end
  },
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
