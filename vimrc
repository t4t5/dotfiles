let mapleader = ","                    " Set <leader> to ',' instead of '\'

" ---  Vundle setup --- 
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'           " NERDTree
Plugin 'ctrlpvim/ctrlp.vim'            " FuzzyFinder
Plugin 'tpope/vim-surround'            " Allows commands like ds) to delete surrounding parens
Plugin 'tpope/vim-repeat'              " Let plugins use . to repeat commands
Plugin 'w0rp/ale'                      " Async linter
Plugin 'itchyny/lightline.vim'         " Powerline replacement
Plugin 'maximbaz/lightline-ale'        " Ale indicator for Lightline
Plugin 'wesQ3/vim-windowswap'          " Swap windows with ,ww
Plugin 'airblade/vim-gitgutter'        " Show modified lines
Plugin 'valloric/youcompleteme'        " Autocompletion
Plugin 'christoomey/vim-tmux-navigator' " Use normal VIM navigation in Tmux too
Plugin 'sheerun/vim-polyglot'          " Multiple languages
Plugin 'rakr/vim-one'                  " OneDark color scheme

" Syntax highlighters
"Plugin 'cespare/vim-toml'              " TOML Syntax highlighting
"Plugin 'leafgarland/typescript-vim'    " TypeScript syntax
"Plugin 'wavded/vim-stylus'             " Stylus syntax highlighting
"Plugin 'posva/vim-vue'                 " Vue syntax
"Plugin 'joukevandermaas/vim-ember-hbs' " Handlebars syntax highlighting
"Plugin 'digitaltoad/vim-jade'          " Jade/Pug syntax
Plugin 'alampros/vim-styled-jsx'       " Styled JSX
"Plugin 'stephenway/postcss.vim'        " PostCSS syntax
"Plugin 'tomlion/vim-solidity'          " Ethereum Solidity syntax

call vundle#end()            " required
filetype plugin indent on    " required


" --- Configurations ---

set encoding=utf8

set nobackup                           " Turn backup off, since most of it is in git
set nowritebackup
set noswapfile

set showcmd                            " Give visual feedback for <leader> key
set ignorecase                         " Ignore case when searching
set smartcase                          " When searching, try to be smart about cases
set hlsearch                           " Highlight search results
set backspace=2                        " make backspace work like most other apps

set tabstop=2                          " Tabs to spaces
set shiftwidth=2 
set expandtab 
set smarttab
set ai si                              " Set auto indent and smart indent
set number                             " Always show line numbers
set clipboard=unnamed                  " Always copy/paste to clipboard

" Shorter delay for ESC key:
set ttimeout          
set ttimeoutlen=10    

" Open new horizontal pane below, which feels more natural
set splitbelow

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" --- Color theme ---
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"

"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
set termguicolors     " enable true colors support
syntax enable
colorscheme one
au ColorScheme one hi Normal ctermbg=None
set background=dark


" --- Plugin configurations ---

let g:airline_powerline_fonts = 1
set laststatus=2                       " Always display the status line (For Powerline/Lightline)

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

" Toggle NERDTree with ,d:
map <Leader>d :NERDTreeToggle<CR>
let NERDTreeShowHidden=1               " Show hidden files

let g:ctrlp_show_hidden=1              " Show hidden files in CTRLP
let g:ctrlp_by_filename=0
set wildignore+=.DS_Store,.git,node_modules,.next,.tmp,dist
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

