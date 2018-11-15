scriptencoding utf-8

set fixendofline
set smartindent
set expandtab
set undofile
set nopaste
set nowrap
set number
set hidden
set list

set completeopt=noinsert,noselect,preview,menuone
set switchbuf=useopen,usetab
set formatoptions=cqn1j
set shortmess=aoOtTcF
set background=dark
set undolevels=250
set shiftwidth=4
set foldlevel=1
set tabstop=4
set mouse=ar

if $TERM !=# 'xfce4-terminal'
    set guicursor=v-sm:block,i-ci-ve:ver25,r-o-n-c-cr:hor25
else
    set guicursor= " Terminal bug workaround (#7722)
endif

if exists('&inccommand')
    set inccommand=split
endif

if !has('nvim')
    if has('win32') | set undodir=~/vimfiles/undo
    else | set undodir=~/.vim/undo | endif
endif

if &encoding ==? 'utf-8'
    set fillchars=vert:┊,fold:–
    set listchars=tab:‣‣,trail:·,nbsp:⍽,precedes:«,extends:»
    set showbreak=↪
else
    set fillchars=vert:\|,fold:-
    set listchars=tab:>>,trail:~,nbsp:_,precedes:@,extends:#
    set showbreak=^
endif


