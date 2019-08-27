"--------"
" VUNDLE "
"--------"

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" NerdTree
Plugin 'scrooloose/nerdtree'

" Vim Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Vim Fugitive
Plugin 'tpope/vim-fugitive'

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'

" Tagbar
Plugin 'majutsushi/tagbar'

" Ale (linter)
Plugin 'w0rp/ale'

" Linediff
Plugin 'AndrewRadev/linediff.vim'

" Peekaboo
Plugin 'junegunn/vim-peekaboo'

" Papercolor colorscheme
Plugin 'NLKNguyen/papercolor-theme'

" C Syntax highlight
Plugin 'NLKNguyen/c-syntax.vim'

" Python Syntax highlight
Plugin 'vim-python/python-syntax'

" Vim cursorword, highlight ocurrences of word undercursor
Plugin 'itchyny/vim-cursorword'

" Jedi-vim
Plugin 'davidhalter/jedi-vim'

" GitGutter
Plugin 'airblade/vim-gitgutter'

" Rainbow
Plugin 'luochen1990/rainbow'

" Pulse
Plugin 'inside/vim-search-pulse'

" Show indent guide
Plugin 'nathanaelkane/vim-indent-guides'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

"----------------------"
" PLUGIN CONFIGURATION "
"----------------------"

" Vim Airline configuration
let g:airline_theme='papercolor'
set laststatus=2
set nocompatible
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:Powerline_symbols = 'fancy'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Enable Ale on airline
let g:airline#extensions#ale#enabled = 1

" Configure ALE linters
let g:ale_linters = {'python': ['flake8']}

" Configure ALE fixers
let g:ale_fixers = {
\   'python': [
\       'isort',
\       'yapf',
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ]
\}

" NERDTree configuration
" Ctrl-n to open/close NERDTree
map <C-n> :NERDTreeToggle<CR>

" TagBar configuration
nmap <F9> :TagbarToggle<CR>

" Jedi-vim configuration
let g:jedi#popup_on_dot = 0

" GitGutter
set updatetime=1000 " Time to update marks

" Enable Rainbow
let g:rainbow_active = 1

" Configure Indent Guides
let g:indent_guides_guide_size = 1

" ctags and cscope configuration

" set the ctags file name
set tags=tags,ctags,.tags,.ctags


" Use .../tags in ancestor of source directory.
" useful when you have source tree eight fathom deep,
" an exercise in Vim loops.
let parent=1
let local_tags = ".tags/ctags"
let local_cscope = ".tags/cscope.out"
exe ":set tags+=".local_tags
exe ":cs add ".local_cscope

while parent <= 8
  let local_tags = "../". local_tags
  let local_cscope = "../". local_cscope
  exe ":set tags+=".local_tags
  exe ":cs add ".local_cscope
  let parent = parent+1
endwhile

" cscope map
" s: Find this C symbol
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" g: Find this definition
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
" c: Find functions calling this function
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
" t: Find this text string
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
" e: Find this egrep pattern
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
" f: Find this file
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
" i: Find files #including this file
nmap <C-\>i :cs find i [/]?<C-R>=expand('%:t')<CR><CR>
" d: Find functions called by this function
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" a: Find places where this symbol is assigned a value
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" Find the file that you type. Some projects copy the header
" files in different places (/include, /refs, /releases). So 
" with this shortcut, you can find copies of files using the 
" CSCOPE database (CtrlP fails when a project has many .git 
" repository). Use % to search the current filename 
nmap <C-\>F :cs find f

let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

" Enable python syntax highlight plugin
let g:python_highlight_all = 1

"----------------------"
" VIM CONFIGURATION "
"----------------------"

" change ~/.viminfo to a more convenient place
set viminfo+=n~/.vim/viminfo

set encoding=utf-8

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline

"------------
" Colors
"------------
set t_Co=256

set background=dark
colorscheme PaperColor

" Change line number column to white
highlight LineNr ctermfg=white

" Default behavior

" Highlight all matches of the last search
set hlsearch

" Disable case sensitive in search
"set ignorecase

" Highlight matching pattern while typing the search command
set incsearch

" Briefly jump and show the matching bracket when inserting one.
"set showmatch

" Disable text wrap
"set nowrap

" Width switch
""" --- raoni @ Mon Jan  6 09:53:22 BRST 2014
""" Commented out next line to preserve initial setup per filetype, like
""" gitcommit messages.
"set textwidth=0
""" --- raoni END
" Highlight 'textwidth' column
set colorcolumn=+1
function! Switchwidth()
    if &textwidth == 0
        set textwidth=120
    elseif &textwidth == 120
        set textwidth=100
    elseif &textwidth == 100
        set textwidth=90
    elseif &textwidth == 90
        set textwidth=80
    elseif &textwidth == 80
        set textwidth=70
    elseif &textwidth == 70
        set textwidth=60
    elseif &textwidth == 60
        set textwidth=0
    else
        set textwidth=0
    endif
    "set cc=+1
    echo &textwidth " columns"
endfunction

" Key mappings
 map <silent> <F8> :call Switchwidth()<cr>

" more powerful backspacing
set backspace=indent,eol,start

" keep 1000 lines of command line history. Yea, 1k because i like history.
set history=1000

" show the cursor position all the time. It also show more informations like
" line & column of the cursor
set ruler

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.d,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" column with line number
set number
"set relativenumber

" use mouse
set mouse=a
" use advanced mouse handling. It is workaroung for when using tmux, that vim
" don't recognize the xterm terminal version type.
set ttymouse=xterm2

