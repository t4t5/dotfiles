local function init_chatgpt()
  local chatgpt = require("chatgpt")
  chatgpt.setup({
    api_key_cmd = "op read op://personal/knxrmu7gwcbmv4ht4sr3pai7ta/credential --no-newline",
    popup_input = {
      submit = "<CR>"
    },
    actions_paths = {
      "~/dotfiles/config/nvim/lua/user/chatgpt_actions.json",
    },
  })

  return chatgpt
end

-- vim.api.nvim_create_user_command('AI', require('chatgpt').edit_with_instructions, {})
vim.api.nvim_create_user_command('AI', function()
  local chatgpt = init_chatgpt()
  chatgpt.edit_with_instructions()
end, {})

vim.api.nvim_create_user_command('TailwindMigrate', function()
  init_chatgpt()
  vim.api.nvim_command('ChatGPTRun tailwind_migrate')
end, {})
