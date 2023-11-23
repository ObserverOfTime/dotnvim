scriptencoding utf-8

function dabline#tabline()
    let l:tabs = ''
    let l:page = tabpagenr()
    for l:i in range(1, tabpagenr('$'))
        let l:buflist = tabpagebuflist(l:i)
        let l:winnr = tabpagewinnr(l:i)
        let l:label = bufname(l:buflist[l:winnr - 1])
        let l:bg = l:i == l:page ? 'Light' : 'Dark'
        let l:tabs .= '%#DabLine'.l:bg.'#%'.i.'T　'.l:label
    endfor
    return l:tabs.'%#DabLineDark#%T%=%999X '
endfunction

hi DabLineLight guibg=#252525 guifg=#E3E3E3
hi DabLineDark guibg=#252525 guifg=#999999

set tabline=%!dabline#tabline()
