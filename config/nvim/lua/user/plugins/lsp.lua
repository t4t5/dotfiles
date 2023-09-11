---@diagnostic disable: missing-fields
return {
  -- LSP Configuration & Plugins:
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Show spinner when LSP is loading
      {
        'linrongbin16/lsp-progress.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
          require('lsp-progress').setup()
        end
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    'mhartington/formatter.nvim',
    config = function()
      local formatter = require("formatter")
      local default_formatters = require("formatter.defaults")
      local prettierd = default_formatters.prettierd
      local stylua = default_formatters.stylua
      formatter.setup({
        filetype = {
          javascript = { prettierd },
          javascriptreact = { prettierd },
          typescript = { prettierd },
          typescriptreact = { prettierd },
          prisma = default_formatters.prisma_fmt,
          lua = { stylua }
        }
      })
    end
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        prisma = { "prisma_fmt" },
      }
    end
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- icons for LSP
  'onsails/lspkind.nvim',

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- List references + definitions:
  {
    "dnlhc/glance.nvim",
    config = function()
      local glance = require('glance')
      local actions = glance.actions

      glance.setup({
        mappings = {
          list = {
            ['q'] = actions.close,
            ['j'] = actions.next_location,
            ['k'] = actions.previous_location,
            -- navigating breaks the preview, so close the modal:
            ['<C-k>'] = actions.close,
            ['<C-j>'] = actions.close,
            ['<C-h>'] = actions.close,
            ['<C-l>'] = actions.close,
          },
          preview = {
            ['q'] = actions.close,
            ['j'] = actions.next_location,
            ['k'] = actions.previous_location,
            -- navigating breaks the preview, so close the modal:
            ['<C-k>'] = actions.close,
            ['<C-j>'] = actions.close,
            ['<C-h>'] = actions.close,
            ['<C-l>'] = actions.close,
          },
        }
      })
    end,
  },

}
