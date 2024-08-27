local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  rust_analyzer = {
    diagnostics = {
      disabled = { "inactive-code" },
    }
  },
  tsserver = {},
  tailwindcss = {
    filetypes = { 'typescriptreact', 'astro' },
    tailwindCSS = {
      experimental = {
        classRegex = {
          "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]",
        }
      }
    }
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

-- Treesitter
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

-- Ensure the servers above are installed
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
  -- disable default since we use rustaceanvim instead:
  ['rust_analyzer'] = function() end,
}

-- Setup neovim lua configuration
require('neodev').setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})


--- KEYMAPS: ---

-- Restart LSP with tt:
vim.api.nvim_set_keymap("n", "tt", ":LspRestart<cr>", { noremap = true, silent = true })

-- View documentation:
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'Inspect (hover)' })
vim.keymap.set('n', '<leader>aa', vim.lsp.buf.code_action, { desc = 'Code Actions' })
-- go to definition:
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- vim.keymap.set('n', '<leader>sd', vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set('n', '<leader>jt', '<CMD>Glance type_definitions<CR>', { desc = "jump to type definition" })
-- vim.keymap.set('n', '<leader>sr', '<cmd>Telescope lsp_references<cr>', { desc = "find references" })
vim.keymap.set('n', '<leader>jr', '<CMD>Glance references<CR>', { desc = "jump to references" })

-- Show bordered window for documentation (<leader>k) window:
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Be able to quickly copy documentation:
local function focus_hover_and_enter()
  -- Get a list of all floating windows
  local wins = vim.api.nvim_list_wins()

  for _, win in ipairs(wins) do
    -- Check if the window is a floating window (hover window is a floating window)
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      -- Focus the hover window
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- If no floating window is found, just send Enter as usual
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', true)
end
-- jump into hover window with Enter (useful for hover actions):
vim.keymap.set('n', '<CR>', focus_hover_and_enter, { noremap = true, silent = true })

local function yank_hover_content()
  local orig_win = vim.api.nvim_get_current_win()
  -- Find the floating window
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then -- This identifies a floating window
      vim.api.nvim_set_current_win(win)
      vim.cmd 'normal! ggVGy'
      vim.api.nvim_set_current_win(orig_win)
      vim.notify('Hover content yanked to clipboard')
      return
    end
  end
  vim.notify('No hover window found')
end

vim.keymap.set('n', '<leader>y', yank_hover_content, { desc = 'Yank Hover Content' })
