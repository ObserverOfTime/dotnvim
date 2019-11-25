call plug#begin(g:plug_home)

" Misc plugins {{{
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'osyo-manga/vim-anzu'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'tmsvg/pear-tree'
Plug 'rcarraretto/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'kkoomen/vim-doge', {'for': [
            \   'c', 'cpp', 'java', 'javascript', 'kotlin', 'python'
            \ ]}
Plug 'ObserverOfTime/multiedit.vim'

if g:os !=# 'android'
    Plug 'w0rp/ale'
    Plug 'systemmonkey42/vim-hugefile'
    if empty(glob('/usr/share/vim/vimfiles/plugin/fzf.vim'))
        Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    endif
    Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}
endif

if executable('editorconfig')
    Plug 'editorconfig/editorconfig-vim'
endif

if &encoding ==? 'utf-8'
    Plug 'chrisbra/unicode.vim'
endif

if g:os ==# 'linux'
    Plug 'lambdalisue/suda.vim'
    Plug 'vifm/vifm.vim'
endif

if has('nvim')
    Plug 'ObserverOfTime/discord.nvim', {
                \ 'do': ':UpdateRemotePlugins',
                \ 'branch': 'refactored'
                \ }
endif
" }}}

" Look and feel plugins {{{
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'enricobacis/vim-airline-clock'
Plug 'chrisbra/Colorizer'
" }}}

" Git plugins {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
" }}}

" Web plugins {{{
Plug 'mattn/emmet-vim', {'for': [
            \   'html', 'htmldjango', 'pug', 'svelte'
            \ ]}
Plug 'hail2u/vim-css3-syntax', {'for': [
            \   'css', 'scss', 'html',
            \   'htmldjango', 'pug', 'svelte',
            \ ]}

if executable('node') && g:os !=# 'android'
    Plug 'ternjs/tern_for_vim', {
                \ 'for': ['javascript', 'pug', 'svelte'],
                \ 'do': g:_npm_cmd .' install'
                \ }
endif
" }}}

" Python plugins {{{
if has('nvim')
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
endif

if g:os !=# 'android'
    Plug 'davidhalter/jedi-vim', {'for': ['python', 'rst']}
    Plug 'tweekmonster/django-plus.vim', {
                \ 'for': ['python', 'htmldjango']
                \ }
endif
" }}}

" C Plugins {{{
Plug 'daidodo/DoxygenToolkit.vim', {'for': ['c', 'cpp', 'java']}

if has('nvim')
    Plug 'arakashic/chromatica.nvim', {'do': ':UpdateRemotePlugins'}
endif
" }}}

" Autocompletion plugins {{{
if g:os !=# 'android' && v:version >= 800

    if !has('nvim')
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

    if has('patch-8.0.1493')
        Plug 'ncm2/ncm2-ultisnips'
    endif

    if executable('java')
        Plug 'artur-shaik/vim-javacomplete2', {'for': 'java'}
        Plug 'ObserverOfTime/ncm2-jc2', {'for': 'java'}
    endif

    if executable('clang')
        Plug 'ncm2/ncm2-pyclang', {'for': ['c', 'cpp', 'arduino']}
    endif

    if executable('R')
        Plug 'gaalcaras/ncm-R', {'for': 'r'}
    endif

    Plug 'jsit/sasscomplete.vim', {'for': [
                \   'css', 'scss', 'html',
                \   'htmldjango', 'pug', 'svelte'
                \ ]}
    Plug 'ncm2/ncm2-html-subscope', {'for': ['html', 'htmldjango']}
    Plug 'ncm2/ncm2-markdown-subscope', {'for': 'markdown'}
    Plug 'ncm2/ncm2-rst-subscope', {'for': 'rst'}
    Plug 'Shougo/neco-vim', {'for': 'vim'}
    Plug 'ncm2/ncm2-vim', {'for': 'vim'}
    Plug 'Shougo/neco-syntax', {'on': []}
    Plug 'ncm2/ncm2-syntax', {'on': []}
endif
" }}}

" Other filetype plugins {{{
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'tpope/vim-dadbod', {'on': []} " Loaded via local vimrc

if executable('R')
    Plug 'jalvesaq/Nvim-R', {'for': 'r'}
endif
" }}}

call plug#end()

call SourceInitRC('plugins/settings')

" vim:fdl=0:
