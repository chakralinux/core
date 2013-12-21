filetype on                     " Detect filetypes
filetype plugin on              " Load relevant plugins
filetype indent on              " Load indent file for filetype
syntax on                       " Enable syntax highlighting
set autoindent                  " Automatically indent the new line to match previous
set autoread
set backspace=indent,eol,start  " Make the backspace key act like I'm used to
set clipboard=unnamed           " Copy to system clipboard
set completeopt=menuone,longest,preview
set cursorline                  " Highlight cursor line
set encoding=utf-8              " Set UTF-8 encoding
set expandtab                   " Insert spaces instead of tab characters
set foldlevel=99
set foldmethod=indent
set history=32                  " Keep 32 lines of command line history
set hlsearch                    " Highlight search pattern
set ignorecase                  " Case insensitive search
set incsearch                   " Match while typing
set laststatus=2                " Always display statusline
set linebreak
set list
set listchars=eol:¬             " Use this symbol for EOLs
set mouse=a
set nobackup
set nocompatible                " Disable Vi-like behaviour
set noswapfile
set notitle                     " Disable 'Thanks for flying Vim' message
set nowritebackup
set number                      " Display line numbers
set numberwidth=4               " Columns used for line number display
set ruler                       " Show the cursor position all the time
set scrolloff=999               " Number of lines to keep above and beneath cursor
set shiftround
set shiftwidth=4                " Number of spaces for each indent by the < > keys
set shortmess=I                 " Disable startup message
set softtabstop=4               " Number of spaces inserted instead of tab characters
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=4
set termencoding=utf-8          " Set terminal UTF-8 encoding
set textwidth=0                 " Disable hard linewrap
set t_Co=256
set wildmode=list:longest
set wrap                        " Enable soft linewrap
set wrapmargin=0                " Number of characters from the right
colorscheme molokai
