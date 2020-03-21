let mapleader = ","                    " Set <leader> to ',' instead of '\'

" ---  Vundle setup ---
set nocompatible
filetype off
set hidden
set shellcmdflag=-lc

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
Plugin 'tpope/vim-fugitive'            " Git stuff
Plugin 'tpope/vim-rhubarb'             " Enables :GBrowse in Fugitive
Plugin 'janko-m/vim-test'              " Run tests easily
Plugin 'christoomey/vim-tmux-runner'   " Run rmux panes from Vim
Plugin 'tpope/vim-commentary'          " Comment things out with gc
Plugin 'mileszs/ack.vim'               " Ack - grep replacement
Plugin 'Tabmerge'                      " Easily join tabs into panes
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-eunuch'              " :Rename, :Delete...etc
Plugin 'qpkorr/vim-bufkill'            " Kill buffers without closing window
Plugin 'wellle/targets.vim'            " Allows things like ci_, da, ...etc
Plugin 'osyo-manga/vim-over'           " Preview replacement when using %s
Plugin 'christoomey/vim-conflicted'    " Handle git conflicts in vim
Plugin 'sukima/vim-javascript-imports' " Needed for vim-ember-imports
Plugin 'sukima/vim-ember-imports'      " Import Ember's modules with <leader>e
Plugin 'jamessan/vim-gnupg'            " GPG encryption of files

" Syntax highlighters & UI goodies
Plugin 'sheerun/vim-polyglot'          " Multiple languages
Plugin 'alampros/vim-styled-jsx'       " Styled JSX
Plugin 'stephenway/postcss.vim'        " PostCSS syntax
Plugin 'ryanoasis/vim-devicons'        " Cool icons
Plugin 'rust-lang/rust.vim'            " Rust
Plugin 'neoclide/coc.nvim'             " Better error messages

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

" Show version name in splits during vim-conflicted
set stl+=%{ConflictedVersion()}
set diffopt+=vertical
nnoremap <leader>gnc :GitNextConflict<cr>

" Format json with :FormatJSON
com! FormatJSON %!python -m json.tool

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" find-and-replace
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

function! StringToSlug()
  let str = getline('.')
  let slug = join(split(tolower(str), '\W\+'), '-')
  call setline(line('.'), slug)
endfunction

nnoremap <leader>s :call StringToSlug()<cr>

" Remap arrow keys to resize panes
nnoremap <silent> <left> :vertical resize -10<cr>
nnoremap <silent> <right> :vertical resize +10<cr>
nnoremap <silent> <up> :resize +5<cr>
nnoremap <silent> <down> :resize -5<cr>

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

" Make HTML attributes italic (for Operator Mono font)
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic
hi Type    gui=italic cterm=italic
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"

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
  \'svelte': ['prettier'],
  \'rust': ['rustfmt'],
\}
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {
  \'javascript': ['eslint', 'flow'],
  \'svelte': ['stylelint', 'eslint'],
  \'rust': ['rls']
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

" Format Rust files:
let g:rustfmt_autosave = 1

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
set rtp+=~/Library/Application\ Support/Electron/integrations " For Codespace
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" Workaround to trigger UltiSnips with Enter
let g:ulti_expand_or_jump_res = 0 "default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
  call UltiSnips#ExpandSnippetOrJump()
  return g:ulti_expand_or_jump_res
endfunction
inoremap <CR> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":"\n"<CR>

" Fugitive
nmap <leader>gs :Gstatus<cr><c-w>k<c-w>K<c-w>p
nmap <leader>gd :Gvdiff<CR>

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

" Don't bring up preview window for YCM
set completeopt-=preview

" For fzf
set rtp+=/usr/local/opt/fzf
nmap <silent> <c-p> :Rg<cr>
nmap <silent> <c-f> :Files<cr>
nmap <silent> <c-b> :Buffers<cr>
" Bufkil:
nmap <silent> <c-x> :BD<cr>

set wildignore+=.DS_Store,.git,node_modules,.next,.tmp,dist,tmp,bower_components
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
