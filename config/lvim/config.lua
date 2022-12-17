-- show vim error messages on startup:
-- https://github.com/LunarVim/LunarVim/issues/3502
vim.schedule(function()
  vim.cmd "messages"
end)

reload("user.options")
reload("user.mappings")
reload("user.telescope")
reload("user.tabs")
reload("user.git")
reload("user.lsp")
reload("user.statusline")
reload("user.testing")
reload("user.snippets")
reload("user.plugins")
