" Make script file executable {{{
function! SetExecBit(...)
    if getline(1) =~# '^#!'
        silent exec '!chmod +x %:p'
    endif
endfunction
" }}}

" Open Java class files {{{
function! ReadClassFromJar(...)
    let l:file = escape(getline('.'), '/\')
    if l:file =~? '.*\.class$'
        let l:tmpdir = '/tmp/nvim'. system('tr -cd "[:alnum:]" '.
                    \ '</dev/urandom | fold -w6 | head -1')
        silent exec '!unzip -qq' expand('%:p') shellescape('*') '-d' l:tmpdir
        let l:filepath = substitute(l:tmpdir, '\n\+$', '', '') . '/' . l:file
        silent exec 'split' l:filepath
    else
        echoerr 'Not a class file!'
    endif
endfunction
" }}}

" Open url with qutebrowser {{{
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

" Open plugin url in browser {{{
com! PlugOpen :call s:PlugOpenURL()
function! s:PlugOpenURL()
    let l:name = matchstr(getline('.'), "'\\zs[^']\\+\\ze'")
    let l:plug = get(g:plugs, matchstr(l:name, '/\zs.\+$'))
    let l:path = l:name .'/tree/'. l:plug['branch']
    silent exec '!'. g:vim_g_open_command
                \ .' https://github.com/'. l:path
endfunction
" }}}

" Django + virtual env {{{
if g:os !=# 'android'
    call SourceInitRC('functions/djenv')
endif
" }}}

" FZF with dev icons {{{
if g:os ==# 'linux'
    call SourceInitRC('functions/fzfdev')
endif
" }}}

" vim:fdl=1:

