" TODO: Enable truecolor support?
" if $COLORTERM ==# 'truecolor' | set termguicolors | endif

" Gruvbox8 colorscheme {{{
try
    let g:gruvbox_italic = 1
    let g:gruvbox_filetype_hi_groups = 1
    colorscheme gruvbox8
catch /E185|Gruvbox/
    colorscheme desert " Fallback
    finish
endtry
" }}}

" Custom colors {{{
" ALE {{{
hi ALEError ctermfg=NONE ctermbg=NONE cterm=underline
hi ALEError guifg=NONE guibg=NONE gui=NONE
hi ALEErrorLine guisp=#FB4934 gui=undercurl
hi ALEErrorSign ctermfg=203 guifg=#FB4934
hi ALEWarning ctermfg=NONE ctermbg=NONE cterm=underline
hi ALEWarning guifg=NONE guibg=NONE gui=NONE
hi ALEWarningLine guisp=#FF8700 gui=undercurl
hi ALEWarningSign ctermfg=208 guifg=#FF8700
hi ALEInfo ctermfg=NONE ctermbg=NONE cterm=underline
hi ALEInfo guifg=NONE guibg=NONE guisp=#83A598 gui=undercurl
hi ALEInfoSign ctermfg=109 guifg=#83A598
" }}}

" GitGutter {{{
hi GitGutterAdd ctermfg=47 guifg=#00FF5F
hi GitGutterDelete ctermfg=205 guifg=#FF5FAF
hi GitGutterChange ctermfg=178 guifg=#D7AF00
hi GitGutterChangeDelete ctermfg=131 guifg=#AF5F5F
" }}}

" NERDTree {{{
hi NERDTreeDir ctermfg=107 guifg=#8EC07C
hi NERDTreeOpenable ctermfg=208 guifg=#FE8019
hi NERDTreeClosable ctermfg=208 guifg=#FE8019
hi NERDTreeFile ctermfg=187 guifg=#EBDBB2
hi NERDTreeExecFile ctermfg=214 guifg=#FABD2F
hi NERDTreeUp ctermfg=102 guifg=#928374
hi NERDTreeCWD ctermfg=142 guifg=#B8BB26
hi NERDTreeHelp ctermfg=187 guifg=#EBDBB2
hi link NERDTreeDirSlash NERDTreeDir
" }}}

" Misc {{{
hi Comment cterm=italic
hi Folded ctermbg=234 guibg=#1C1C1C
hi Visual ctermbg=237 guibg=#3A3A3A
hi MatchParen ctermbg=236 guibg=#303030
hi Function cterm=NONE gui=NONE
hi Todo ctermfg=179 guifg=#D7AF5F gui=bold
hi! link vimCommentTitle Todo
" }}}
" }}}

" vim:fdl=2:
