" Filetype augroup {{{
augroup FTGroup
    au!
    " Disable autoinsertion of comment leaders
    au FileType * set formatoptions-=o formatoptions-=r
    " Enable spellcheck in e-mails
    au FileType mail setl spell
    " Wrap lines in manual pages
    au FileType man setl wrap linebreak
    " Use JS filetype for JSX
    au FileType javascript.jsx setl ft=javascript
    " SplitJoin settings {{{
    au FileType python let b:splitjoin_trailing_comma = 1
    au FileType toml
                \ let b:splitjoin_trailing_comma = 1 |
                \ let b:splitjoin_split_callbacks = [
                \   'sj#js#SplitArray', 'sj#js#SplitObjectLiteral'
                \ ] |
                \ let b:splitjoin_join_callbacks = [
                \   'sj#js#JoinArray', 'sj#js#JoinObjectLiteral'
                \ ]
    " }}}
    " Pear Tree settings {{{
    au FileType tex,rnoweb let b:pear_tree_pairs = {
                \ '{': {'closer': '}', 'not_at': [
                \     '\\begin', '\\end', '\\usepackage',
                \     '\\usepackage\[[^\]]*\]']},
                \ '\\(': {'closer': '\\)'},
                \ '\\[': {'closer': '\\]'}
                \ }
    " }}}
    " Indentation settings {{{
    au FileType make setl tabstop=8 shiftwidth=8
                \ softtabstop=0 noexpandtab nosmartindent
    au FileType html,htmldjango,pug setl tabstop=2 shiftwidth=2
    au FileType markdown,xml,svelte,svg setl tabstop=2 shiftwidth=2
    au FileType json,javascript,coffee setl tabstop=2 shiftwidth=2
    au FileType css,scss setl iskeyword+=- tabstop=2 shiftwidth=2
    au FileType rst setl tabstop=3 shiftwidth=3 foldlevel=2
    au FileType sh setl tabstop=2 shiftwidth=2
    au FileType sql setl expandtab
    " }}}
    " Fold & conceal settings {{{
    au FileType javascript setl conceallevel=1
    au FileType tex,rnoweb setl conceallevel=2 foldlevel=3
    au FileType markdown,rmd setl conceallevel=2 foldlevel=7
    au FileType vim setl foldmethod=marker foldlevel=1
    au FileType snippets setl foldmethod=marker foldlevel=0
    au FileType json setl foldmethod=syntax foldlevel=2
    au FileType python setl foldmethod=syntax foldlevel=0
    " }}}
augroup END
" }}}

" Buffer augroup {{{
augroup BufGroup
    au!
    " Set special filetypes {{{
    au BufNewFile,BufRead .babelrc setf json5
    au BufNewFile,BufRead .SRCINFO setf dosini
    " }}}
    if executable('pdftotext') " Open PDF files as text {{{
        au BufRead *.pdf silent exec '%!pdftotext -nopgbrk '
                    \ '-layout '. shellescape(expand(@%)) .' -'
        au BufReadPost *.pdf setl readonly nowrite | setf text
        au BufLeave *.pdf setl noreadonly write
    endif " }}}
    if executable('Rscript') " Open Excel files as CSV {{
        let g:zipPlugin_ext = '*.zip,*.jar,*.war,*.cbz,*.epub'
        au BufRead *.xlsx silent exec '%!Rscript --vanilla -e '
                    \ '"write.table(readxl::read_excel(\"'. expand(@%)
                    \ .'\"), row.names = FALSE, sep = \",\")"'
        au BufReadPost *.xlsx setl readonly nowrite | setf csv
        au BufLeave *.xlsx setl noreadonly write
    endif " }}}
    if executable('cfr') " Decompile Java class files {{{
        au BufRead *.class if !&binary | silent exec
                    \ '%!cfr %' | setl syn=java | endif
        au BufReadPost *.class if !&binary | setl nowrite readonly | endif
        au BufLeave *.class if !&binary | setl write noreadonly | endif
    endif " }}}
augroup END
" }}}

" Misc augroup {{{
augroup MiscGroup
    au!
    " Shebangs everywhere
    au Syntax * syn match PreProc "^\%1l#!/.*$"
    " Reset cursor on exit
    au VimLeave * set guicursor=a:hor25
augroup END
" }}}

" vim:fdl=1:
