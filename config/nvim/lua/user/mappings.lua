-- open splits with vv:
if not vim.g.vscode then
  vim.api.nvim_set_keymap("n", "vv", ":vnew<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "--", ":new<cr>", { noremap = true, silent = true })
end

-- jump to diffs:
vim.keymap.set('n', '[[', '[c', { noremap = true, silent = true, desc = "Jump to previous diff" })
vim.keymap.set('n', ']]', ']c', { noremap = true, silent = true, desc = "Jump to next diff" })

-- find and replace:
-- these don't show a preview in the command bar if we use <leader>:
vim.api.nvim_set_keymap("n", "fr", ":%s//g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "fr", ":s//g<left><left>", { noremap = true })

-- stop highlighting last search:
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>", { noremap = true, silent = true })

-- play macros with <space>:
vim.api.nvim_set_keymap("n", "<space>", "@q", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>", ":<C-U>'<,'>norm! @q<CR>", { noremap = true, silent = true })

if vim.g.vscode then
  -- do nothing for <C-l>:
  vim.keymap.set("n", "<C-l>", "<nop>", { desc = "Do nothing" })
end

-- better window movement (supporting tmux)
if not vim.g.vscode then
  vim.keymap.set("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
  vim.keymap.set("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
  vim.keymap.set("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
  vim.keymap.set("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })
end

-- resize windows with arrow keys
vim.keymap.set('n', '<left>', ':vertical resize -10<cr>')
vim.keymap.set('n', '<right>', ':vertical resize +10<cr>')

-- center cursor when jumping up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- test file
require("which-key").add({
  {
    -- open file explorer at position of current file:
    "<leader>T",
    "<cmd>TestFile<cr>",
    desc = "test file",
    mode = "n",
    icon = ""
  },
})

require("which-key").add({
  {
    "<leader>N",
    function()
      require("notify")("Test notification!")
    end,
    -- desc = "test notification",
    desc = "which_key_ignore",
    mode = "n",
    icon = "󰂞"
  },
})

-- Spectre (find and replace across files)
require("which-key").add({
  {
    "<leader>F",
    require("spectre").open,
    desc = "Find + replace (spectre)",
    mode = "n",
    icon = "󰛔"
  },
})

-- Toggle file tree:
if vim.g.vscode then
  vim.api.nvim_set_keymap('n', ',t', '<Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>',
    { noremap = true, silent = true })
else
  require("which-key").add({
    {
      "<leader>t",
      "<cmd>NvimTreeToggle<cr>",
      desc = "toggle explorer",
      mode = "n",
      icon = ""
    },
  })
end

-- Joshuto
-- empty new files in tab by default
-- but if currently in empty buffer, just open it there
-- vim.keymap.set('n', '<leader>r', function()
--   local current_buffer = vim.api.nvim_get_current_buf()
--   local is_empty = vim.api.nvim_buf_line_count(current_buffer) == 1 and
--       vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)[1] == ''
--
--   require("joshuto").joshuto({ edit_in_tab = not is_empty })
-- end, { desc = "ranger (joshuto)" })

-- explorer
require("which-key").add({
  {
    -- open file explorer at position of current file:
    "<leader>r",
    function()
      require('mini.files').open(vim.api.nvim_buf_get_name(0))
    end,
    desc = "ranger (./)",
    mode = "n",
    icon = "󰙅"
  },
  {
    -- open file explorer at root:
    "<leader>R",
    function()
      require('mini.files').open(nil, false)
    end,
    desc = "ranger (~/root)",
    mode = "n",
    icon = "󰙅"
  },
})

-- Debugger (nvim-dap)
require("which-key").add({
  {
    "<leader>D",
    require("dapui").toggle,
    desc = "Debugger",
    mode = "n",
  },
  {
    "<leader>dd",
    require("dap").toggle_breakpoint,
    desc = "toggle breakpoint",
    mode = "n",
    icon = ""
  },
  {
    "<leader>dr",
    require("dap").continue,
    desc = "continue (run)",
    mode = "n",
    icon = ""
  },
  {
    "<leader>ds",
    require("dap").step_over,
    desc = "step",
    mode = "n",
    icon = ""
  },
})

-- Set group names for which-key:
require("which-key").add({
  { "Git", group = "git", mode = { "n", "x" } },
  { "Debugger", group = "debugger", icon = "🐞" },
  { "Diagnostics", group = "diagnostics" },
  { "Jump", group = "jump (go to)" },
  { "List", group = "list (macros/clipboard)" },
  { "Debug tools", group = "debug tools" },
  { "AI", group = "AI", mode = "x" },
  { "<leader>a", group = "AI", icon = "✨" },
  {
    "<leader>a",
    group = "AI",
    mode = "x",
    icon = "✨"
  },
  { "<leader>g", group = "git", icon = "" },
  { "<leader>g", group = "git", mode = "x", desc = "which_key_ignore" },
  { "<leader>j", group = "jump to", icon = "" },
  { "<leader>h", group = "history", icon = "󰋚" },
  { "<leader>d", group = "debug", icon = "" },
});
