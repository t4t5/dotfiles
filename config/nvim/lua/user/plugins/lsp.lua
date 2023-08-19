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
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
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
            ['j'] = actions.next,
            ['k'] = actions.previous,
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
