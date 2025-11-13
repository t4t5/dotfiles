-- LSP Configuration using vim.lsp.config API (Nvim 0.11+)
-- For language examples:
-- https://github.com/neovim/nvim-lspconfig/blob/37cc31c64d657feff6f752a1bf15f584d4734eca/lsp/eslint.lua

-- ============================================================================
-- Mason: Auto-install LSP servers and formatters
-- ============================================================================

require("mason").setup()

local mr = require "mason-registry"

-- Restart LSP clients when Mason installs a package
mr:on(
  "package:install:success",
  vim.schedule_wrap(function()
    for _, client in ipairs(vim.lsp.get_clients()) do
      vim.lsp.stop_client(client.id, true)
    end
  end)
)

-- Auto-install these LSP servers via Mason
local servers = {
  "rust-analyzer", -- Handled by rustaceanvim
  "typescript-language-server",
  "tailwindcss-language-server",
  "terraform-ls",
  "tflint",
  "prismals",
  "dockerfile-language-server",
  "eslint",
  "vscode-json-language-server",
  "css-lsp",
  "yaml-language-server",
  "solidity-ls-nomicfoundation",
  "lua-language-server",
}

-- Auto-install formatters via Mason
local formatters = {
  "prettier",
  "stylua",
}

-- Install servers
for _, server in ipairs(servers) do
  if mr.has_package(server) then
    local pkg = mr.get_package(server)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

-- Install formatters
for _, formatter in ipairs(formatters) do
  if mr.has_package(formatter) then
    local pkg = mr.get_package(formatter)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

-- ============================================================================
-- LSP Server Configurations
-- ============================================================================

-- Broadcast nvim-cmp completion capabilities to all servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Helper function to configure and enable LSP servers
local function setup_lsp(name, config)
  config.capabilities = capabilities
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- TypeScript
setup_lsp("typescript_language_server", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
})

-- Tailwind CSS
setup_lsp("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", ".git" },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      classAttributes = { "class", "className", "classList" },
      experimental = {
        classRegex = {
          "cva\\(([^)]*)\\)",
          "[\"'`]([^\"'`]*).*?[\"'`]",
        },
      },
    },
  },
})

-- Terraform
setup_lsp("terraformls", {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
})

-- TFLint
setup_lsp("tflint", {
  cmd = { "tflint", "--langserver" },
  filetypes = { "terraform" },
  root_markers = { ".terraform", ".git" },
})

-- Prisma
setup_lsp("prismals", {
  cmd = { "prisma-language-server", "--stdio" },
  filetypes = { "prisma" },
  root_markers = { "package.json", ".git" },
  settings = {
    prisma = {
      enableDiagnostics = true,
    },
  },
})

-- Docker
setup_lsp("dockerls", {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile", ".git" },
})

-- ESLint - Disabled due to issues, use conform.nvim or nvim-lint instead
setup_lsp("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "eslint.config.js" },
  -- These settings are REQUIRED:
  -- see: https://github.com/microsoft/vscode-eslint/issues/2008
  settings = {
    nodePath = "",
    experimental = {
      useFlatConfig = false,
    },
    problems = {},
    rulesCustomizations = {},
  },
})

-- JSON
setup_lsp("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { "package.json", ".git" },
  settings = {
    json = { validate = { enable = true } },
  },
})

-- CSS
setup_lsp("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  settings = {
    css = { validate = false },
  },
})

-- YAML
setup_lsp("yamlls", {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose" },
  root_markers = { ".git" },
  settings = {
    yaml = { keyOrdering = false },
  },
})

-- Solidity
setup_lsp("solidity_ls_nomicfoundation", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", ".git" },
})

-- Lua
setup_lsp("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luacheckrc", ".stylua.toml", ".git" },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- Rust: Skip rust_analyzer as rustaceanvim handles it
-- Don't call vim.lsp.enable("rust_analyzer")

-- ============================================================================
-- Commands
-- ============================================================================

-- :LspInfo - Show attached LSP clients
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    vim.notify("No LSP clients attached to this buffer", vim.log.levels.INFO)
    return
  end
  local lines = {}
  for _, client in ipairs(clients) do
    table.insert(lines, client.name .. " (id: " .. client.id .. ")")
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, {})

-- ============================================================================
-- Keymaps
-- ============================================================================

-- tt - Restart LSP clients
vim.keymap.set("n", "tt", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  local server_names = {}

  for _, client in ipairs(clients) do
    table.insert(server_names, client.name)
    vim.lsp.stop_client(client.id, true)
  end

  vim.defer_fn(function()
    for _, server_name in ipairs(server_names) do
      vim.lsp.enable(server_name)
    end
    vim.notify("LSP clients restarted: " .. table.concat(server_names, ", "))
  end, 100)
end, { desc = "Restart LSP" })

-- LSP hover
require("which-key").add {
  {
    "<leader>k",
    function()
      vim.lsp.buf.hover { border = "single", max_height = 25 }
    end,
    desc = "inspect (hover)",
    mode = "n",
    icon = "",
  },
}

-- Code actions
require("which-key").add {
  { "<leader>aa", vim.lsp.buf.code_action, desc = "automatic action", mode = "n", icon = "🪄" },
}

-- Navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>jt", "<CMD>Glance type_definitions<CR>", { desc = "jump to type definition" })
vim.keymap.set("n", "<leader>jr", "<CMD>Glance references<CR>", { desc = "jump to references" })

-- ============================================================================
-- Hover Window Utilities
-- ============================================================================

-- Enter key: Focus floating window (useful for copying hover content)
local function focus_hover_and_enter()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
end

vim.keymap.set("n", "<CR>", focus_hover_and_enter, { desc = "Focus hover window" })

-- <leader>y: Yank hover content to clipboard
local function yank_hover_content()
  local orig_win = vim.api.nvim_get_current_win()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_set_current_win(win)
      vim.cmd "normal! ggVGy"
      vim.api.nvim_set_current_win(orig_win)
      vim.notify "Hover content yanked to clipboard"
      return
    end
  end
  vim.notify "No hover window found"
end

require("which-key").add {
  {
    "<leader>y",
    yank_hover_content,
    desc = "yank hover contents",
    mode = "n",
    icon = "",
  },
}
