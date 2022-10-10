"
" --- better defaults

let mapleader = ","              " Set <leader> to ',' instead of '\'

filetype plugin indent on        " Load plugin, indent for filetype

set expandtab                    " On pressing tab, insert 2 spaces
set tabstop=2                    " show existing tab with 2 spaces width
set softtabstop=2
set shiftwidth=2                 " when indenting with '>', use 2 spaces width

set ignorecase                   " Ignore case when searching
set smartcase                    " When searching, try to be smart about cases

set hidden                       " switch between buffers without a 'no write since last save' warning
set noswapfile                   " don't create swap files

set clipboard=unnamed            " Always copy/paste to clipboard

set number                       " Show line numbers
set numberwidth=5                " Gutter width
set relativenumber               " Relative line numbers
set fillchars=vert:\│,eob:\      " Hide ~ symbols in gutter
set nofoldenable                 " show file contents in spectre
set mouse=

set splitbelow                   " Open new horizontal pane below, which feels more natural
set diffopt+=vertical

" set cmdheight=0 " will be available soon

" No newline at end of file:
autocmd FileType html.handlebars setlocal noeol binary

" Fix out-of-sync syntax highlighting for large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"
" --- custom shortcuts

" vv to generate new vertical split
nnoremap <silent> vv :vnew<cr>
" -- to generate new horizontal split
nnoremap <silent> -- :new<cr>

" navigate splits with ctrl + hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" resize panes with just arrow keys
nnoremap <silent> <left> :vertical resize -10<cr>
nnoremap <silent> <right> :vertical resize +10<cr>
nnoremap <silent> <up> :resize +5<cr>
nnoremap <silent> <down> :resize -5<cr>

" switch between tabs with ctrl + arrow keys
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" stop highlighting last search by pressing return key
nnoremap <CR> :noh<CR><CR>

" Format json with :JSON
com! Json %!python -m json.tool

com! Send :CocCommand rest-client.request <cr>

" Macros
" Use qq to start, q to stop and <Space> to play
nnoremap <Space> @q
vnoremap <silent> <Space> :norm! @q<cr>

"
" --- vim-plug plugins ---

call plug#begin()
Plug 'nvim-lualine/lualine.nvim'
Plug 'rakr/vim-one'                            " OneDark color scheme
Plug 'junegunn/fzf'                            " Fuzzyfinder
Plug 'junegunn/fzf.vim'                        " Better Vim support for fzf
Plug 'christoomey/vim-tmux-navigator'          " ctrl + hjkl navigation between vim and tmux panes
Plug 'neoclide/coc.nvim', {'branch': 'release' } " autocompletion
Plug 'kyazdani42/nvim-web-devicons'            " pretty icons in nvim-tree
Plug 'osyo-manga/vim-over'                     " visual find-and-replace
Plug 'sheerun/vim-polyglot'                    " better language support
Plug 'tpope/vim-fugitive'                      " git shortcuts in vim
Plug 'tpope/vim-rhubarb'                       " enables :GBrowse in Fugitive
Plug 'vim-test/vim-test'                       " Run tests easily
Plug 'christoomey/vim-tmux-runner'             " Run vim tests in tmux pane
Plug 'sukima/vim-javascript-imports'           " Needed for vim-ember-imports
Plug 'sukima/vim-ember-imports'                " Import Ember's modules with <leader>e
Plug 'wesQ3/vim-windowswap'                    " Swap windows with ,ww
Plug 'APZelos/blamer.nvim'                     " Preview git blame (like VSCode)
Plug 'airblade/vim-gitgutter'                  " Show modified lines
Plug 'numToStr/Comment.nvim'                   " Comment things out with gcc
Plug 'christoomey/vim-conflicted'              " Handle git conflicts in vim
Plug 'tpope/vim-repeat'                        " Repeat advanced commands with .
Plug 'rhysd/clever-f.vim'                      " Easily repeat one-line searches
Plug 'SirVer/ultisnips'                        " snippets
Plug 'inkarkat/vim-unconditionalpaste'         " Paste blocks as inline items
Plug 'mfussenegger/nvim-dap'                   " Debugging
Plug 'tpope/vim-surround'                      " change surrounding chars
Plug 'pantharshit00/vim-prisma'                " Prisma syntax highlighting
Plug 'nvim-lua/popup.nvim'                     " Requisite for Telescope + Spectre
Plug 'nvim-lua/plenary.nvim'                   " Requisite for Telescope + Spectre
Plug 'nvim-telescope/telescope.nvim'           " Better fuzzyfinding
Plug 'nvim-telescope/telescope-dap.nvim'       " Move through callstack in Telescope
Plug 'windwp/nvim-spectre'                     " Find + replace across files
Plug 'rbgrouleff/bclose.vim'                   " Dependency for ranger.vim
Plug 'kevinhwang91/rnvimr'
Plug 'bkad/camelcasemotion'                    " Delete single words in camel_case_words
Plug 'ruanyl/vim-gh-line'                      " View lines and commits in GitHub
Plug 'dense-analysis/ale'                      " Needed for certain languages that CoC doesn't support
Plug 'github/copilot.vim'                      " GitHub Copilot
Plug 'vim-scripts/Tabmerge'
Plug 'sindrets/diffview.nvim'                  " View git diffs
Plug 'TimUntersberger/neogit'                  " Git commit
Plug 'arzg/vim-colors-xcode'                   " light mode (xcode inspired)
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' } " Prettier tabs
Plug 'saecki/crates.nvim', { 'tag': 'v0.2.1' } " See latest Rust crate versions in cargo.toml
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better syntax
Plug 'nvim-treesitter/nvim-treesitter-context' " show which function you're inside
Plug 'ggandor/leap.nvim'                       " Jump to words with s
call plug#end()

