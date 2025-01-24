local cmp = require 'cmp'
local cmp_window = require "cmp.config.window"
local luasnip = require 'luasnip'
local lspkind = require('lspkind')

-- trigger autocomplete with C-c
vim.keymap.set('i', '<C-c>', require("cmp").complete, { expr = true, noremap = true })

-- set color of Copilot icon:
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- Set up snippets:
luasnip.config.setup {}

-- Show tailwind color preview:
local function format_tailwind_color_preview(entry, vim_item)
  -- we assume this is a hex color (e.g. '#000000')
  local color = entry.completion_item.documentation

  -- get just the hex value (without '#')
  local color_str = string.sub(color, 2, 7)

  local group = 'Tw_' .. color_str

  if vim.fn.hlID(group) < 1 then
    vim.api.nvim_set_hl(0, group, { fg = '#' .. color_str })
  end

  vim_item.kind = "■" -- or "⬤" or anything
  vim_item.kind_hl_group = group

  return vim_item
end

-- We only have this so that we can handle tailwind colors separately:
local function format_item(entry, vim_item)
  if vim_item.kind == 'Color' and entry.completion_item.documentation then
    format_tailwind_color_preview(entry, vim_item)
  end

  local icon = lspkind.symbolic(vim_item.kind)

  -- show icon + type:
  vim_item.kind = icon and (icon .. '  ' .. vim_item.kind) or vim_item.kind
  -- ...or just show the icon
  -- vim_item.kind = icon and icon or vim_item.kind
  -- ...or use this for debugging:
  -- vim_item.kind = entry:get_kind() .. ' VS ' .. cmp.lsp.CompletionItemKind.Snippet

  return vim_item
end

local function custom_sort(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()

  local snippet_type = cmp.lsp.CompletionItemKind.Snippet

  -- deprioritize snippets:
  --[[ if kind1 == snippet_type then
    return false
  elseif kind2 == snippet_type then
    return true
  end ]]

  -- local copilot_type = cmp.lsp.CompletionItemKind.Copilot
  -- if kind1 == copilot_type then
  --   return true
  -- elseif kind2 == copilot_type then
  --   return false
  -- end

  return cmp.config.compare.sort_text(entry1, entry2)
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
    { name = "copilot" },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  sorting = {
    comparators = {
      -- custom_sort,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      -- mode = 'symbol',       -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      symbol_map = { Copilot = "" },
      before = format_item,
    })
  },
}