" automatic load syntax highlight
syntax on

"to load plugin files for specific file types (needed for vimwiki)
filetype plugin on

" Open vertical splits to the right
set splitright

" map up and down keys to move up and down by visible lines not the actual real
" lines (aka. separated by linebreak) (only works in command mode)
map <Up> gk
map <Down> gj

" remap j/k the same as up/down, but not in count commands.
" From: http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" c syntax optionals: GNU gcc specific items
let c_gnu = 1
" trailing white space and spaces before a <Tab>
let c_space_errors = 1
" Show partial command (as you type) in the last line of the screen
set  showcmd

" Any buffer can be hidden (keeping its changes) without first writing
" the buffer to a file
set hidden

" better highlight for vimdiff when using syntax highlight
" highlight DiffAdd    term=bold    cterm=NONE ctermfg=7 ctermbg=4          guifg=White guibg=LightBlue
" highlight DiffChange term=bold    cterm=NONE ctermfg=7 ctermbg=5          guifg=White guibg=LightMagenta
" highlight DiffDelete term=bold    cterm=NONE ctermfg=7 ctermbg=6 gui=bold guifg=Blue  guibg=LightCyan
" highlight DiffText   term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red

" set autoindent to indent paragraph when formating.
set autoindent

" Enable justify for paragraph formating. Use  '_j' to do the job
"runtime macros/justify.vim

" from vim-help: Every wrapped line will continue visually indented (same
" amount of space as the beginning of that line), thus preserving horizontal
" blocks of text.
set breakindent

" wrap lines at word boundaries when using ':set wrap'
set linebreak

" This are to show some simbols in numbers columns for wrapped lines.
"set breakindentopt=sbr  " Make showbreak print before breakindent
"set cpoptions+=n        " Make showbreak print starting in numbers columns
"set showbreak=" ++"     " Charactes to print
set showbreak=↪\  
"set highlight-=@:NonText " Remove default highlight for showbreak
set highlight+=@:Folded  " Use a new highlight

set list
set listchars=tab:▸\ ,trail:␣,nbsp:⍽
set highlight+=8:WarningMsg  " Use a new highlight

" Indentation related configs
let &l:expandtab   = 1
let &l:smarttab    = 0
let &l:tabstop     = 8
let &l:shiftwidth  = 2
let &l:softtabstop = 2

function! SwitchIndent()
    if !exists("b:indenttype")
        let b:indenttype = 0

        let b:save_expandtab   = &l:expandtab
        let b:save_smarttab    = &l:smarttab
        let b:save_tabstop     = &l:tabstop
        let b:save_shiftwidth  = &l:shiftwidth
        let b:save_softtabstop = &l:softtabstop
    endif

    if b:indenttype == 0
        echo "Indent Style: 2 (space)"
        let b:indenttype += 1

        let b:save_expandtab   = &l:expandtab
        let b:save_smarttab    = &l:smarttab
        let b:save_tabstop     = &l:tabstop
        let b:save_shiftwidth  = &l:shiftwidth
        let b:save_softtabstop = &l:softtabstop

        let &l:expandtab   = 1
        let &l:smarttab    = 0
        let &l:tabstop     = 8
        let &l:shiftwidth  = 2
        let &l:softtabstop = 2

    elseif b:indenttype == 1
        echo "Indent Style: 4 (space)"
        let b:indenttype += 1

        let &l:expandtab   = 1
        let &l:smarttab    = 0
        let &l:tabstop     = 8
        let &l:shiftwidth  = 4
        let &l:softtabstop = 4

    elseif b:indenttype == 2
        echo "Indent Style: 8 (space)"
        let b:indenttype += 1

        let &l:expandtab   = 1
        let &l:smarttab    = 0
        let &l:tabstop     = 8
        let &l:shiftwidth  = 8
        let &l:softtabstop = 8

    elseif b:indenttype == 3
        echo "Indent Style: 8 (tab)"
        let b:indenttype += 1

        let &l:expandtab   = 0
        let &l:smarttab    = 0
        let &l:tabstop     = 8
        let &l:shiftwidth  = 8
        let &l:softtabstop = 8

    else
        echo "Indent Style: ORIGINAL"
        let b:indenttype = 0

        let &l:expandtab   = b:save_expandtab
        let &l:smarttab    = b:save_smarttab
        let &l:tabstop     = b:save_tabstop
        let &l:shiftwidth  = b:save_shiftwidth
        let &l:softtabstop = b:save_softtabstop
    endif
endfunction

" Map for easy toggle ident tipes.
map <silent> <F10> :call SwitchIndent()<cr>

" Make tab to complete commands works like in bash
set wildmenu
set wildmode=longest,list

" Run shell commands in split windows
command! -nargs=* Shell set splitright | vnew | r! <args>

" Always have at least 5 lines below cursor (useful for search)
set scrolloff=5

" Move between buffers using f3 and f4
nmap <F3> :bprev<CR>
nmap <F4> :bnext<CR>

" Move between the last two buffers
nmap <F5> :b#<CR>

" Pretty print json
command! PrettyJson :%!python -m json.tool

    let g:rainbow_conf = {
          \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
          \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
          \    'operators': '_,_',
          \    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
          \    'separately': {
          \        '*': {},
          \        'tex': {
          \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
          \        },
          \        'lisp': {
          \            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
          \        },
          \        'vim': {
          \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
          \        },
          \        'html': {
          \            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
          \        },
          \        'css': 0,
          \    }
          \}

" Highlight current line
set cursorline
