"
" --- better defaults

let mapleader = ","              " Set <leader> to ',' instead of '\'

filetype plugin indent on        " Load plugin, indent for filetype

set expandtab 		               " On pressing tab, insert 2 spaces
set tabstop=2                    " show existing tab with 2 spaces width
set softtabstop=2
set shiftwidth=2	               " when indenting with '>', use 2 spaces width

set ignorecase                   " Ignore case when searching
set smartcase                    " When searching, try to be smart about cases

set clipboard=unnamed	           " Always copy/paste to clipboard

set number                       " Show line numbers
set numberwidth=5                " Gutter width
set relativenumber               " Relative line numbers

set splitbelow                   " Open new horizontal pane below, which feels more natural

" No newline at end of file:
autocmd FileType html.handlebars setlocal noeol binary

"
" --- custom shortcuts

" vv to generate new vertical split
nnoremap <silent> vv :vnew<cr>

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

" easy commands for creating, closing, breaking, merging tabs
nmap <silent> tn :tabe<cr>
nmap <silent> tx :tabclose<cr>
nmap <silent> tb <C-W>T
nmap <silent> tm :Tabmerge right<cr>
nmap <silent> tj :Tabmerge right<cr>

" stop highlighting last search by pressing return key
nnoremap <CR> :noh<CR><CR>

" Format json with :JSON
com! Json %!python -m json.tool

"
" --- vim-plug plugins ---

call plug#begin()
Plug 'scrooloose/nerdtree'                     " NERDTree
Plug 'itchyny/lightline.vim'                   " Powerline replacement
Plug 'maximbaz/lightline-ale'                  " Ale indicator for Lightline
Plug 'rakr/vim-one'                            " OneDark color scheme
Plug 'junegunn/fzf'                            " Fuzzyfinder
Plug 'junegunn/fzf.vim'                        " Better Vim support for fzf
Plug 'w0rp/ale'                                " Linting warnings
Plug 'christoomey/vim-tmux-navigator'          " ctrl + hjkl navigation between vim and tmux panes
Plug 'neoclide/coc.nvim'                       " autocompletion
Plug 'ryanoasis/vim-devicons'                  " File icons in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Colors for the icons
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
call plug#end()

"
" --- plugin configs ---

" - NERDTree
map <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden=1         " Show hidden files in NERDTree

" - vim-one
set termguicolors                " enable true colors support
colorscheme one                  " Use OneDark color scheme

" - fzf
nmap <silent> <c-p> :Rg<cr>
nmap <silent> <c-f> :Files<cr>
nmap <silent> <c-b> :Buffers<cr>

" - ale
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_fixers = {
  \'*': ['remove_trailing_lines', 'trim_whitespace'],
  \'javascript': ['prettier'],
  \'typescript': ['prettier'],
  \'typescriptreact': ['prettier'],
  \'handlebars': ['prettier'],
  \'svelte': ['prettier'],
  \'css': ['prettier'],
  \'rust': ['rustfmt'],
\}

" move to next/previous error with <leader>aj and <leader>ak
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" - coc.nvim
" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

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

" - fugitive
nmap <leader>gs :Gstatus<cr><c-w>k<c-w>K<c-w>p
nmap <leader>gd :Gvdiff<CR>

" - vim-tmux-navigator
" Make NERDTree work well with vim-tmux-navigator
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

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

" - Lightline
let g:lightline = {
  \  'colorscheme': 'one',
\ }
let g:lightline.component_expand = {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
\ }
let g:lightline.component_type = {
  \  'linter_checking': 'left',
  \  'linter_warnings': 'warning',
  \  'linter_errors': 'error',
  \  'linter_ok': 'left',
\ }
let g:lightline.active = {
  \  'left':  [[ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ]],
  \  'right': [
  \    [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]
  \  ]
\ }
let g:lightline.inactive = {
  \ 'right': []
\ }
