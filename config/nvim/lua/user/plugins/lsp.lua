---@diagnostic disable: missing-fields
return {
  -- LSP server installer (configured in lua/user/lsp.lua)
  'williamboman/mason.nvim',

  -- Show spinner when LSP is loading
  {
    'linrongbin16/lsp-progress.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lsp-progress').setup()
    end
  },

  -- Neovim Lua development with proper type hints
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { plugins = { 'nvim-dap-ui' }, types = true },
      },
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

      lint.linters.openscad = {
        cmd = "openscad",
        args = { "-o", "/dev/null", "--export-format", "png" },
        stdin = false,
        append_fname = true,
        stream = "stderr",
        parser = function(output)
          local diagnostics = {}
          for line in output:gmatch("[^\r\n]+") do
            local severity, msg, lnum
            -- WARNING: <message> in file <file>, line <num>
            msg, lnum = line:match("^WARNING:%s+(.-),%s+line%s+(%d+)")
            if msg then severity = vim.diagnostic.severity.WARN end
            if not lnum then
              msg, lnum = line:match("^ERROR:%s+(.-),%s+line%s+(%d+)")
              if msg then severity = vim.diagnostic.severity.ERROR end
            end
            if lnum then
              table.insert(diagnostics, {
                lnum = tonumber(lnum) - 1,
                col = 0,
                severity = severity,
                source = "openscad",
                message = msg,
              })
            end
          end
          return diagnostics
        end,
      }

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        prisma = { "prisma_fmt" },
        openscad = { "openscad" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
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
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'astro' },
        -- Autoinstall languages that are not installed:
        auto_install = true,
        highlight = { enable = true, disable = { "bash" } },
        indent = { enable = true, disable = { 'python' } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
      }
    end
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

  -- show bitcoin script steps
  {
    'taproot-wizards/bitcoin-script-hints.nvim',
    -- dir = vim.fn.expand("~/dev/nvim/bitcoin-script-hints.nvim"), -- test locally
    config = function()
      require('bitcoin-script-hints').setup()
    end
  },

  -- better rust support:
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },

  -- noir lang support
  {
    "semaraugusto/noir-nvim",
    -- "noir-lang/noir-nvim",
    ft = "noir",
    config = function()
      vim.lsp.config('noir_ls', {
        cmd = { "nargo", "lsp" },
        filetypes = { "noir" },
        root_dir = vim.fs.root(0, { 'Nargo.toml' }),
      })
      vim.lsp.enable('noir_ls')
    end,
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
