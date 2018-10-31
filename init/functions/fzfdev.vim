" https://github.com/ryanoasis/vim-devicons/issues/106#issuecomment-354629715
com! FZFD :call s:FZFDev()
function! s:FZFDev()
    let l:fzf_files_options =
                \ '--preview "rougify --theme '.
                \ 'base16.monokai.dark {2..} '.
                \ '2>/dev/null | head -'.&lines.'"'
    function! s:files()
        let l:files = split(system('rg --hidden -z -l "" '.
                    \ '2>/dev/null | grep -v "^.git/"'), '\n')
        return s:prepend_icon(l:files)
    endfunction

    function! s:prepend_icon(candidates)
        let l:result = []
        for l:candidate in a:candidates
            let l:filename = fnamemodify(l:candidate, ':p:t')
            let l:icon = WebDevIconsGetFileTypeSymbol(
                        \ l:filename, isdirectory(l:filename))
            call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor
        return l:result
    endfunction

    function! s:edit_file(item)
        let l:pos = stridx(a:item, ' ')
        let l:file_path = a:item[pos+1:]
        exec 'silent tabnew' l:file_path
    endfunction

    call fzf#run({
                \ 'source':  <sid>files(),
                \ 'sink':    function('s:edit_file'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'down':    '40%'})
endfunction

