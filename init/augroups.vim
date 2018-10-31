" Filetype augroup {{{
augroup FTGroup
    au!
    au FileType * setl formatoptions-=ro
    au FileType mail,text setl spell
    au FileType xxd setl noautoindent nocopyindent nosmartindent indentexpr=
    au FileType make setl tabstop=8 shiftwidth=8 softtabstop=0
                \ noexpandtab nosmartindent
    au FileType javascript.jsx setl conceallevel=1 ft=javascript
                \ syn=javascript.jsx | call taggedtemplate#applySyntaxMap()
    au FileType html,htmldjango,pug,markdown,xml,svg setl tabstop=2 shiftwidth=2
    au FileType html,htmldjango,php,pug call UltiSnips#AddFiletypes('css')
                \ | call UltiSnips#AddFiletypes('javascript')
    au FileType php,json,javascript,coffee setl tabstop=2 shiftwidth=2
    au FileType css,scss setl iskeyword+=- tabstop=2 shiftwidth=2
    au FileType rst setl tabstop=3 shiftwidth=3 foldlevel=2
    au FileType json setl foldmethod=syntax foldlevel=2
    au FileType sh setl tabstop=2 shiftwidth=2
    au FileType vim setl foldmethod=marker foldlevel=1
    au FileType snippets setl foldmethod=marker foldlevel=0
    au FileType java setl omnifunc=javacomplete#Complete |
                \ nmap <buffer> <Leader>jd :call JCommentWriter()<CR>
    if executable('cfr')
        au FileType tar if expand('%:e') =~? '[jw]ar' |
                    \ noremap <buffer> <silent> <Leader>E
                    \ :call ReadJarClass()<CR><C-W>_ | endif
    endif
augroup END
" }}}

" Buffer augroup {{{
augroup BufGroup
    au!
    au BufWritePost * call SetExecBit(1)
    au BufNewFile,BufRead,BufAdd * hi Comment cterm=italic
    au BufNewFile,BufRead,BufAdd *.bash* setl ft=sh
    au BufNewFile,BufRead,BufAdd *.conf setl ft=conf syn=dosini
    au BufNewFile,BufRead,BufAdd requirements.* setl ft=requirements
    au BufNewFile,BufRead,BufAdd *nginx*.conf setl ft=nginx
    au BufNewFile,BufRead,BufAdd .babelrc setl ft=json5
    au BufNewFile,BufRead,BufAdd .SRCINFO setl ft=SRCINFO syn=dosini
    if executable('sqlplus')
        au BufReadPost,BufNewFile *.sql noremap <Leader>vx :VORAXExec
                    \ | SQLSetType sqlvorax.vim
    endif
    if executable('cfr')
        au BufRead,BufAdd *.class setl ft=java nomodified |
                    \ silent %!unset _JAVA_OPTIONS; cfr %
        au BufReadPost,StdinReadPost *.class setl nomodifiable
                    \ readonly wrap linebreak breakindent nolist
    endif
augroup END
" }}}

" Syntax augroup {{{
augroup SyntaxGroup
    au!
    au Syntax c,cpp let b:load_doxygen_syntax = 1
    au Syntax mail  call SyntaxRange#Include('<html>', '</html>', 'html')
    au Syntax vim   call SyntaxRange#Include('^\s*py << EOF', 'EOF', 'python')
    au Syntax vim   call SyntaxRange#Include('^\s*py3 << EOF', 'EOF', 'python')
    au Syntax vim   call SyntaxRange#Include('^\s*ruby << EOF', 'EOF', 'ruby')
    au Syntax pug   call SyntaxRange#Include('^\s*-', '$', 'javascript')
    au Syntax pug   call SyntaxRange#Include('^\z(\s*\)-\s*$',
                \   '^\%(\z1\s\|\s*$\)\@!', 'javascript')
    au Syntax pug   call SyntaxRange#Include('\z(`[^`]*\)',
                \   '\(%\z1`\)\@!', 'javascript')
    au Syntax iss   call SyntaxRange#Include('\[Code\]', '^\[\w*\]$',
                \   'pascal', 'issDirective')
    au Syntax rst   call SyntaxRange#Include('^\s*<', '>$', 'html')
    " au Syntax http  call SyntaxRange#Include('^\s*<', '>$', 'html')
    " au Syntax http  call SyntaxRange#Include('^\s*{', '}$', 'json')
augroup END
"}}}

" vim:fdl=1:

