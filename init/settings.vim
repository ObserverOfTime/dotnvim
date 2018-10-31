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

set guicursor=v-sm:block,i-ci-ve:ver25,r-o-n-c-cr:hor25
set completeopt=noinsert,noselect,preview,menuone
set switchbuf=useopen,usetab
set shortmess=aoOtTcF
set undolevels=50
set shiftwidth=4
set foldlevel=1
set tabstop=4
set mouse=ar

if exists('&inccommand')
    set inccommand=split
endif

if !has('nvim')
    if has('win32') | set undodir=~/vimfiles/undo
    else | set undodir=~/.vim/undo | endif
endif

if &encoding ==? 'utf-8'
    set listchars=tab:‣‣,trail:·,nbsp:⍽,precedes:«,extends:»
    set showbreak=↪
else
    set listchars=tab:>>,trail:-,nbsp:_,precedes:@,extends:#
    set showbreak=^
endif

" Gruvbox theme {{{
if &t_Co == 256
    try
        colorscheme gruvbox
        let g:gruvbox_italic = 1
    catch /E185/ " Missing colorscheme
        colorscheme desert
    endtry
    set background=dark
else
    colorscheme desert
endif
" }}}

" vim:fdl=1:

