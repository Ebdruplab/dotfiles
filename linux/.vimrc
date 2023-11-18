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

" SECTION FOR REGEX HIGHLIGHTS
" Highlight trailing whitespace (helps with YAML syntax errors)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Highlight lines that start with a comment character (#)
highlight CommentLine ctermbg=yellow guibg=yellow
match CommentLine /^#.*$/

" Highlight lines that contain a URL
highlight Url ctermfg=blue guifg=blue
match Url /http[s]\?:\/\/\S\+/

" Highlight lines that contain an email address
highlight Email ctermfg=green guifg=green
match Email /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/

" Highlight lines that contain a URL with a scheme (http://, https://, ftp://, etc.)
highlight SchemeUrl ctermfg=cyan guifg=cyan
match SchemeUrl /\vhttps?:\/\/\S+/

" Highlight valid IPv4 addresses
highlight IPAddr ctermbg=magenta guibg=magenta
2match IPAddr /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.\(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.\(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.\(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/
