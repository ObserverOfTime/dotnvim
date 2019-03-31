scriptencoding utf-8

" Append newline to file
set fixendofline
" Do smart autoindenting
set smartindent
" Convert tabs to spaces
set expandtab
" Save undo history to a file
set undofile
" Turn paste mode off
set nopaste
" Don't wrap lines
set nowrap
" Show line numbers
set number
" Don't close hidden buffers
set hidden
" Show special characters
set list

" Completion options (:h completeopt)
set completeopt=noinsert,noselect,preview,menuone
" Switch to open buffers or tabs
set switchbuf=useopen,usetab
" Format options (:h fo-table)
set formatoptions=cqn1j
" Short message options (:h shortmess)
set shortmess=aoOtTcF
" Spellcheck languages
set spelllang=en,el
" Use dark background
set background=dark
" Maximum number of undoable changes
set undolevels=250
" Number of spaces to use for indent
set shiftwidth=4
" Level of folds to hide
set foldlevel=1
" Number of spaces to use for tabs
set tabstop=4
" Enable mouse in all modes
set mouse=ar

if $TERM !=# 'xfce4-terminal'
    " Set cursor styling (:h guicursor)
    set guicursor=v-sm:block,i-ci-ve:ver25,r-o-n-c-cr:hor25
else
    " Terminal bug workaround (neovim/neovim#7722)
    set guicursor=
endif

" Show substitution preview
if exists('&inccommand') | set inccommand=split | endif

" Set undodir for regular vim
if !has('nvim')
    if has('win32') | set undodir=~/vimfiles/undo
    else | set undodir=~/.vim/undo | endif
endif

" Set special characters
if &encoding ==? 'utf-8'
    set fillchars=vert:┊,fold:–
    set listchars=tab:‣‣,trail:·,nbsp:⍽,precedes:«,extends:»
    set showbreak=↪
else
    set fillchars=vert:\|,fold:-
    set listchars=tab:>>,trail:~,nbsp:_,precedes:@,extends:#
    set showbreak=^
endif


