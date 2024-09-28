" Alternate init for large files

" Set mappings {{{
nmap <UP> gk
nmap <DOWN> gj

nmap <C-LeftMouse> <NOP>

nmap <Leader>/ <Cmd>nohlsearch<CR>

nnoremap <C-q> <Cmd>quit<CR>

nnoremap <C-s> <Cmd>write ++p<CR>
inoremap <C-s> <Cmd>write ++p<CR>

nnoremap <C-z> <Cmd>undo<CR>
inoremap <C-z> <Cmd>undo<CR>

nnoremap <Leader><Tab> mIgg=G`I

vnoremap <C-c> "+y
vnoremap <C-Insert> "+y

xnoremap a' 2i'
xnoremap a" 2i"
xnoremap a` 2i`

omap <silent> a/ :<C-U>normal F/vf/<CR>
xmap <silent> a/ :<C-U>normal F/vf/<CR>
omap <silent> i/ :<C-U>normal T/vt/<CR>
xmap <silent> i/ :<C-U>normal T/vt/<CR>

omap <silent> a+ :<C-U>normal F+vf+<CR>
xmap <silent> a+ :<C-U>normal F+vf+<CR>
omap <silent> i+ :<C-U>normal T+vt+<CR>
xmap <silent> i+ :<C-U>normal T+vt+<CR>

omap <silent> a@ :<C-U>normal F@vf@<CR>
xmap <silent> a@ :<C-U>normal F@vf@<CR>
omap <silent> i@ :<C-U>normal T@vt@<CR>
xmap <silent> i@ :<C-U>normal T@vt@<CR>

omap <silent> a\| :<C-U>normal F\|vf\|<CR>
xmap <silent> a\| :<C-U>normal F\|vf\|<CR>
omap <silent> i\| :<C-U>normal T\|vt\|<CR>
xmap <silent> i\| :<C-U>normal T\|vt\|<CR>

nnoremap X D
nnoremap dd "_dd
nnoremap d "_d | xnoremap d "_d
nnoremap D "_D | xnoremap D "_D
nnoremap <Del> "_x | xnoremap <Del> "_x

tnoremap <Esc> <C-\><C-n>
" }}}

" Enable some settings {{{
set background=dark

set mouse=ar
set formatoptions=cqn1j
set shortmess=aoOtTcF

set laststatus=3

set display=truncate,uhex
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
