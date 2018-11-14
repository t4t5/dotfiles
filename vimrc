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
Plugin 'itchyny/lightline.vim'         " Powerline replacement
Plugin 'wesQ3/vim-windowswap'          " Swap windows with ,ww
Plugin 'airblade/vim-gitgutter'        " Show modified lines
Plugin 'crusoexia/vim-monokai'         " Monokai color scheme
Plugin 'valloric/youcompleteme'        " Autocompletion
Plugin 'christoomey/vim-tmux-navigator' " Use normal VIM navigation in Tmux too

" Syntax highlighters
Plugin 'cespare/vim-toml'              " TOML Syntax highlighting
Plugin 'leafgarland/typescript-vim'    " TypeScript syntax
Plugin 'wavded/vim-stylus'             " Stylus syntax highlighting
Plugin 'posva/vim-vue'                 " Vue syntax
Plugin 'joukevandermaas/vim-ember-hbs' " Handlebars syntax highlighting
Plugin 'isRuslan/vim-es6'              " ES6 syntax
Plugin 'digitaltoad/vim-jade'          " Jade/Pug syntax
Plugin 'alampros/vim-styled-jsx'       " Styled JSX
Plugin 'stephenway/postcss.vim'        " PostCSS syntax
Plugin 'tomlion/vim-solidity'          " Ethereum Solidity syntax

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

" Open new horizontal pane below, which feels more natural
set splitbelow

" --- Color theme ---
syntax enable
set background=dark
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11

try
  colorscheme monokai                  " Use Monokai theme
catch
endtry


" --- Plugin configurations ---

let g:airline_powerline_fonts = 1
set laststatus=2                       " Always display the status line (For Powerline/Lightline)

" Toggle NERDTree with ,d:
map <Leader>d :NERDTreeToggle<CR>
let NERDTreeShowHidden=1               " Show hidden files

let g:ctrlp_show_hidden=1              " Show hidden files in CTRLP
let g:ctrlp_by_filename=0
set wildignore+=.DS_Store,.git,node_modules,.next,.tmp,dist
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

