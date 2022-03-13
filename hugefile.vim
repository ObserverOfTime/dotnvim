" Alternate init for large files

" Load mappings {{{
lua require('mappings')
" }}}

" Enable some settings {{{
set background=dark

set mouse=ar
set formatoptions=cqn1j
set shortmess=aoOtTcF

set display=truncate,msgsep,uhex
set guicursor=v-sm:block,i-ci-ve:ver25,r-o-n-c-cr:hor25
set listchars=tab:>>,trail:~,nbsp:_,precedes:@,extends:#
" }}}

" Set colorscheme
colorscheme desert

" Disable impactful settings {{{
syntax clear

set noundofile
set noswapfile
set noincsearch
set noloadplugins

set eventignore=FileType
" }}}

" Init augroup {{{
augroup VimInit
    au!
    au VimLeave * set guicursor=a:hor25
augroup END
" }}}
