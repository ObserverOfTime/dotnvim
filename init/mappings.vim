map <C-j> <Plug>(is-scroll-f)
map <C-k> <Plug>(is-scroll-b)
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
map <silent> ,/ :nohlsearch <BAR> :echon<CR>

nmap n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
nmap N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
nmap f <Plug>(fzf-quickfix)

noremap <silent> <C-w>] :tab split <BAR> :exec 'tag '.expand('<cword>')<CR>
noremap <silent> <C-w>v :VertiTab<CR>
noremap <silent> <C-w>n :HorizTab<CR>
noremap <silent> <C-s>  :w<CR>
noremap <silent> <C-q>  :q<CR>
noremap <silent> <C-a>k :ALEPreviousWrap<CR>
noremap <silent> <C-a>j :ALENextWrap<CR>
noremap <silent> <C-a>N :ALEPrevious<CR>
noremap <silent> <C-a>n :ALENext<CR>
noremap <silent> <C-a>f :ALEFix<CR>
noremap <silent> <C-i>  mzgg=G`z

if g:os ==# 'linux'
    noremap <C-f> :FZFD<CR>
elseif g:os !=# 'android'
    noremap <C-f> :FZF<CR>
endif

nnoremap <Leader>gm  <Plug>(MakeDigraph)
nnoremap <Leader>ga  <Plug>(UnicodeGA)
nnoremap <Leader>r   :AsyncRun<Space>
nnoremap <Leader>u   :MundoToggle<CR>
nnoremap <Leader>n   :NERDTreeToggle<CR>
nnoremap <Leader>F   :FoldLines<CR>
nnoremap <Leader>s   :S<CR>

inoremap <expr> <TAB> (pumvisible() ? "\<C-y>" : "\<TAB>")

vnoremap <C-x> "+d
vnoremap <C-c> "+y
vnoremap <C-Insert> "+y

tnoremap <ESC> <C-\><C-n>

