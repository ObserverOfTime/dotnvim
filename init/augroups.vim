" Filetype augroup {{{
augroup FTGroup
    au!
    au FileType * setl formatoptions-=ro
    au FileType xxd setl noautoindent nocopyindent nosmartindent indentexpr=
    au FileType make setl tabstop=8 shiftwidth=8 softtabstop=0
                \ noexpandtab nosmartindent
    au FileType javascript.jsx setl conceallevel=1 ft=javascript
                \ syn=javascript.jsx | call taggedtemplate#applySyntaxMap()
    au FileType html,htmldjango,pug,markdown,xml,svg setl tabstop=2 shiftwidth=2
    au FileType html,htmldjango,pug,jsp call UltiSnips#AddFiletypes('css')
                \ | call UltiSnips#AddFiletypes('javascript')
    au FileType json,javascript,coffee setl tabstop=2 shiftwidth=2
    au FileType css,scss setl iskeyword+=- tabstop=2 shiftwidth=2
    au FileType rst setl tabstop=3 shiftwidth=3 foldlevel=2
    au FileType json setl foldmethod=syntax foldlevel=2
    au FileType sh setl tabstop=2 shiftwidth=2
    au FileType sql setl expandtab
    au FileType mail,text setl spell
    au FileType c,cpp let b:load_doxygen_syntax = 1
    au FileType vim setl foldmethod=marker foldlevel=1
    au FileType snippets setl foldmethod=marker foldlevel=0
    au FileType python let b:splitjoin_trailing_comma = 1
    au FileType java setl omnifunc=javacomplete#Complete |
                \ nmap <buffer> <Leader>jd :call JCommentWriter()<CR>
augroup END
" }}}

" Buffer augroup {{{
augroup BufGroup
    au!
    au BufWritePost * call SetExecBit()
    au BufNewFile,BufRead,BufAdd * hi Comment cterm=italic
    au BufNewFile,BufRead,BufAdd *.bash* setl ft=sh
    au BufNewFile,BufRead,BufAdd *.conf setl ft=conf syn=dosini
    au BufNewFile,BufRead,BufAdd requirements.* setl ft=requirements
    au BufNewFile,BufRead,BufAdd *nginx*.conf setl ft=nginx
    au BufNewFile,BufRead,BufAdd .babelrc setl ft=json5
    au BufNewFile,BufRead,BufAdd .SRCINFO setl ft=SRCINFO syn=dosini
    if executable('cfr')
        au BufRead,BufAdd *.class setl ft=java nomodified |
                    \ silent %!unset _JAVA_OPTIONS; cfr %
        au BufReadPost,StdinReadPost *.class setl nomodifiable
                    \ readonly wrap linebreak breakindent nolist
    endif
augroup END
" }}}

" Misc augroup {{{
augroup MiscGroup
    au!
    au Syntax * syn match PreProc "^\%1l#!/.*$" " Shebangs everywhere
    au InsertLeave * set nopaste " Paste workaround (neovim#7994)
    au VimLeave * set guicursor= " Reset cursor on exit
augroup END
" }}}

" vim:fdl=1:

