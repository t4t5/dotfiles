---@diagnostic disable: missing-fields

-- Treesitter
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
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

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>ak', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>aj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code Actions' })

-- go to definition:
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- vim.keymap.set('n', '<leader>sd', vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set('n', '<leader>fd', '<CMD>Glance definitions<CR>', { desc = "find definition" })

-- show references
-- vim.keymap.set('n', '<leader>sr', '<cmd>Telescope lsp_references<cr>', { desc = "find references" })
vim.keymap.set('n', '<leader>fr', '<CMD>Glance references<CR>', { desc = "find references" })


-- LSP settings

local lspconfig = require 'lspconfig'

-- Add language servers here and they will automatically be installed:
-- You can see which ones are installed with :Mason
-- You can also install more with :LspInstall <server>
local servers = {
  rust_analyzer = {
    diagnostics = {
      disabled = { "inactive-code" },
    }
  },
  tsserver = {},
  tailwindcss = {
    filetypes = { 'typescriptreact', 'astro' }
  },
  terraformls = {},
  tflint = {},
  prismals = {},
  dockerls = {},
  eslint = {},
  jsonls = {},
  cssls = {
    css = {
      validate = false
    }
  },
  yamlls = {
    keyOrdering = false,
  },
  solidity_ls_nomicfoundation = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      -- on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local cmp_window = require "cmp.config.window"
local luasnip = require 'luasnip'
local lspkind = require('lspkind')
-- require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- trigger autocomplete with C-c
vim.keymap.set('i', '<C-c>', require("cmp").complete, { expr = true, noremap = true })

-- set colour of Copilot icon:
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- Check out what number each kind maps to:
-- https://learn.microsoft.com/en-us/dotnet/api/microsoft.visualstudio.languageserver.protocol.completionitemkind?view=visualstudiosdk-2022
-- The higher priority you want, the earlier it should be in the list:
-- Method: 2
-- Property: 10
-- Variable: 6
-- Snippet: 15
-- Constant: 21
-- local kind_mapper = { 15, 2, 10, 6, 21, 3, 4, 5, 7, 1, 8, 9, 11, 12, 13, 14 }

-- local compare = require("cmp.config.compare")

cmp.setup {
  preselect = cmp.PreselectMode.None, -- Don't preselect suggestions, it hijacks the enter key
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp_window.bordered(),
    documentation = cmp_window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "copilot" },
  },
  formatting = {
    format = lspkind.cmp_format({
      -- mode = 'symbol',       -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      symbol_map = { Copilot = "" },
    })
  },
  -- sorting = {
  --   comparators = {
  --     compare.exact,
  --     function(entry1, entry2)
  --       local kind1 = kind_mapper[entry1:get_kind()] or 0
  --       local kind2 = kind_mapper[entry2:get_kind()] or 0
  --
  --       if kind1 < kind2 then
  --         return true
  --       end
  --     end
  --   },
  -- },
}

-- Show bordered window for errors:
vim.diagnostic.config {
  float = { border = "rounded" },
}

-- Show bordered window for documentation (<leader>k) window:
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Use better icons for diagnosics:
local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
