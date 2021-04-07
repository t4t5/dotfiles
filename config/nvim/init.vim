let mapleader = ","              " Set <leader> to ',' instead of '\'

filetype plugin indent on        " Load plugin, indent for filetype

set expandtab 		               " On pressing tab, insert 2 spaces
set tabstop=2                    " show existing tab with 2 spaces width
set softtabstop=2
set shiftwidth=2	               " when indenting with '>', use 2 spaces width

set clipboard=unnamed	           " Always copy/paste to clipboard

set number                       " Show line numbers
set numberwidth=5                " Gutter width
set relativenumber               " Relative line numbers

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

"
" --- vim-plug plugins ---

call plug#begin()
Plug 'scrooloose/nerdtree'       " NERDTree
Plug 'itchyny/lightline.vim'     " Powerline replacement
Plug 'rakr/vim-one'              " OneDark color scheme
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
