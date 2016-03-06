" Best view with a 256 color terminal and Powerline fonts

" Plugins {
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'

  "Plugin 'edkolev/promptline.vim'
  Plugin 'tpope/vim-sensible'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  "Plugin 'powerline/powerline'
  "Plugin 'tpope/vim-flagship'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'tpope/vim-fugitive'
  Plugin 'gcmt/breeze.vim'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'majutsushi/tagbar'
  "Plugin 'jlanzarotta/bufexplorer'
  Plugin 'severin-lemaignan/vim-minimap'
  Plugin 'nelstrom/vim-visual-star-search'
  "Plugin 'Shougo/neocomplete.vim.git'
  "Plugin 'Shougo/neosnippet'
  "Plugin 'Shougo/neosnippet-snippets'
  "Plugin 'SirVer/ultisnips'
  "Plugin 'msanders/snipmate.vim'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'ervandew/supertab'
  Plugin 'honza/vim-snippets'
  Plugin 'sjl/gundo.vim'
  Plugin 'Yggdroot/indentLine'
  "Plugin 'luochen1990/indent-detector.vim'
  Plugin 'tpope/vim-sleuth'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-endwise'
  Plugin 'tomtom/tcomment_vim'
  "Plugin 'scrooloose/nerdcommenter'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'nvie/vim-togglemouse'
  "Plugin 'LucHermitte/lh-vim-lib'
  "Plugin 'LucHermitte/lh-tags'
  "Plugin 'LucHermitte/lh-dev'
  "Plugin 'LucHermitte/lh-brackets'
  Plugin 'alvan/vim-closetag'
  Plugin 'Townk/vim-autoclose'
  Plugin 'godlygeek/tabular'
  Plugin 'neilagabriel/vim-geeknote'
  Plugin 'elzr/vim-json'
  Plugin 'Konfekt/FastFold'
  Plugin 'scrooloose/syntastic'
  Plugin 'luisdavim/pretty-folds'
  Plugin 'lilydjwg/colorizer'
  "Plugin 'chriskempson/base16-vim'
  Plugin 'flazz/vim-colorschemes'

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required
  " To ignore plugin indent changes, instead use:
  "filetype plugin on
" }

" ColorThemes {
  highlight clear
  set background=dark
  set t_Co=256

  color Tomorrow-Night-Bright

  " Overrides
  "set transparency=15 "only works in macvim
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi Folded ctermbg=none

  set guifont=droid\ sans\ mono\ for\ powerline\ plus\ nerd\ file\ types\ 10
" }

" GeneralSettings {
  " Open files allways in new tabs
  autocmd VimEnter * tab all
  "autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

  if has('autocmd')
    filetype plugin indent on
  endif
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif

  " Use :help 'option' to see the documentation for the given option.
  set autoindent
  set smartindent
  set backspace=indent,eol,start
  set complete-=i
  set showmatch
  set showmode
  set smarttab
  set scrolloff=1

  set nrformats-=octal
  set shiftround

  set ttimeout
  set ttimeoutlen=50

  set cursorline

  set laststatus=2
  set ruler
  set showcmd
  set wildmenu

  set autoread

  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=AL

  set encoding=utf-8
  set tabstop=2 shiftwidth=2 expandtab
  set listchars=tab:▒░,trail:▓
  set list

  set number
  set incsearch
  set hlsearch
  set ignorecase
  set smartcase

  " In many terminal emulators the mouse works just fine, thus enable it.
  if has('mouse')
    set mouse=a
  endif

  " do not history when leavy buffer
  set hidden

  set nobackup
  set nowritebackup
  set noswapfile
  set fileformats=unix,dos,mac

  set completeopt=menuone,longest,preview
" }

" PluginSettings {
  " GeekNote
  "let g:GeeknoteFormat="markdown"

  " Gundu
  "let g:gundo_width = 60
  "let g:gundo_preview_height = 40
  "let g:gundo_right = 1

  " MinMap
  let g:minimap_highlight='Visual'

  " IndentLine
  let g:vim_json_syntax_conceal = 0
  let g:indentLine_char = '┊'
  let g:indentLine_leadingSpaceEnabled = 1
  let g:indentLine_leadingSpaceChar = '˰'
  let g:indentLine_noConcealCursor = ""

  " Vim
  let g:indentLine_color_term = 239
  "GVim
  let g:indentLine_color_gui = '#A4E57E'
  " none X terminal
  let g:indentLine_color_tty_light = 7 " (default: 4)
  let g:indentLine_color_dark = 1 " (default: 2)'

  " CtrlP
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
  " NOTE: The following should make CtrlP faster
  "let g:ctrlp_match_window = 'bottom,order:ttb'
  "let g:ctrlp_switch_buffer = 0
  "let g:ctrlp_working_path_mode = 0
  "let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  "let g:ctrlp_working_path_mode = 'ra'
  " Always open files in new tabs
  let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<c-t>'],
      \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
      \ }

  " Ultisnip
  " NOTE: <f1> otherwise it overrides <tab> forever
  let g:UltiSnipsExpandTrigger="<C-tab>"
  let g:UltiSnipsJumpForwardTrigger="<C-tab>"
  let g:UltiSnipsJumpBackwardTrigger="<C-S-tab>"
  let g:did_UltiSnips_vim_after = 1

  " make YCM compatible with UltiSnips (using supertab)
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  let g:SuperTabDefaultCompletionType = '<C-n>'
  " Disable YCM
  let g:loaded_youcompleteme = 1

  " Brackets
  let g:usemarks = 0

  " vim-airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_min_count = 1
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline_powerline_fonts = 1
  "let g:airline_theme='badwolf'
  let g:airline_theme='term'
" }

" Shortcuts {
  " Don't use Ex mode, use Q for formatting
  map Q gq

  " Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
  endif

  inoremap <C-U> <C-G>u<C-U>

  " FIXME: (broken) ctrl s to save
  noremap  <C-s> :update<CR>
  vnoremap <C-s> <C-C>:update<CR>
  inoremap <C-s> <Esc>:update<CR>

  " exit insert mode
  inoremap <C-c> <Esc>

  " Find
  map <C-f> /
  " indend / deindent after selecting the text with (⇧ v), (.) to repeat.
  vnoremap <Tab> >
  vnoremap <S-Tab> <
  " comment / decomment & normal comment behavior
  vmap <C-m> gc
  vmap <C-/> gc
  nnoremap <C-/> gcc
  inoremap <C-/> gcc
  " Disable tComment to escape some entities
  let g:tcomment#replacements_xml={}
  " Text wrap simpler, then type the open tag or ',"
  vmap <C-w> S

  " Cut, Paste, Copy
  vmap <C-x> d
  vmap <C-v> p
  vmap <C-c> y
  nnoremap <F2> :set invpaste paste?<CR>
  set pastetoggle=<F2>

  " Undo, Redo (broken)
  nnoremap <C-z>  :undo<CR>
  inoremap <C-z>  <Esc>:undo<CR>
  nnoremap <C-y>  :redo<CR>
  inoremap <C-y>  <Esc>:redo<CR>
  nnoremap <F5> :GundoToggle<CR>

  " Tabs

  " Tab navigation
  nnoremap <C-b>  :tabprevious<CR>
  inoremap <C-b>  <Esc>:tabprevious<CR>i
  nnoremap <C-n>  :tabnext<CR>
  inoremap <C-n>  <Esc>:tabnext<CR>i
  nnoremap <C-t>  :tabnew<CR>
  inoremap <C-t>  <Esc>:tabnew<CR>i
  nnoremap <C-k>  :tabclose<CR>
  inoremap <C-k>  <Esc>:tabclose<CR>i
  nnoremap <S-h> gT
  nnoremap <S-l> gt

  "tab navigation like firefox
  "nnoremap <C-S-tab> :tabprevious<CR>
  "nnoremap <C-tab>   :tabnext<CR>
  "nnoremap <C-t>     :tabnew<CR>
  "inoremap <C-S-tab> <Esc>:tabprevious<CR>i
  "inoremap <C-tab>   <Esc>:tabnext<CR>i
  "inoremap <C-t>     <Esc>:tabnew<CR>

  " lazy ':'
  map ; :

  let mapleader = '\'
  nnoremap <Leader>p :set paste<CR>
  nnoremap <Leader>o :set nopaste<CR>
  noremap  <Leader>g :GitGutterToggle<CR>
  noremap  <Leader>tb :TagbarToggle<CR>
  noremap  <Leader>nt :NERDTreeToggle<CR>
  noremap  <C-\> :NERDTreeToggle<CR>
  nmap <leader>TB <Plug>ToggleBrackets
  imap <leader>TB <Plug>ToggleBrackets

" }

fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()
noremap <Leader>w :call TrimWhitespace()<CR>
" Some people like to automatically do this before they write a file to disk, like so:
"autocmd BufWritePre * :call TrimWhitespace()

" this machine config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
