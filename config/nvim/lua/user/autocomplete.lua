local cmp = require 'cmp'
local cmp_window = require "cmp.config.window"
local luasnip = require 'luasnip'
local lspkind = require('lspkind')

-- trigger autocomplete with C-c
vim.keymap.set('i', '<C-c>', require("cmp").complete, { expr = true, noremap = true })

-- set colour of Copilot icon:
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

luasnip.config.setup {}

-- Show tailwind color preview:
local function tailwind_color_preview(entry, vim_item)
  if vim_item.kind == 'Color' and entry.completion_item.documentation then
    local color = entry.completion_item.documentation
    local color_str = string.sub(color, 2, 7)

    local group = 'Tw_' .. color_str

    if vim.fn.hlID(group) < 1 then
      vim.api.nvim_set_hl(0, group, { fg = '#' .. color_str })
    end

    vim_item.kind = "■" -- or "⬤" or anything
    vim_item.kind_hl_group = group

    return vim_item
  end

  local icon = lspkind.symbolic(vim_item.kind)

  -- Fallback to default formatter:
  -- show icon + type:
  vim_item.kind = icon and (icon .. '  ' .. vim_item.kind) or vim_item.kind
  -- or just show the icon
  -- vim_item.kind = icon and icon or vim_item.kind

  return vim_item
end

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
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "copilot" },
  },
  -- sorting = {
  --   comparators = {
  --     cmp.config.compare.kind,
  --     -- custom_sort_suggestions,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },
  formatting = {
    format = lspkind.cmp_format({
      -- mode = 'symbol',       -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      symbol_map = { Copilot = "" },
      before = tailwind_color_preview,
    })
  },
}
