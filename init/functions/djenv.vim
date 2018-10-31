com! -nargs=* DjangoActivate :call s:DjEnv(<f-args>)
function! s:DjEnv(...)
    let l:cwd = getcwd()
    let l:env = l:cwd .'/'. (len(a:000) ? join(a:000) : '.venv')
    if empty(glob(l:env))
        echohl Error
            echomsg 'No virtual environment found in "'. l:env .'".'
        echohl None
        return 1
    endif
    let l:python = l:env .'/bin/python'
    let l:packages = system(l:python .' -c "'.
                \ 'from __future__ import print_function; '.
                \ 'from distutils.sysconfig import get_python_lib; '.
                \ 'print(get_python_lib(), end=\"\")"')
    let $VIRTUAL_ENV = l:env
    let $PATH = l:env .'/bin:'. $PATH
    let $DJANGO_SETTINGS_MODULE = fnamemodify(l:cwd, ':t'). '.settings'
    let l:setupenv = 'from sys import path; '.
                \ 'from os import environ; '.
                \ 'from vim import eval as veval; '.
                \ 'path.insert(0, "'. l:cwd .'"); '.
                \ 'path.append("'. l:packages .'"); '.
                \ 'environ["VIRTUAL_ENV"] = veval("$VIRTUAL_ENV"); '.
                \ 'environ["DJANGO_SETTINGS_MODULE"] = '.
                \ 'veval("$DJANGO_SETTINGS_MODULE"); '.
                \ 'from django import setup; setup()'
    if system(l:python . ' -V') =~# '^Python 3'
        exec 'py3 '. l:setupenv
    else
        exec 'py '. l:setupenv
    endif
    call airline#add_statusline_func('airline#extensions#virtualenv#apply')
    call airline#update_statusline()
endfunction

