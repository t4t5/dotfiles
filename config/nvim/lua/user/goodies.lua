-- Remap for dealing with word wrap in long lines:
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Show current file in finder:
-- vim.cmd [[
--   command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
-- ]]
-- require("which-key").add({
--   {
--     -- Show current file in finder:
--     "<leader>o",
--     ':Silent open %:h<cr>',
--     desc = "open in finder",
--     mode = "n",
--     icon = "󰀶"
--   },
-- })

-- Highlight copied text when yanking:
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Paste inline with <leader>p:
require("which-key").add({
  { "<leader>p", "<Plug>UnconditionalPasteInlinedAfter", desc = "paste inline", mode = "n", icon = "" },
})

-- Set syntax highlighting for .env.local, .env.development, .env.production...
vim.api.nvim_command("au! BufNewFile,BufRead .env.* set filetype=sh")
vim.api.nvim_command("au! BufNewFile,BufRead zshrc set filetype=sh")

-- set hbs file type to html.handlebars
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.hbs", "*.handlebars" }, command = "set ft=html.handlebars" }
)
-- no newline at end of hbs files:
vim.api.nvim_command("autocmd FileType html.handlebars setlocal noeol binary")

-- write file without triggering autocommands (like formatting):
require("which-key").add({
  {
    "<leader>w",
    [[:noautocmd w<cr>]],
    desc = "write without formatting",
    mode = "n",
    icon = ""
  },
})

-- Caddyfile
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*Caddyfile" }, command = "set ft=caddyfile syntax=nginx" }
)

-- mdx
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.mdx" }, command = "set ft=markdown syntax=markdown" }
)

-- Wrap markdown content to a readable width (approximately 600px / ~100 characters)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    -- Set soft wrap at window edge
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    -- Limit the text width to ~100 columns for better readability
    vim.opt_local.textwidth = 100
    -- Add visual guide at the edge
    vim.opt_local.colorcolumn = "100"
  end,
})

-- txtx
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.tx" }, command = "set ft=txtx syntax=hcl" }
)

-- For ruby files:
-- See: https://github.com/testdouble/standard/wiki/IDE:-neovim
-- vim.opt.signcolumn = "yes" -- otherwise it bounces in and out, not strictly needed though
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "ruby",
--   group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice
--   callback = function()
--     vim.lsp.start {
--       name = "standard",
--       cmd = { "/opt/homebrew/opt/rbenv/shims/standardrb", "--lsp" },
--     }
--   end,
-- })

