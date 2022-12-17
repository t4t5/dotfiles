-- luasnip
function OpenLuaSnipFile()
  local snippet_file = vim.bo.filetype .. '.snippets'
  local path = '~/dotfiles/config/lvim/luasnippets/' .. snippet_file
  vim.api.nvim_command("vsplit " .. path)
end

lvim.builtin.which_key.mappings["S"] = { "<cmd>lua OpenLuaSnipFile()<cr>", "Edit snippets" }

require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/lvim/luasnippets" })
