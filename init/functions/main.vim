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
    com! -nargs=? QBrowse :call s:QuteBrowser(<f-args>)
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
com! PlugOpen :call s:PlugOpenURL()
function! s:PlugOpenURL()
    let l:name = matchstr(getline('.'), "'\\zs[^']\\+\\ze'")
    let l:plug = get(g:plugs, matchstr(l:name, '/\zs.\+$'))
    let l:path = l:name .'/tree/'. l:plug['branch']
    silent exec '!'. g:vim_g_open_command
                \ .' https://github.com/'. l:path
endfunction
" }}}

" Activate Django & virtual env {{{
if g:os !=# 'android'
    call SourceInitRC('functions/djenv')
endif
" }}}

" Show devicons in fzf window {{{
if g:os ==# 'linux'
    call SourceInitRC('functions/fzfdev')
endif
" }}}

" vim:fdl=1:

