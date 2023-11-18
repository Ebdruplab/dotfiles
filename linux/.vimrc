" Section General vim configs
colorscheme smyck
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Show the current mode in the status line
set showmode

" Show matching brackets/parentheses
set showmatch

" Faster command-line completion
set wildmenu

" Ignore case in search patterns
set ignorecase

" Show line numbers
"set number

" Section Files, backups and undo

" Turn backup off, since most stuff is in SVN, git etc. anyway...
"set nobackup
"set nowb
set noswapfile

" SECTION Text, tab and indent related
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
" set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines


" Change cursor shape in different modes
let &t_SI = "\e[5 q" " I-Beam in insert mode
let &t_EI = "\e[5 q" " Block in normal mode

