" In number {{{
function! s:inNumber()
    let l:lnr = line('.')
    let l:pat = '\v((0x|#)\x+|'
                \ .'0b[01]+|0o[0-8]+|'
                \ .'\d+(\.\d+)?'
                \ .'([eE][-+]?\d+)?|'
                \ .'\d+\.|\.\d+)'
    if !search(l:pat, 'ce', l:lnr) | return | endif
    normal! v
    call search(l:pat, 'bc', l:lnr)
endfunction

xnoremap <silent> in :<C-u>call <SID>inNumber()<CR>
onoremap <silent> in :<C-u>call <SID>inNumber()<CR>
" }}}

" In indentation {{{
function! s:inIndentation()
    normal! ^
    let l:col = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')
    let l:pat = printf('\m^\(\s*\%%%dv\|^$\)\@!', l:col)
    exec printf('normal! %dG0', search(l:pat, 'Wbn') + 1)
    call search('^[^\n\r]', 'Wc')
    let l:end = search(l:pat, 'Wn') - 1
    exec printf('normal! Vo%dG', l:end < 0 ? 0 : l:end)
    call search('^[^\n\r]', 'Wbc')
endfunction

xnoremap <silent> ii :<C-u>call <SID>inIndentation()<CR>
onoremap <silent> ii :<C-u>call <SID>inIndentation()<CR>
" }}}