"
" --- plugin configs ---

" - leap.nvim
lua << EOF
require('leap').set_default_keymaps()
EOF

"  - nvim-web-devicons
lua << EOF
require'nvim-web-devicons'.setup {
  default = true,
  override = {
    ["default_icon"] = {
      icon = "",
      color = "#6d8086",
      name = "Default",
    }
  }
}
EOF

" lualine
lua << EOF
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'filetype',
        icon_only = true
      },
      {
        'filename',
        path = 1,
        shorting_target = 0,
        symbols = {
          modified = '',
          readonly = '',
          unnamed = 'unnamed',
        }
      }
    },
    lualine_c = {},
    lualine_x = {
      {
        'diagnostics',
        sources = { 'coc' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
          error = '✘ ', 
          warn = '⚠ ', 
          info = 'ⓘ  ', 
          hint = 'ⓘ  '
        },
        colored = true,
        always_visible = false,
      }
    },
    lualine_y = {'filetype'},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {
      {
        'diagnostics',
        sources = { 'coc' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
          error = '✘ ', 
          warn = '⚠ ', 
          info = 'ⓘ  ', 
          hint = 'ⓘ  '
        },
        colored = true,
        always_visible = false,
      }
    },
    lualine_y = {'filetype'},
    lualine_z = {}
  },
}
EOF

" easy commands for creating, closing, breaking, merging tabs
nmap <silent> tn :tabe<cr>
nmap <silent> tx :tabclose<cr>
nmap <silent> tb <C-W>T
nmap <silent> tm :Tabmerge right<cr>
nmap <silent> tj :Tabmerge right<cr>

lua << EOF
require("bufferline").setup{
  highlights = {
    fill = {
      guibg = '#1F2126',
    },
  },
  options = {
    mode = "tabs",
    close_icon = '',
    buffer_close_icon = '',
    modified_icon = '~',
    diagnostics = "coc",
    separator_style = "thin",
    always_show_bufferline = false
  }
}
EOF

" comment out with gcc
lua require('Comment').setup()

" show outdated crates in Cargo.toml
lua require('crates').setup()

" Delete _words_ with di_
omap <silent> i_ <Plug>CamelCaseMotion_iw
xmap <silent> i_ <Plug>CamelCaseMotion_iw
omap <silent> a_ <Plug>CamelCaseMotion_iw
xmap <silent> a_ <Plug>CamelCaseMotion_iw

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "rust", "prisma", "solidity", "sql", "ruby" },
  auto_install = true,
  highlight = {
    enable = true,
  }
}
EOF

" - rnvimr (ranger)
map <leader>r :RnvimrToggle<cr>
let g:rnvimr_enable_ex = 1      " Replace Netrw to be the default file explorer
let g:rnvimr_enable_picker = 1  " Hide Ranger after picking a file:

" Open Ranger files in vsplit:
let g:rnvimr_action = { 
  \ '<C-v>': 'NvimEdit vsplit',
  \ }

" - vim-one
set termguicolors                " enable true colors support

" dark
colorscheme one                  " Use OneDark color scheme
" light
" colorscheme xcodelight

highlight VertSplit gui=reverse guibg=#3e4452 guifg=bg

" darker bg for command bar:
highlight MsgArea guibg=#1F2126

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" - fzf
nmap <silent> <c-p> :Rg<cr>
" nmap <silent> <c-f> :Files<cr>
nmap <silent> <c-b> :Buffers<cr>

" - coc.nvim
" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <nowait><expr> <S-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<S-j>"
nnoremap <nowait><expr> <S-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<S-k>"
nnoremap <silent> <leader>a  :CocAction<cr>
nnoremap <silent> <leader>aj :call CocAction('diagnosticNext')<cr>
nnoremap <silent> <leader>ak :call CocAction('diagnosticPrevious')<cr>
inoremap <silent><expr> <c-c> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
" go back after gt:
nmap <silent> gb <C-o>
nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (expand('%:t') == 'Cargo.toml')
    lua require('crates').show_popup()
  else
    call CocAction('doHover')
  endif
endfunction

let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'

let g:coc_filetype_map = {
  \ 'html.handlebars': 'handlebars',
\ }

" Set syntax highlighting for .env.local, .env.development, .env.production...
au! BufNewFile,BufRead .env.* set filetype=sh
au! BufNewFile,BufRead zshrc set filetype=sh

" Set filetype for Cairo (Starknet)
au BufReadPost *.cairo set filetype=cairo
au Filetype cairo set syntax=cairo

" - ale
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'solidity': ['solhint'],
\}

" - vim-over
nnoremap <leader>fr :call VisualFindAndReplace()<cr>
vnoremap <leader>fr :call VisualFindAndReplaceWithSelection()<cr>

function! VisualFindAndReplace()
  :OverCommandLine%s/
  :w
endfunction

function! VisualFindAndReplaceWithSelection() range
  :'<,'>OverCommandLine s/
  :w
endfunction

" -nvim-spectre
nnoremap <leader>F :lua require('spectre').open()<CR>
" Note: Run replace with <leader>R

" - vim-gh-line
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_line_blame_map = '<leader>gh'
let g:gh_line_map = '<leader>gl'

" - fugitive / diffview
nmap <leader>gs :DiffviewOpen<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gc :Neogit kind="floating" commit<CR>

function! s:ftplugin_fugitive() abort
  nnoremap <buffer> <silent> cc :vertical Git commit --quiet<CR>
  nnoremap <buffer> <silent> ca :vertical Git commit --quiet --amend<CR>
  nnoremap <buffer> <leader> ge :call ExitFugitive()<cr>
endfunction
augroup nhooyr_fugitive
  autocmd!
  autocmd FileType fugitive call s:ftplugin_fugitive()
augroup END

function! ExitFugitive()
  :wincmd k
  :wincmd l
  :only
endfunction

" - vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let test#strategy = "vtr"

" - vim-tmux-runner
let g:VtrOrientation = "h"
let g:VtrPercentage = 40
nmap <leader>va :VtrAttachToPane<CR>

" - blamer-nvim
let g:blamer_enabled = 1
let g:blamer_show_in_insert_modes = 0
let g:blamer_relative_time = 1

" - vim-conflicted
set stl+=%{ConflictedVersion()}  " Show version name in splits during vim-conflicted
nnoremap <leader>gnc :GitNextConflict<cr>

" - coc-snippets
" expand snippet when pressing enter:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" go to language's snippet file by running :Snip
command! Snip :CocCommand snippets.editSnippets
nnoremap <silent>tt :CocRestart<cr><cr>

" - unconditionalpaste
nmap <Leader>pi <Plug>UnconditionalPasteInlinedAfter

" - nvim-dap
lua << EOF
  local dap = require('dap')
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/dev/utils/vscode-node-debug2/out/src/nodeDebug.js'},
  }
  local jsConfig = {
    {
      type = 'node2',
      request = 'attach',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
    },
  }
  dap.configurations.javascript = jsConfig
  dap.configurations.typescript = jsConfig
  vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='🟡', texthl='', linehl='', numhl=''})
EOF

nnoremap <leader>da :lua require'dap'.continue()<CR>
nnoremap <leader>dc :lua require'dap'.continue()<CR>
nnoremap <leader>dd :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <S-k> :lua require'dap'.up()<CR>
" nnoremap <S-j> :lua require'dap'.down()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>pi
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
vnoremap <leader>di :lua require'dap.ui.widgets'.visual_hover()<CR>

" - telescope
lua << EOF
  local actions = require('telescope.actions')
  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ['<c-j>'] = actions.move_selection_next,
          ['<c-k>'] = actions.move_selection_previous,
          ['<esc>'] = actions.close,
        },
      }
    }
  }

  require('telescope').load_extension('dap')
EOF

" - telescope mappings
nnoremap <silent> <c-f> :lua require'telescope.builtin'.find_files({
\   find_command = {'rg', '--files', '--hidden', '-g', '!.git' }
\ })<cr>
" nnoremap <silent> <c-b> :lua require("telescope.builtin").buffers({
" \   sort_lastused = true,
" \   ignore_current_buffer = true,
" \   sorter = require'telescope.sorters'.get_substr_matcher()
" \ })<cr>
" " live_grep is not used because it's slow + results aren't as good as fzf
" nnoremap <silent> <c-p> <cmd>Telescope live_grep<cr>
nnoremap <leader>df :Telescope dap frames<CR>
