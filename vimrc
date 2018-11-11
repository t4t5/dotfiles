" ---  Vundle setup --- "
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
"Plugin 'L9'                        " Necessary for FuzzyFinder
"Plugin 'FuzzyFinder'               " Find files quickly
Plugin 'ctrlpvim/ctrlp.vim'        " FuzzyFinder
Plugin 'tpope/vim-surround'        " Allows commands like ds) to delete surrounding parens
Plugin 'tpope/vim-repeat'          " Let plugins use . to repeat commands
Plugin 'bling/vim-airline'         " Powerline replacement
Plugin 'wesQ3/vim-windowswap'      " Swap windows with ,ww
Plugin 'airblade/vim-gitgutter'    " Show modified lines
" Plugin 'scrooloose/syntastic'      " Check for syntax errors
Plugin 'crusoexia/vim-monokai'     " Monokai color scheme
Plugin 'valloric/youcompleteme'    " Autocompletion
Plugin 'mvolkmann/vim-react'       " Toggle between class component and functional component with ,rt
" Plugin 'breuckelen/vim-resize'     " Resize windows with arrow keys
"Plugin 'ternjs/tern_for_vim' " JavaScript autocomplete
" Plugin 'skwp/greplace.vim'         " Search and replace across files
" (...insert more vundle plugins here)

" Syntax highlighters
Plugin 'cespare/vim-toml'          " TOML Syntax highlighting
Plugin 'leafgarland/typescript-vim' " TypeScript syntax
" Plugin 'heartsentwined/vim-emblem' " Emblem syntax highlighting
Plugin 'wavded/vim-stylus'         " Stylus syntax highlighting
Plugin 'posva/vim-vue'             " Vue syntax
" Plugin 'elmcast/elm-vim'           " Elm syntax
Plugin 'joukevandermaas/vim-ember-hbs' " Handlebars syntax highlighting
Plugin 'isRuslan/vim-es6'          " ES6 syntax
Plugin 'digitaltoad/vim-jade'      " Jade/Pug syntax
" Plugin 'kchmck/vim-coffee-script'  " CoffeeScript syntax
" Plugin 'vim-styled-jsx' " styled-jsx
Plugin 'stephenway/postcss.vim'    " PostCSS syntax
Plugin 'tomlion/vim-solidity'      " Ethereum Solidity syntax

" --- Pathogen setup ---"
"execute pathogen#infect()
"syntax on
"filetype plugin indent on " (Also needed for Vundle)

call vundle#end()            " required
filetype plugin indent on    " required

" --- Color theme ---
syntax enable

set background=dark

try
  colorscheme monokai
catch
endtry

set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
let g:airline_powerline_fonts = 1

" Turn backup off, since most of it is in git
set nobackup
set nowb
set noswapfile

" --- Other customizations ---
set tabstop=2 shiftwidth=2 expandtab smarttab " Tabs to spaces
set ai si " Set auto indent and smart indent
set number " Always show line numbers
set clipboard=unnamed " Always copy/paste to clipboard
"autocmd VimEnter * NERDTree " Bring up NERDTree on the side by default
"autocmd VimEnter * wincmd p " Don't focus on NERDTree window
let NERDTreeShowHidden=1 " Show hidden files

let g:ctrlp_show_hidden=1 " Show hidden files in CTRLP
let g:ctrlp_by_filename=0
set wildignore+=.DS_Store,.git,node_modules
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

set laststatus=2 " For Powerline
set showcmd " Give visual feedback for <leader> key
let mapleader = "," " Set <leader> to ',' instead of '\'
set ignorecase " Ignore case when searching
set smartcase " When searching, try to be smart about cases
set hlsearch " Highlight search results
set foldcolumn=1 " Extra margin on the left
set backspace=2 " make backspace work like most other apps

" Toggle NERDTree with , + d
map <Leader>d :NERDTreeToggle<CR>

" Set colors for line numbers
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guibg=NONE
