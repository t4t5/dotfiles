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
    -- autoformatter
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        format_on_save = {
          lsp_fallback = true
        },
        formatters_by_ft = {
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          astro = { "prettier" },
          lua = { "stylua" },
          sway = { "sway" },
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
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'saadparwaiz1/cmp_luasnip' },
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

  -- autoclosing tags
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  -- better rust support:
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
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
