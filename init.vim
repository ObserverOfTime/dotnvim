" Define utilities {{{
lua <<EOF
--- Pretty print
function put(...)
    print(vim.inspect(...))
end

--- Running in a proper terminal
vim.g.in_term = vim.env.TERM ~= 'linux'
EOF
" }}}

" Load modules {{{
lua <<EOF
require('settings')
require('filetypes')
require('mappings')
require('plugins')
EOF
" }}}

" Define custom commands {{{
" Copy file to the clipboard
command! CopyFile :silent w !xclip -i -sel c

" Delete trailing whitespace
command! DelTrail :silent %s/\s\+$//e

" Show syntax groups under cursor
command! SynStack :echo map(
            \ synstack(line('.'), col('.')),
            \ 'synIDattr(v:val, "name")')

" Save a file after creating parent directories
command! -complete=file -nargs=? W
            \ :call mkdir(expand('%:p:h'), 'p') | w
" }}}

" Source local .nvimrc {{{
" WARNING: This can be a security vulnerability.
" When editing files from an untrusted source,
" always check the directories for .nvimrc
" files and verify their contents.
function! s:SourceRC()
    " Abort if running as root
    if $USER ==# 'root' | return | endif
    if get(g:, '_exrc', '') !=# '' | return | endif
    let l:exrc = fnamemodify(findfile(
                \ '.nvimrc', '.;'), ':p')
    if l:exrc ==# '' | return | endif
    if filereadable(l:exrc)
        exec 'source '. l:exrc
        let g:_exrc = l:exrc
    endif
endfunction
" }}}

" Init augroup {{{
augroup VimInit
    au!
    " Source .nvimrc on enter
    au VimEnter * call <SID>SourceRC()
    " Set formatoptions (:h 'formatoptions')
    au BufEnter * set formatoptions=cqn1j
    " Jump to last cursor position
    au BufWinEnter * normal g`"
    " Fix cursor on exit
    au VimLeave * set guicursor=a:hor25
augroup END
" }}}
