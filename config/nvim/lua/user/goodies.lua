-- Remap for dealing with word wrap in long lines:
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Show current file in finder:

vim.cmd [[
  command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
]]

vim.keymap.set('n', '<leader>o', ':Silent open %:h<cr>', { noremap = true, silent = true })

-- Copy error messages:

local function open_url(url)
  local command = 'open'
  vim.fn.jobstart(command .. ' ' .. url, { detach = true })
end

vim.api.nvim_set_keymap('n', '<leader>e', [[:lua YankDiagnosticError()<CR>]],
  { noremap = true, silent = true, desc = "Copy error" })

vim.api.nvim_set_keymap('n', '<leader>E', [[:lua SendDiagnosticErrorToChatpGpt()<CR>]],
  { noremap = true, silent = true, desc = "Send error to ChatGPT" })

function SendDiagnosticErrorToChatpGpt()
  -- Copy error:
  YankDiagnosticError()
  local error_text = vim.fn.getreg('"')

  -- Copy code:
  vim.api.nvim_command('%yank')
  local full_code = vim.fn.getreg('"')

  -- Create prompt:
  local prompt = "This is my code:\n\n" .. full_code .. "\n\nHere's the error I get:\n\n" .. error_text

  -- Copy the prompt to the clipboard
  vim.fn.setreg('"', prompt)

  -- Finish yanking (wait 0.5s) then open ChatGPT:
  vim.defer_fn(function() open_url('https://chat.openai.com') end, 500)
end

function YankDiagnosticError()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid()    -- get the window ID of the floating window
  vim.cmd("normal! j")                 -- move down one row
  vim.cmd("normal! VG")                -- select everything from that row down
  vim.cmd("normal! y")                 -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end

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
vim.api.nvim_set_keymap('n', '<leader>p', "<Plug>UnconditionalPasteInlinedAfter",
  { noremap = true, silent = true, desc = "Paste inline" })

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

-- noir
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.nr" }, command = "set ft=noir syntax=rust" }
)

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

-- For ruby files:
-- See: https://github.com/testdouble/standard/wiki/IDE:-neovim
vim.opt.signcolumn = "yes" -- otherwise it bounces in and out, not strictly needed though
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice
  callback = function()
    vim.lsp.start {
      name = "standard",
      cmd = { "/opt/homebrew/opt/rbenv/shims/standardrb", "--lsp" },
    }
  end,
})
