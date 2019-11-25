" Normal & visual modes {{{
" Scroll forward while searching
map <silent> <C-j>       <Plug>(is-scroll-f)
" Scroll backward while searching
map <silent> <C-k>       <Plug>(is-scroll-b)
" Search forward while staying in place (with word boundaries)
map <silent> *           <Plug>(asterisk-z*)<Plug>(is-nohl-1)
" Search forward while staying in place
map <silent> g*          <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
" Search forward while staying in place
map <silent> #           <Plug>(asterisk-z#)<Plug>(is-nohl-1)
" Search backward while staying in place (with word boundaries)
map <silent> g#          <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

" Show tag in new tab
noremap <silent> <C-w>]  :tab split <BAR> :exec 'tag '.expand('<cword>')<CR>
" Go to previous ALE wrap
noremap <silent> <C-l>k  :ALEPreviousWrap<CR>
" Go to next ALE wrap
noremap <silent> <C-l>j  :ALENextWrap<CR>
" Go to previous ALE line
noremap <silent> <C-l>N  :ALEPrevious<CR>
" Go to next ALE line
noremap <silent> <C-l>n  :ALENext<CR>
" Fix file with ALE
noremap <silent> <C-l>f  :ALEFix<CR>
" }}}

" Normal mode {{{
" Toggle relative numbers
nmap <silent> rn         :set relativenumber!<CR>
" Clear search highlighting
nmap <silent> ,/         :nohlsearch <BAR> :echon<CR>
" Go to next search match
nmap <silent> n          <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
" Go to previous search match
nmap <silent> N          <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
" Open fzf quickfix window
nmap <silent> Q          :Quickfix<CR>
" Toggle undo window
nmap <silent> <Leader>u  :MundoToggle<CR>


" Close file
nnoremap <silent> <C-q>  :q<CR>
" Save file
nnoremap <silent> <C-s>  :w<CR>
" Open fzf window
nnoremap <silent> <C-f>  :FZF<CR>
" Fix file indentation
nnoremap <silent> <C-i>  mzgg=G`z
" }}}

" Insert mode {{{
" Save file
inoremap <silent> <C-s>  <ESC>:w<CR>a
" Complete result if available
inoremap <expr> <TAB>    (pumvisible() ? "\<C-y>" : "\<TAB>")
" }}}

" Visual mode {{{
" Copy to clipboard
vnoremap <C-c>           "+y
" Copy to clipboard
vnoremap <C-Insert>      "+y
" }}}

" Terminal mode {{{
" Switch to normal mode
tnoremap <silent> <ESC>  <C-\><C-n>
" }}}
