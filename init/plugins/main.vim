call plug#begin(g:plug_home)

" Misc plugins {{{
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'tmsanrinsha/SyntaxRange'
Plug 'osyo-manga/vim-anzu'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'zsrkmyn/auto-pairs'
Plug 'rcarraretto/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'brooth/far.vim', {'do': ':UpdateRemotePlugins'}
Plug 'shaggyrogers/vim-mundo', {'on': 'MundoToggle'}

if g:os !=# 'android'
    Plug 'w0rp/ale'
    Plug 'haroldjin/vim-g'
    Plug 'systemmonkey42/vim-hugefile'
    Plug 'tagno25/hexmode'
    Plug 'romainl/vim-devdocs'
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'fszymanski/fzf-quickfix', {'on': '<Plug>(fzf-quickfix)'}
elseif executable('termux-open')
    Plug 'haroldjin/vim-g'
endif

if executable('editorconfig')
    Plug 'editorconfig/editorconfig-vim'
endif

if &encoding ==? 'utf-8'
    Plug 'chrisbra/unicode.vim'
endif

if g:os ==# 'linux' && !g:_is_uni
    Plug 'lambdalisue/suda.vim'
endif

if has('nvim') && !g:_is_uni
    Plug 'ObserverOfTime/discord.nvim', {'dir':
                \ g:git_home .'/discord.nvim',
                \ 'do': ':UpdateRemotePlugins',
                \ 'branch': 'refactored'}
endif
" }}}

" Look and feel plugins {{{
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
Plug 'chrisbra/Colorizer'

if g:os ==# 'linux' && !g:_is_uni
    Plug 'ryanoasis/vim-devicons'
endif
" }}}

" Git plugins {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
" }}}

" Web plugins {{{
Plug 'othree/html5.vim', {'for': ['html',
            \ 'htmldjango', 'pug', 'jsp']}
Plug 'mattn/emmet-vim', {'for': ['html',
            \ 'htmldjango', 'pug', 'jsp']}
Plug 'hail2u/vim-css3-syntax', {'for': ['css', 'scss',
            \ 'html', 'htmldjango', 'pug', 'jsp']}
Plug 'iloginow/vim-pug', {'for': 'pug'}

Plug 'redbmk/vim-jsx', {'for': 'javascript'}
Plug 'maxmellon/vim-jsx-pretty', {'for': 'javascript'}
Plug 'heavenshell/vim-jsdoc', {'for': 'javascript'}
Plug 'cdata/vim-tagged-template', {'for': 'javascript'}

Plug 'vim-scripts/svg.vim', {'for': 'svg'}
Plug 'jasonshell/vim-svg-indent', {'for': 'svg'}

if g:os !=# 'android'
    Plug 'kracejic/vCoolor.vim', {'for': [
                \ 'css', 'scss', 'html', 'htmldjango',
                \ 'pug', 'svg', 'jsp', 'javascript']}
else
    Plug 'aaron-goshine/colorv.vim', {'for': [
                \ 'css', 'scss', 'html', 'htmldjango',
                \ 'pug', 'svg', 'jsp', 'javascript']}
endif

if executable('node') && g:os !=# 'android'
    Plug 'FabioAntunes/vim-node'
    Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'html',
                \ 'htmldjango', 'jsp'], 'do': g:npm_cmd}
endif

if exists('g:git_home')
    Plug 'ObserverOfTime/scss.vim', {'for': 'scss',
                \ 'dir': g:git_home .'/scss.vim',
                \ 'branch': 'refactored'}
else
    Plug 'ObserverOfTime/scss.vim', {'for': 'scss',
                \ 'branch': 'refactored'}
endif
" Plug 'nicwest/vim-http', {'for': 'http'}
" }}}

" Python plugins {{{
Plug 'vim-scripts/pydoc.vim', {'for': 'python'}
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

if has('nvim')
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
endif

if g:os !=# 'android'
    Plug 'davidhalter/jedi-vim', {'for': 'python'}
    Plug 'tweekmonster/django-plus.vim'
    " Help: https://vimeo.com/95775461
    Plug 'idanarye/vim-vebugger', {'for': [
                \ 'c', 'cpp', 'java', 'python']}
endif
" }}}

" Java plugins {{{
Plug 'AdnoC/jcommenter.vim', {'for': 'java'}
Plug 'mikelue/vim-maven-plugin', {'for': [
            \ 'java', 'jsp', 'kotlin']}
Plug 'gisphm/vim-gradle', {'for': ['java',
            \ 'kotlin', 'jsp', 'gradle']}
" }}}

" NERDTree plugins {{{
if g:os !=# 'android' && !g:_is_uni
    Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
    Plug 'ladace/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
    Plug 'mortonfox/nerdtree-clip', {'on': 'NERDTreeToggle'}
    Plug 'ObserverOfTime/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle',
                \ 'dir': g:git_home .'/vim-nerdtree-syntax-highlight'}
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
        Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}
        if g:_is_uni
            Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
        else
            Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp'],
                        \ 'dir': g:git_home .'/ncm2-jc2'}
        endif
    endif

    if executable('clang')
        Plug 'ncm2/ncm2-pyclang', {'for': ['c', 'cpp']}
    endif

    if &spellfile || executable('look')
        Plug 'filipekiss/ncm2-look.vim', {'for': ['markdown',
                    \ 'email', 'rst', 'text', 'help']}
    endif

    if !g:_is_uni
        Plug 'ncm2/ncm2-github', {'for': ['markdown', 'rst']}
    endif

    Plug 'jsit/sasscomplete.vim', {'for': ['css', 'scss',
                \ 'html', 'htmldjango', 'jsp', 'pug']}
    Plug 'othree/jspc.vim', {'for': 'javascript'}
    Plug 'ncm2/ncm2-html-subscope', {'for': [
                \ 'html', 'jsp', 'htmldjango']}
    Plug 'ncm2/ncm2-markdown-subscope', {'for': 'markdown'}
    Plug 'ncm2/ncm2-rst-subscope', {'for': 'rst'}
    Plug 'Shougo/neco-vim', {'for': 'vim'}
    Plug 'ncm2/ncm2-vim', {'for': 'vim'}
endif
" }}}

" Other filetype plugins {{{
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'SidOfc/mkdx', {'for': 'markdown'}
Plug 'danielyli/vim-log-syntax', {'for': 'log'}
Plug 'FredDeschenes/httplog', {'for': 'httplog'}
Plug 'marshallward/vim-restructuredtext', {'for': 'rst'}
Plug 'daidodo/DoxygenToolkit.vim', {'for': ['c', 'cpp', 'java']}
Plug 'tpope/vim-dadbod', {'on': []} " Load via local vimrc

if has('nvim')
    Plug 'arakashic/chromatica.nvim', {'do': ':UpdateRemotePlugins'}
endif

if executable('pdftotext')
    Plug 'makerj/vim-pdf', {'for': 'pdf'}
endif

if executable('sqlplus')
    Plug 'wfriesen/vorax4', {'on': []} " Load via local vimrc
endif

if executable('pacman')
    Plug 'Firef0x/PKGBUILD.vim', {'for': 'PKGBUILD'}
endif

if executable('dpkg')
    Plug 'knatsakis/deb.vim'
endif
" }}}

call plug#end()

call SourceInitRC('plugins/settings')

" vim:fdl=0:

