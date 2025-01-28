-- luasnip
function OpenLuaSnipFile()
  local snippet_file = vim.bo.filetype .. '.snippets'
  local path = '~/dotfiles/config/nvim/luasnippets/' .. snippet_file
  vim.api.nvim_command("vsplit " .. path)
end

require("which-key").add({
  {
    "<leader>S",
    OpenLuaSnipFile,
    desc = "edit snippets",
    mode = "n",
    icon = ""
  },
})

require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/luasnippets" })
