let mapleader = ","                    " Set <leader> to ',' instead of '\'

" ---  Vundle setup ---
set nocompatible
filetype off
set hidden

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'           " NERDTree
Plugin 'junegunn/fzf'                  " Fuzzyfinder
Plugin 'junegunn/fzf.vim'              " Better Vim support for fzf
Plugin 'tpope/vim-surround'            " Allows commands like ds) to delete surrounding parens
Plugin 'tpope/vim-repeat'              " Let plugins use . to repeat commands
Plugin 'w0rp/ale'                      " Async linter
Plugin 'itchyny/lightline.vim'         " Powerline replacement
Plugin 'maximbaz/lightline-ale'        " Ale indicator for Lightline
Plugin 'wesQ3/vim-windowswap'          " Swap windows with ,ww
Plugin 'airblade/vim-gitgutter'        " Show modified lines
Plugin 'valloric/youcompleteme'        " Autocompletion
Plugin 'christoomey/vim-tmux-navigator' " Use normal VIM navigation in Tmux too
Plugin 'rakr/vim-one'                  " OneDark color scheme
Plugin 'brooth/far.vim'                " Find & replace across files
Plugin 'breuckelen/vim-resize'         " Resize window with arrow keys
Plugin 'tpope/vim-fugitive'            " Git stuff
Plugin 'tpope/vim-rhubarb'             " Enables :GBrowse in Fugitive
Plugin 'janko-m/vim-test'              " Run tests easily
Plugin 'christoomey/vim-tmux-runner'   " Run rmux panes from Vim
Plugin 'tpope/vim-commentary'          " Comment things out with gc
Plugin 'mileszs/ack.vim'               " Ack - grep replacement
Plugin 'Tabmerge'                      " Easily join tabs into panes
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-eunuch'              " :Rename, :Delete...etc

" Syntax highlighters
Plugin 'sheerun/vim-polyglot'          " Multiple languages
Plugin 'alampros/vim-styled-jsx'       " Styled JSX
Plugin 'stephenway/postcss.vim'        " PostCSS syntax
Plugin 'ryanoasis/vim-devicons'        " Cool icons
Plugin 'qpkorr/vim-bufkill'            " Kill buffers without closing window

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
set clipboard=unnamed                  " Always copy/paste to clipboard

" Display relative line numbers, with absolute line number for current line
set number
set numberwidth=5
set relativenumber

" Shorter delay for ESC key:
set ttimeout
set ttimeoutlen=10

" Open new horizontal pane below, which feels more natural
set splitbelow

" Format json with :FormatJSON
com! FormatJSON %!python -m json.tool

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Easy string replacement
nnoremap <leader>r :%s//g<left><left>
vnoremap <leader>r :s//g<left><left>

" Remap arrow keys to resize panes
let g:vim_resize_disable_auto_mappings = 1
noremap <Up>    :CmdResizeUp<cr>
noremap <Down>  :CmdResizeDown<cr>
noremap <Left>  :CmdResizeLeft<cr>
noremap <Right> :CmdResizeRight<cr>

" Ctrl + arrow keys to switch between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

nmap <silent> tn :tabe<cr>
nmap <silent> tx :tabclose<cr>
nmap <silent> tb <C-W>T
nmap <silent> tm :Tabmerge right<cr>
nmap <silent> tj :Tabmerge right<cr>

" vv to generate new vertical split
nnoremap <silent> vv :vnew<cr>

" Recordings
" Use qq to start, q to stop and <Space> to play
:nnoremap <Space> @q
vnoremap <silent> <Space> :norm! @q<cr>

" --- Color theme ---
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"

set termguicolors     " enable true colors support
syntax enable
colorscheme one
au ColorScheme one hi Normal ctermbg=None
set background=dark


" --- Plugin configurations ---

let g:airline_powerline_fonts = 1
set laststatus=2                       " Always display the status line (For Powerline/Lightline)

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
let g:lightline.component_function = {
  \   'gitbranch': 'fugitive#head'
\ }
let g:lightline.active = {
  \  'left':  [[ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ]],
  \  'right': [
  \    [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \    [ 'gitbranch' ]
  \  ]
\ }

" ALE
let g:ale_fixers = {
  \'*': ['remove_trailing_lines', 'trim_whitespace'],
  \'javascript': ['prettier'],
  \'typescript': ['prettier'],
  \'css': ['stylelint'],
  \'scss': ['stylelint']
\}
let g:ale_fix_on_save = 1

" Make Far undo work
let g:far#auto_write_undo_buffers = 1

" Move to next/previous error with ,aj and ,ak
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" Test with ,t and ,T
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let test#strategy = "vtr"

" VTR
nnoremap <leader>v- :VtrOpenRunner { "orientation": "v" }<cr>
nnoremap <leader>vr :VtrSendCommandToRunner<space>
nnoremap <leader>va :VtrAttachToPane<cr>
" Run last command:
nnoremap <leader>vl :VtrSendCommandToRunner<cr>
nnoremap <leader>vf :VtrFocusRunner<cr>
nnoremap <leader>vk :VtrKillRunner<cr>

" UltiSnips configuration.
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" Fugitive
nmap <leader>gs :Gstatus<cr><c-w>k<c-w>K<c-w>p
nmap <leader>gd :Gdiff<CR>

" Toggle NERDTree with ,d:
map <leader>d :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " Show hidden files

" Make NERDTree work well with vim-tmux-navigator
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Find file in directory with ,f
nmap <leader>f :NERDTreeFind<cr>

" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" For fzf
set rtp+=/usr/local/opt/fzf
nmap <silent> <c-p> :Rg<cr>
nmap <silent> <c-f> :Files<cr>
nmap <silent> <c-b> :Buffers<cr>
" Bufkil:
nmap <silent> <c-x> :BD<cr>

set wildignore+=.DS_Store,.git,node_modules,.next,.tmp,dist,tmp,bower_components
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
