if !has('win32') || exists('g:GuiLoaded')
    set encoding=utf-8
    set fileencoding=utf-8
endif

" vint: -ProhibitSetNoCompatible
if &compatible | set nocompatible | endif

" Detect platform {{{
if expand('$OS') =~? 'Windows'
    let g:os = 'windows'
    if &shell =~? 'powershell'
        let g:shell = 'pwsh'
    elseif expand('$OSTYPE') ==? 'msys'
        let g:shell = 'msys'
    elseif expand('$OSTYPE') ==? 'cygwin'
        let g:shell = 'cygwin'
    else
        let g:shell = 'cmd'
    endif
elseif expand('$OSTYPE') ==? 'linux-android'
    let g:os = 'android'
    let g:shell = 'termux'
else
    let g:os = 'linux'
    let g:shell = 'unix'
    let $JAVA_HOME = '/usr/lib/jvm/java-8-openjdk/' " Use JDK8
endif
" }}}

" Get path based on platform {{{
function! GetPath(...)
    let l:input = join(a:000, '/')
    if g:os ==# 'windows'
        let l:path = substitute(l:input, '\\', '/', 'g')
        if g:shell ==# 'msys'
            return substitute(shellescape(l:path),
                        \ '\(\w\):', '/\L\1', '')
        elseif g:shell ==# 'cygwin'
            return systemlist('cygpath '.
                        \ shellescape(l:path))[0]
        endif
        return shellescape(l:path)
    else
        return expand(l:input)
    endif
endfunction
" }}}

" Directory variables {{{
if exists('$XDG_DATA_HOME')
    let g:xdg_data_home = GetPath($XDG_DATA_HOME)
elseif g:os ==# 'windows'
    let g:xdg_data_home = GetPath($LOCALAPPDATA)
else
    let g:xdg_data_home = expand('~/.local/share')
endif

if has('nvim')
    let g:plug_home = g:xdg_data_home .'/nvim/plugged'
else
    let g:plug_home = expand('~/.vim/plugged')
endif

if has('nvim')
    let g:plug_path = g:xdg_data_home
                \ .'/nvim/site/autoload/plug.vim'
else
    let g:plug_path = expand('~/.vim/autoload/plug.vim')
endif
" }}}

" Download plug if missing {{{
if empty(glob(g:plug_path))
    let s:plug_url = 'https://raw.githubusercontent.com'
                \ .'/junegunn/vim-plug/master/plug.vim'
    let s:ps_cmd = "New-Item (Split-Path -Path '". g:plug_path
                \ ."') -ItemType Directory -Force > $null; "
                \ ."Invoke-WebRequest -OutFile '". g:plug_path
                \ ."' -Uri '". s:plug_url ."' > $null"
    if g:shell ==# 'pwsh'
        silent exec s:ps_cmd
    elseif executable('curl')
        silent exec '!curl --create-dirs -Sso '.
                    \ g:plug_path .' '. s:plug_url
    elseif g:shell ==# 'cmd'
        silent exec 'powershell -NoProfile -Command "'. s:ps_cmd .'"'
    else
        echoerr 'Download vim-plug from "'. s:plug_url
                    \ '" and place it in "'. g:plug_path .'"'
        finish
    endif
    call mkdir(g:plug_home, 'p')
    finish
endif
" }}}

" Detect node installer {{{
if executable('node')
    if executable('yarn')
        let g:npm_cmd = 'yarn'
    else
        let g:npm_cmd = 'npm i'
    endif
endif
" }}}

" Snippet variables {{{
let g:snips_author = systemlist('git config user.name')[0]
let g:snips_email = systemlist('git config user.email')[0]
let g:snips_github = 'https://github.com/'. g:snips_author
" }}}

" Other variables {{{
let g:_color_fts = [
            \ 'css', 'html', 'htmldjango',
            \ 'javascript', 'pug', 'scss', 'svg'
            \ ]
" }}}

" Source scripts {{{
function! SourceInitRC(initrc)
    let l:vimrc = resolve(expand('$MYVIMRC'))
    let l:path = fnamemodify(l:vimrc, ':p:h')
    exec 'source '. l:path .'/init/'. a:initrc .'.vim'
endfunction

call SourceInitRC('plugins/main')
call SourceInitRC('settings')
call SourceInitRC('colors')
call SourceInitRC('mappings')
call SourceInitRC('commands')
call SourceInitRC('functions/main')
call SourceInitRC('augroups')

if has('nvim') | call SourceInitRC('nvim_host') | endif
" }}}

" WARNING: This can be a security vulnerability.
" When editing files from an untrusted source,
" always check the directories for .lvimrc
" files and verify their contents.
" Source local vimrc {{{
function! s:SourceLocalRC()
    " Abort if running as root/admin
    if g:os !=# 'windows'
        if expand('$EUID') == 0 | return | endif
    else
        silent call system('net session')
        if v:shell_error != 0 | return | endif
    endif
    let l:lvimrc = fnamemodify(findfile(
                \ '.lvimrc', '.;'), ':p')
    if !len(l:lvimrc) | return | endif
    if get(g:, 'loaded_localrc', 0)
        if get(g:, 'local_vimrc') ==# l:lvimrc
            return
        endif
    endif
    if filereadable(l:lvimrc)
        exec 'source '. l:lvimrc
        let g:local_vimrc = l:lvimrc
        let g:loaded_localrc = 1
    endif
endfunction
augroup LocalRC
    au!
    au BufReadPre,BufNewFile * call s:SourceLocalRC()
augroup END
" }}}

" vim:fdl=0:
