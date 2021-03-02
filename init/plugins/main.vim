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
Plug 'ObserverOfTime/multiedit.vim'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'kkoomen/vim-doge', {'for': [
            \   'c', 'cpp', 'javascript', 'lua', 'python'
            \ ]}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': 'rmd'}
Plug 'vim-pandoc/vim-rmarkdown', {'for': 'rmd'}
Plug 'tpope/vim-dadbod', {'on': []} " Loaded via local vimrc

if g:os ==# 'windows'
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
endif

if g:os !=# 'android'
    Plug 'w0rp/ale'
    Plug 'andrewferrier/vim-hugefile'
    Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}
endif

if executable('editorconfig')
    Plug 'editorconfig/editorconfig-vim'
endif

if executable('pacman')
    Plug 'Firef0x/PKGBUILD.vim', {'for': 'PKGBUILD'}
endif

if g:unicode
    Plug 'chrisbra/unicode.vim'
endif

if executable('vifm')
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
            \   'html', 'htmldjango',
            \   'pug', 'svelte', 'xml'
            \ ]}
Plug 'hail2u/vim-css3-syntax', {'for': [
            \   'css', 'scss', 'html',
            \   'htmldjango', 'pug', 'svelte'
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
    Plug 'davidhalter/jedi-vim', {'for': ['python', 'rst', 'ipynb']}
endif
" }}}

" C Plugins {{{
Plug 'daidodo/DoxygenToolkit.vim', {'for': ['c', 'cpp']}

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

    if executable('clang')
        Plug 'ncm2/ncm2-pyclang', {'for': ['c', 'cpp']}
    endif

    if executable('R')
        Plug 'jalvesaq/Nvim-R', {'for': ['r', 'rmd', 'rnoweb']}
        Plug 'gaalcaras/ncm-R', {'for': ['r', 'rmd', 'rnoweb']}
    endif

    if executable('latexmk')
        Plug 'lervag/vimtex', {'for': ['tex', 'bib', 'rnoweb']}
    endif

    Plug 'jsit/sasscomplete.vim', {'for': [
                \   'css', 'scss', 'html',
                \   'htmldjango', 'pug', 'svelte'
                \ ]}
    Plug 'ncm2/ncm2-html-subscope', {'for': ['html', 'htmldjango']}
    Plug 'ncm2/ncm2-markdown-subscope', {'for': ['markdown', 'rmd']}
    Plug 'ncm2/ncm2-rst-subscope', {'for': 'rst'}
    Plug 'Shougo/neco-vim', {'for': 'vim'}
    Plug 'ncm2/ncm2-vim', {'for': 'vim'}
endif
" }}}

call plug#end()

call SourceInitRC('plugins/settings')

" vim:fdl=0:
