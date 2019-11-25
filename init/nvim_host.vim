if g:os ==# 'windows' && g:shell !=# 'cygwin'
    let s:prog_files = GetPath($PROGRAMFILES)
    let g:python_host_prog = s:prog_files
                \ .'/Python27/python2.exe'
    let g:python3_host_prog = s:prog_files
                \ .'/Python37/python3.exe'
else
    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
endif

finish " Skip node & ruby host detection

function! s:MergePath(cmd, path) abort
    return GetPath(systemlist(a:cmd)[0], a:path)
endfunction

if get(g:, '_npm_cmd') ==# 'yarn'
    let g:node_host_prog = s:MergePath(
                \ 'yarn global bin',
                \ 'neovim-node-host')
elseif get(g:, '_npm_cmd') ==# 'npm'
    let g:node_host_prog = s:MergePath(
                \ 'npm -g bin',
                \ 'neovim-node-host')
endif

if executable('gem')
    let g:ruby_host_prog = s:MergePath(
                \ 'gem contents neovim --show-install-dir',
                \ 'exe/neovim-ruby-host')
endif
