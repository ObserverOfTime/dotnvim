" Make script file executable {{{
function! SetExecBit(...)
    " Pass argument to force change
    let l:force = len(a:000)
    if l:force || getline(1) =~# '^#!'
        silent exec '!chmod +x %:p'
    endif
endfunction
" }}}

" Open URL with qutebrowser {{{
if executable('qutebrowser')
    com! -nargs=? QBrowse :call <SID>QuteBrowser(<f-args>)
    function! s:QuteBrowser(...)
        if !len(a:000)
            silent exec '!qutebrowser &'
        else
            silent exec '!qutebrowser '. join(a:000, ' ') .' &'
        endif
    endfunction
endif
" }}}

" Open plugin URL in browser {{{
com! PlugOpen :call <SID>PlugOpenURL()
function! s:PlugOpenURL()
    let l:name = matchstr(getline('.'), "'\\zs[^']\\+\\ze'")
    let l:plug = get(g:plugs, matchstr(l:name, '/\zs.\+$'))
    let l:path = l:name .'/tree/'. l:plug['branch']
    silent exec '!'. expand('$BROWSER') .' https://github.com/'. l:path
endfunction
" }}}

" vim:fdl=1:
