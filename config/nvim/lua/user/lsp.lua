-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  rust_analyzer = {
    diagnostics = {
      disabled = { "inactive-code" },
    }
  },
  typescript_language_server = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },
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
  jsonls = {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    json = {
      validate = { enable = true },
    },
  },
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

-- Formatters to auto-install via Mason
local formatters = {
  'prettier',
  'stylua',
}

-- Ensure the servers and formatters above are installed via Mason
require('mason').setup()

-- Auto-install LSP servers via Mason registry
local mr = require('mason-registry')
mr:on('package:install:success', vim.schedule_wrap(function()
  -- Restart all LSP clients
  for _, client in ipairs(vim.lsp.get_clients()) do
    vim.lsp.stop_client(client.id, true)
  end
end))

for server_name, _ in pairs(servers) do
  local package_name = server_name:gsub('_', '-')
  if mr.has_package(package_name) then
    local pkg = mr.get_package(package_name)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

-- Auto-install formatters via Mason registry
for _, formatter_name in ipairs(formatters) do
  if mr.has_package(formatter_name) then
    local pkg = mr.get_package(formatter_name)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

-- Configure each server using the new native vim.lsp.config API
for server_name, server_config in pairs(servers) do
  -- Skip rust_analyzer since we use rustaceanvim
  if server_name ~= 'rust_analyzer' then
    vim.lsp.config(server_name, {
      cmd = server_config.cmd,
      capabilities = capabilities,
      settings = server_config,
      filetypes = server_config.filetypes,
    })
    vim.lsp.enable(server_name)
  end
end


--- KEYMAPS: ---

-- Custom :LspInfo command for the new native API:
vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients({bufnr=0})

  if #clients == 0 then
    vim.notify("No LSP clients attached to this buffer", vim.log.levels.INFO)
    return
  end

  local lines = {}
  for _, client in ipairs(clients) do
    local info = client.name .. " (id: " .. client.id .. ")"
    -- if client.config and client.config.root_dir then
    --   info = info .. "\n  Root: " .. client.config.root_dir
    -- end
    table.insert(lines, info)
  end

  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, {})

-- Restart LSP with tt:
vim.keymap.set("n", "tt", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  -- Collect server names before stopping
  local server_names = {}
  for _, client in ipairs(clients) do
    table.insert(server_names, client.name)
    vim.lsp.stop_client(client.id, true)
  end

  -- Re-enable the servers after stopping
  vim.defer_fn(function()
    for _, server_name in ipairs(server_names) do
      vim.lsp.enable(server_name)
    end
    vim.notify("LSP clients restarted: " .. table.concat(server_names, ", "))
  end, 100)
end, { noremap = true, silent = true, desc = "Restart LSP" })

-- View documentation:
require("which-key").add({
  {
    "<leader>k",
    function()
      vim.lsp.buf.hover { border = "single", max_height = 25 }
    end,
    desc = "inspect (hover)",
    mode = "n",
    icon = ""
  },
})

-- Avante actions (ignore most of them):
-- visual mode:
require("which-key").add({
  {
    "<leader>ak",
    desc = "edit snippet with AI",
    mode = "x",
    icon = "🪄"
  },
  {
    "<leader>al", -- avante ask
    desc = "which_key_ignore",
    mode = "x"
  },
  {
    "<leader>aa",
    ":CopyClaudeContextRef<CR>",
    desc = "get claude @ref",
    mode = "v"
  }
  -- {
  --   "<leader>al",
  --   desc = "ask AI (about snippet)",
  --   mode = "x",
  --   icon = "✨"
  -- },
})
-- normal mode:
require("which-key").add({
  {
    "<leader>al", -- avante ask
    desc = "which_key_ignore",
    mode = "n"
  },
  -- {
  --   "<leader>ai",
  --   desc = "superagent",
  --   mode = "v",
  --   icon = "💪"
  -- },
  {
    "<leader>aa",
    vim.lsp.buf.code_action,
    desc = "automatic action",
    mode = "n",
    icon = "🪄"
  },
  {
    "<leader>ad", -- avante debug
    desc = "which_key_ignore",
  },
  {
    "<leader>ac", -- avante add to buffer
    desc = "which_key_ignore",
  },
  {
    "<leader>af", -- avante focus
    desc = "which_key_ignore",
  },
  {
    "<leader>ah", -- avante toggle hint
    desc = "which_key_ignore",
  },
  {
    "<leader>ar", -- avante refresh
    desc = "which_key_ignore",
  },
  {
    "<leader>aR", -- avante display repo map
    desc = "which_key_ignore",
  },
  {
    "<leader>as", -- avante toggle suggestion
    desc = "which_key_ignore",
  },
  {
    "<leader>at", -- avante toggle
    desc = "which_key_ignore",
  },
})

-- -- Make sure ts_ls (i.e import suggestions) come before other things like eslint
-- -- when using <leader>aa for code actions:
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.sort = function(items)
    table.sort(items, function(a, b)
      if a.source == "tsserver" then
        return true
      elseif b.source == "tsserver" then
        return false
      else
        return a.source < b.source
      end
    end)
    return items
  end
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- go to definition:
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- vim.keymap.set('n', '<leader>sd', vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set('n', '<leader>jt', '<CMD>Glance type_definitions<CR>', { desc = "jump to type definition" })
-- vim.keymap.set('n', '<leader>sr', '<cmd>Telescope lsp_references<cr>', { desc = "find references" })
vim.keymap.set('n', '<leader>jr', '<CMD>Glance references<CR>', { desc = "jump to references" })

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

-- copy contents in a hover box (like error)
require("which-key").add({
  {
    "<leader>y",
    yank_hover_content,
    desc = "yank hover contents",
    mode = "n",
    icon = ""
  },
})
