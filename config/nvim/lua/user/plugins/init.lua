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
  { import = 'user.plugins.lualine' },
  { import = 'user.plugins.git' },
  { import = 'user.plugins.ui' },
  { import = 'user.plugins.navigation' },

  -- respect camelcase/underscores
  { 'chaoren/vim-wordmotion' },

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

  -- clipboard + macro history in telescope
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('neoclip').setup({
        -- sync with unnamedplus
        default_register = { '+', '*', '"' },
        keys = {
          telescope = {
            i = {
              -- to prevent overriding of <c-k>
              paste_behind = '<c-P>',
            }
          },
        }
      })
      require('telescope').load_extension('neoclip')
    end,
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

  -- So that you can paste inline with <leader>p
  "inkarkat/vim-UnconditionalPaste",

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

  -- debugging:
  -- NOTE: requires installing codelldb via Mason!
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()

      -- ui tweaks:
      vim.fn.sign_define('DapBreakpoint',
        { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapStopped',
        { text = '🟡', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

      -- Run dap-ui whenever dap is run:
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

  -- change surrounding tags
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
}, {})
