" Filetype augroup {{{
augroup FTGroup
    au!
    " Disable autoinsertion of comment leaders
    au FileType * set formatoptions-=o formatoptions-=r
    " Enable spellcheck in e-mails
    au FileType mail setl spell
    " Wrap lines in manual pages
    au FileType man setl wrap linebreak
    " Enable Doxygen syntax in C,C++ files
    au FileType c,cpp let b:load_doxygen_syntax = 1
    " Keep trailing commas in Python files
    au FileType python let b:splitjoin_trailing_comma = 1
    " Indentation settings {{{
    au FileType make setl tabstop=8 shiftwidth=8
                \ softtabstop=0 noexpandtab nosmartindent
    au FileType html,htmldjango,pug setl tabstop=2 shiftwidth=2
    au FileType markdown,xml,svg setl tabstop=2 shiftwidth=2
    au FileType json,javascript,coffee setl tabstop=2 shiftwidth=2
    au FileType css,scss setl iskeyword+=- tabstop=2 shiftwidth=2
    au FileType rst setl tabstop=3 shiftwidth=3 foldlevel=2
    au FileType sh setl tabstop=2 shiftwidth=2
    au FileType sql setl expandtab
    " }}}
    " Folding settings {{{
    au FileType vim setl foldmethod=marker foldlevel=1
    au FileType snippets setl foldmethod=marker foldlevel=0
    au FileType json setl foldmethod=syntax foldlevel=2
    " }}}
augroup END
" }}}

" Buffer augroup {{{
augroup BufGroup
    au!
    " call SetExecBit() on save
    au BufWritePost * call SetExecBit()
    " Set special filetypes {{{
    au BufNewFile,BufRead *.bash* setf sh
    au BufNewFile,BufRead *.conf setf dosini
    au BufNewFile,BufRead *nginx*.conf setf nginx
    au BufNewFile,BufRead .babelrc setf json5
    au BufNewFile,BufRead .SRCINFO setf dosini
    " }}}
    if executable('cfr') " Decompile Java class files {{{
        au BufRead *.class if !&binary | setl ft=java nomodified |
                    \ silent exec '%!unset _JAVA_OPTIONS; cfr %' | endif
        au BufReadPost *.class if !&binary | setl nomodifiable
                    \ readonly wrap linebreak breakindent nolist | endif
    endif " }}}
augroup END
" }}}

" Misc augroup {{{
augroup MiscGroup
    au!
    " Shebangs everywhere
    au Syntax * syn match PreProc "^\%1l#!/.*$"
    " Paste bug workaround (neovim/neovim#7994)
    au InsertLeave * set nopaste
    " Reset cursor on exit
    au VimLeave * set guicursor=a:hor25
augroup END
" }}}

" vim:fdl=1:

