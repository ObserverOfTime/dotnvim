scriptencoding utf-8

" Local variables {{{
let s:emmet_defaults = {
            \ 'default_attributes': {
            \   'a': {'href': '${cursor}', 'target': '_blank'},
            \   'img': {'src': '${cursor}', 'alt': ''},
            \   'object': {'data': '${cursor}', 'type': ''},
            \   'script': {'src': '${cursor}', 'type': 'text/javascript'},
            \   'style': {'src': '${cursor}', 'type': 'text/css'},
            \   'link': {'href': '${cursor}', 'rel': 'stylesheet',
            \            'type': 'text/css'},
            \   'form': {'action': '${cursor}', 'method': 'GET'},
            \   'label': {'for': '${cursor}'},
            \   'input': {'name': '${cursor}', 'type': 'text'},
            \   'button': {'type': 'submit'},
            \   'header': {'id': 'header'},
            \   'footer': {'id': 'footer'}
            \ },
            \ 'aliases': {
            \   'obj': 'object',
            \   'in': 'input',
            \   'art': 'article',
            \   'sec': 'section',
            \   'btn': 'button',
            \   'he': 'header',
            \   'fo': 'footer',
            \ },
            \ 'indentation': '  ',
            \ 'quote_char': '"'
            \ }

if has('win32') || g:shell ==# 'msys'
    let s:clang_library_path =
                \ GetPath($PROGRAMFILES, 'LLVM/lib/libclang.lib')
elseif g:shell ==# 'cygwin'
    let s:clang_library_path = '/usr/lib/libclang.dll.a'
else
    let s:clang_library_path = '/usr/lib/libclang.so'
endif
" }}}

" Airline settings {{{
" Config {{{
call SourceInitRC('plugins/airline_theme_grayscale')
let g:airline_theme = 'grayscale'
let g:airline_skip_empty_sections = 1
let g:airline_exclude_preview = 1
let g:airline_mode_map = {} " :h mode()
let g:airline_mode_map['!']  = '!'
let g:airline_mode_map['__'] = '-'
let g:airline_mode_map['c']  = 'C'
let g:airline_mode_map['i']  = 'I'
let g:airline_mode_map['ic'] = 'IC'
let g:airline_mode_map['ix'] = 'IC'
let g:airline_mode_map['n']  = 'N'
let g:airline_mode_map['ni'] = '(I)'
let g:airline_mode_map['no'] = 'OP'
let g:airline_mode_map['r']  = 'CR'
let g:airline_mode_map['rm'] = 'M'
let g:airline_mode_map['r?'] = '?'
let g:airline_mode_map['R']  = 'R'
let g:airline_mode_map['Rv'] = 'VR'
let g:airline_mode_map['Rx'] = 'RX'
let g:airline_mode_map['s']  = 'S'
let g:airline_mode_map['S']  = 'SL'
let g:airline_mode_map[''] = 'SB'
let g:airline_mode_map['t']  = 'T'
let g:airline_mode_map['v']  = 'V'
let g:airline_mode_map['V']  = 'VL'
let g:airline_mode_map[''] = 'VB'
let g:airline_section_c = '%<%<%{&bt=="terminal"?b:term_title:'.
            \ 'airline#extensions#fugitiveline#bufname()}'.
            \ '%m %#__accent_red#%{airline#util#wrap('.
            \ 'airline#parts#readonly(),0)}%#__restore__#'
if &encoding ==? 'utf-8'
    let g:airline_section_z = '%{&et?"":"↹ "}%3l% /%L%  : %02v'
else
    let g:airline_section_z = '%{&et?"":"t "}%3l% /%L%  : %02v'
endif
" }}}

" Extensions {{{
let g:airline#extensions#anzu#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#sha1_len = 7
let g:airline#extensions#csv#column_display = 'Name'
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#quickfix#quickfix_text = 'Q'
let g:airline#extensions#quickfix#location_text = 'L'
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':~:.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#whitespace#trailing_format = 't[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mi[%s]'
let g:airline#extensions#whitespace#long_format = 'l[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mif[%s]'
let g:airline#extensions#wordcount#formatter#default#fmt = '%sW'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
" }}}

" Symbols {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = 'λ'
let g:airline_symbols.spell = 'ς'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.readonly = 'ο'
let g:airline_symbols.whitespace = '!'
if &encoding ==? 'utf-8'
    if g:os !=# 'windows' && !g:_is_uni
        let g:airline_powerline_fonts = 1
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
    endif
    let g:airline_symbols.spell = '₷'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.readonly = '⊘'
    let g:airline_symbols.whitespace = '✹'
endif
" }}}
" }}}

if g:os !=# 'android' && v:version >= 800
    " NCM2 settings {{{
    " let g:ncm2_pyclang#library_path = s:clang_library_path
    let g:ncm2_look_use_spell = !empty(&spellfile)
    let g:ncm2_look_mark = 'dict'
    augroup NCM2
        au!
        " Misc {{{
        if !has('nvim')
            au VimEnter * exec get(g:, 'neovim_rpc#py',
                        \ 'python3') .' import neovim'
        endif
        au InsertEnter * call ncm2#enable_for_buffer()
        au InsertLeave * if !pumvisible() | pclose | endif
        au FileType markdown,rst,text,email,help
                    \ let b:ncm2_look_enabled = 1
        if executable('node')
            au FileType html,htmldjango call tern#Enable()
        endif
        if executable('clang')
            au FileType c,cpp nnoremap <buffer> <silent> gd
                        \ <C-u>call ncm2_pyclang#goto_declaration()
        endif
        " }}}

        " Clang {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'clang',
                    \ 'priority': 9,
                    \ 'subscope_enable': 1,
                    \ 'scope': ['c', 'cpp'],
                    \ 'mark': 'c',
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': ['->', '\.', '::', '^\s*#'],
                    \ 'on_complete': ['ncm2#on_complete#omni',
                    \                 'ClangComplete'],
                    \ })
        " }}}

        " Sass {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'sass',
                    \ 'priority': 9,
                    \ 'subscope_enable': 1,
                    \ 'scope': ['css', 'scss'],
                    \ 'mark': 'css',
                    \ 'word_pattern': '[\w_-]+',
                    \ 'complete_pattern': [':\s*', '@[\w-]*\s*',
                    \                      '@media[\w\s]+\(',
                    \                      '@supports \(',
                    \                      "@charset ['\"]"],
                    \ 'on_complete': ['ncm2#on_complete#omni',
                    \                 'sasscomplete#CompleteSass'],
                    \ })
        " }}}

        " Jedi {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'jedi',
                    \ 'priority': 9,
                    \ 'mark': 'py',
                    \ 'subscope_enable': 1,
                    \ 'scope': ['python'],
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': ['^\s*(import|from).*\s',
                    \                      '\.', '\(', ',\s+'],
                    \ 'on_complete': ['ncm2#on_complete#omni',
                    \                 'jedi#completions']})
        " }}}

        " Tern {{{
        if executable('node')
            au User Ncm2Plugin call ncm2#register_source({
                        \ 'name': 'tern',
                        \ 'priority': 9,
                        \ 'mark': 'js',
                        \ 'subscope_enable': 1,
                        \ 'scope': ['javascript', 'javascript.jsx'],
                        \ 'word_pattern': '[\w/]+',
                        \ 'complete_pattern': ['\.', "require\\(['\"][^)'\"]*",
                        \                      "import.*from\\s+['\"][^'\"]*"],
                        \ 'on_complete': ['ncm2#on_complete#omni',
                        \                 'tern#Complete']})
        endif
        " }}}

        " Emmet {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'emmet',
                    \ 'priority': 8,
                    \ 'subscope_enable': 1,
                    \ 'scope': ['html', 'htmldjango', 'pug', 'php'],
                    \ 'mark': 'emmet',
                    \ 'word_pattern': '[\w_\-]+',
                    \ 'complete_pattern': '[\w:]+',
                    \ 'on_complete': ['ncm2#on_complete#omni',
                    \                 'emmet#completeTag'],
                    \ })
        " }}}

        " Pug {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'pug',
                    \ 'priority': 9,
                    \ 'subscope_enable': 0,
                    \ 'scope': ['pug'],
                    \ 'mark': 'pug',
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': '[\w\s]+',
                    \ 'on_complete': ['ncm2#on_complete#omni',
                    \                 'pugcomplete#CompletePug'],
                    \ })
        " }}}

        " JSPC {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'jspc',
                    \ 'priority': 8,
                    \ 'subscope_enable': 0,
                    \ 'scope': ['javascript'],
                    \ 'mark': 'jspc',
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': "\\('?",
                    \ 'on_complete': ['ncm2#on_complete#omni',
                    \                 'jspc#complete']
                    \ })
        " }}}

        " Django {{{
        if g:os !=# 'android'
            au User Ncm2Plugin call ncm2#register_source({
                        \ 'name': 'htmldjango',
                        \ 'priority': 9,
                        \ 'subscope_enable': 0,
                        \ 'scope': ['htmldjango'],
                        \ 'mark': '',
                        \ 'word_pattern': '[\w/_]+',
                        \ 'complete_pattern': [
                        \     '\|', '\{%\s+\w*\s*%?\}?',
                        \     "\\{%\\s+include\\s+[\"']",
                        \     "\\{%\\s+extends\\s+[\"']"
                        \ ],
                        \ 'on_complete': ['ncm2#on_complete#omni',
                        \                 'djangoplus#complete']
                        \ })
            au User Ncm2Plugin call ncm2#register_source({
                        \ 'name': 'pydjango',
                        \ 'priority': 8,
                        \ 'subscope_enable': 0,
                        \ 'scope': ['python'],
                        \ 'mark': '',
                        \ 'word_pattern': '[\w/_]+',
                        \ 'complete_pattern': [
                        \     '\.objects\.', 'settings\.',
                        \     "render\\([^,]+,\\s*[\"']",
                        \     "get_template\\(\\s*[\"']",
                        \     "render_to_string\\(\\s*[\"']",
                        \     "render_to_response\\(\\s*[\"']",
                        \     "template_name\\s*=\\s*[\"']"
                        \ ],
                        \ 'on_complete': ['ncm2#on_complete#omni',
                        \                 'djangoplus#complete']
                        \ })
        endif
        " }}}
    augroup END
    " }}}
endif

if g:os !=# 'android'
    " Ale settings {{{
    " Config {{{
    let g:ale_use_global_executables = 1
    let g:ale_lint_on_enter = 0
    let g:lint_on_insert_leave = 1
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_list_window_size = 5
    " }}}

    " Symbols {{{
    if &encoding ==? 'utf-8'
        let g:ale_sign_info = '❢'
        let g:ale_sign_error = '✘'
        let g:ale_sign_warning = '✶'
        let g:ale_sign_style_error = '✗'
        let g:ale_sign_style_warning = '⚹'
    else
        let g:ale_sign_info = '!!'
        let g:ale_sign_warning = '>>'
    endif
    " }}}

    " Linters {{{
    let g:ale_linters = {}
    let g:ale_linters.c = executable('clang') ?
                \ ['clang', 'clangtidy'] : ['gcc']
    let g:ale_linters.cpp = g:ale_linters.c
    let g:ale_linters.cmake = ['cmakelint']
    let g:ale_linters.css = ['stylelint']
    let g:ale_linters.html = ['htmlhint', 'vale']
    let g:ale_linters.java = ['google_java_format']
    let g:ale_linters.javascript = ['eslint']
    let g:ale_linters.json = ['jq', 'jsonlint']
    let g:ale_linters.kotlin = ['kotlinc']
    let g:ale_linters.make = ['checkmake']
    let g:ale_linters.markdown = ['vale']
    let g:ale_linters.pug = ['puglint']
    let g:ale_linters.python = ['flake8', 'pylint']
    let g:ale_linters.rst = ['rstcheck', 'vale']
    let g:ale_linters.scss = ['stylelint']
    let g:ale_linters.sh = ['shellcheck']
    let g:ale_linters.sql = ['sqlint']
    let g:ale_linters.vim = ['vint']
    " }}}

    " Fixers {{{
    let g:ale_fixers = {}
    let g:ale_fixers.c = ['clang-format']
    let g:ale_fixers.cpp = g:ale_fixers.c
    let g:ale_fixers.css = ['stylelint']
    let g:ale_fixers.java = ['google_java_format']
    let g:ale_fixers.javascript = ['eslint']
    let g:ale_fixers.json = ['jq', 'fixjson']
    let g:ale_fixers.python = ['autopep8']
    let g:ale_fixers.scss = ['stylelint']
    let g:ale_fixers.sh = ['shfmt']
    " }}}

    " Options {{{
    let g:ale_pattern_options = {'.*\.min\..*$':
                \ {'ale_linters': [], 'ale_fixers': []}}
    " Python {{{
    let g:ale_python_flake8_options = '--ignore=W391,W504,E704,E731,F403,F405'
    let g:ale_python_autopep8_options = g:ale_python_flake8_options
    " }}}
    " Shell {{{
    let g:ale_sh_shellcheck_exclusions = 'SC1090,SC2128,SC2164'
    let g:ale_sh_shfmt_options = '-s -ci -i 2 -bn'
    " }}}
    " C {{{
    let g:ale_c_clang_options = '-std=c99 -Wall -Wextra'
    let g:ale_c_gcc_options = g:ale_c_clang_options
    let g:ale_c_clangtidy_checks = [
                \ 'bugprone-*', 'fuchsia-*', 'google-*', '-google-objc-*',
                \ '-google-runtime-int', 'llvm-*', 'misc-*', 'performance-*',
                \ 'readability-*', '-readability-braces-around-statements']
    " }}}
    " C++ {{{
    let g:ale_cpp_clang_options = '-std=c++11 -Wall -Wextra'
    let g:ale_cpp_gcc_options = g:ale_cpp_clang_options
    let g:ale_cpp_clangtidy_checks = ['bugprone-*', 'cppcoreguidelines-*',
                \ 'fuchsia-*', '-fuchsia-default-arguments', 'google-*',
                \ '-google-objc-*', '-google-runtime-int', 'hicpp-signed-bitwise',
                \ 'hicpp-multiway-paths-covered', 'hicpp-exception-baseclass',
                \ 'llvm-*', 'misc-*', 'modernize-*', 'performance-*',
                \ 'readability-*', '-readability-braces-around-statements']
    " }}}
    " }}}

    " Augroup {{{
    augroup ALEConfig
        au!
        au User ALEFixPre if (getline(1) =~# '^#!/bin/sh' ||
                    \ getline(1) ==# '#!/usr/bin/env sh') |
                    \ let b:ale_sh_shfmt_options =
                    \ '-s -ci -i 2 -bn -n' |
                    \ else | unlet! b:ale_sh_shfmt_options |
                    \ endif
    augroup END
    " }}}
    " }}}

    " NerdTree settings {{{
    if !g:_is_uni
        " Config {{{
        let g:NERDTreeHijackNetrw = 1
        let g:NERDTreeHighlightFolders = 1
        let g:NERDTreeIndicatorMapCustom = {
                    \ 'Modified'  : '~',
                    \ 'Staged'    : '+',
                    \ 'Untracked' : '*',
                    \ 'Renamed'   : '»',
                    \ 'Unmerged'  : '=',
                    \ 'Deleted'   : '-',
                    \ 'Dirty'     : '¤',
                    \ 'Clean'     : 'ø',
                    \ 'Ignored'   : '!',
                    \ 'Unknown'   : '?'}

        if &encoding !~? 'utf-8'
            let g:NERDTreeHighlightFolders = 0
            let g:NERDTreeIndicatorMapCustom['Renamed'] = '>'
            let g:NERDTreeIndicatorMapCustom['Dirty'] = 'x'
            let g:NERDTreeIndicatorMapCustom['Clean'] = 'o'
        endif
        " }}}

        " Augroup {{{
        augroup NERDTree
            au!
            au StdinReadPre * let s:std_in=1
            au BufEnter * if (winnr('$') == 1 && exists('b:NERDTree')
                        \ && b:NERDTree.isTabTree()) | q | endif
            au FileType nerdtree setl nolist | hi clear MatchParen
        augroup END
        " }}}
    endif
    " }}}

    " Jedi settings {{{
    let g:jedi#goto_command = '<Leader>jd'
    let g:jedi#goto_assignments_command = '<Leader>ja'
    let g:jedi#goto_definitions_command = '<Leader>jd'
    let g:jedi#documentation_command = '<Leader>jk'
    let g:jedi#usages_command = '<Leader>jn'
    let g:jedi#rename_command = '<Leader>jr'
    let g:jedi#show_call_signatures = '2'
    let g:jedi#use_tabs_not_buffers = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0
    " }}}

    " Color picker settings {{{
    if executable('kcolorchooser')
        let g:vcoolor_custom_picker = 'kcolorchooser --print --color '
    endif

    let g:vcoolor_disable_mappings = 1
    " }}}
endif

if has('nvim')
    " Semshi & Chromatica settings {{{
    let g:chromatica#enable_at_startup = 0
    let g:chromatica#libclang_path = s:clang_library_path
    let g:semshi#active = 0
    let g:semshi#error_sign = 0
    augroup SemanticHighlight
        au!
        au FileType c,cpp ChromaticaStart
        au FileType python let g:semshi#active = 1
        au FileType python hi semshiSelected ctermfg=208 ctermbg=NONE
    augroup END
    " }}}
endif

if g:os ==# 'linux' && !g:_is_uni
    " DevIcons settings {{{
    let g:webdevicons_enable_airline_tabline = 0
    let g:webdevicons_enable_airline_statusline = 1
    let g:WebDevIconsOS = 'Linux'
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
    " }}}
endif

" Javascript settings {{{
" Conceal {{{
let g:javascript_conceal_this = '@'
let g:javascript_conceal_prototype = '#'
let g:javascript_conceal_arrow_function = 'λ'

if &encoding ==? 'utf-8'
    let g:javascript_conceal_function = 'ƒ'
    let g:javascript_conceal_null = 'ø'
    let g:javascript_conceal_undefined = '¿'
    let g:javascript_conceal_NaN = '₦'
    " let g:javascript_conceal_return = '≺' "'↩'
else
    let g:javascript_conceal_function = 'φ'
    let g:javascript_conceal_null = 'ν'
    let g:javascript_conceal_undefined = 'υ'
endif
" }}}

" JsDoc {{{
let g:javascript_plugin_jsdoc = 1
let g:jsdoc_additional_descriptions = 0
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_enable_es6 = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_param_description_separator = ' - '
" }}}

" Tagged Template {{{
let g:taggedtemplate#tagSyntaxMap = {
            \ 'html': 'html',
            \ 'md':   'markdown',
            \ 'js':   'javascript',
            \ 'css':  'css',
            \ 'scss': 'scss'}
" }}}

" JSON {{{
let g:vim_json_syntax_conceal = 1
let g:vim_json_syntax_concealcursor = ''
let g:vim_json_warnings = 0
" }}}

" JSX {{{
let g:vim_jsx_pretty_enable_jsx_highlight = 1
let g:vim_jsx_pretty_colorful_config = 1
" }}}
" }}}

" Markdown settings {{{
let g:markdown_fenced_languages = ['html', 'sh',
            \ 'js=javascript', 'vim', 'python', 'r']
if !exists('g:mkdx#settings')
    let g:mkdx#settings = {
                \ 'links': {},
                \ 'checkbox': {},
                \ 'tokens': {},
                \ 'toc': {}
                \ }
endif
let g:mkdx#settings.highlight = {'enable': 1}
let g:mkdx#settings.fold = {'enable': 1}
let g:mkdx#settings.enter = {'enable': 0}
let g:mkdx#settings.map = {'prefix': '<Leader>m'}
let g:mkdx#settings.links.external = {'enable': 0}
let g:mkdx#settings.checkbox.toggles = [' ', 'x']
let g:mkdx#settings.checkbox.update_tree = 0
let g:mkdx#settings.tokens.list = '*'
let g:mkdx#settings.tokens.fence = '`'
let g:mkdx#settings.tokens.strike = '~~'
let g:mkdx#settings.toc.text = 'Table of Contents'
let g:mkdx#settings.toc.list_token = '*'
" }}}

" Emmet settings {{{
let g:user_emmet_settings = {
            \ 'html': extend({
            \   'filters': 'html',
            \   'empty_element_suffix': '>'
            \ }, s:emmet_defaults),
            \ 'pug': extend({
            \   'extends': 'jade',
            \   'filters': 'jade',
            \ }, s:emmet_defaults),
            \ 'php': {
            \   'extends': 'html',
            \   'filters': 'html,c'
            \ },
            \ 'javascript': {'extends': 'jsx'},
            \ 'htmldjango': {'extends': 'html'}
            \ }
" }}}

" RST settings {{{
let g:rst_use_emphasis_colors = 1
let g:rst_syntax_code_list = {}
let g:rst_syntax_code_list.sh = ['sh', 'shell']
let g:rst_syntax_code_list.python = ['python']
let g:rst_syntax_code_list.html = ['html']
let g:rst_syntax_code_list.json = ['json']
let g:rst_syntax_code_list.vim = ['vim']
let g:rst_syntax_code_list.javascript = ['http', 'js']
" }}}

" UltiSnips settings {{{
let g:UltiSnipsExpandTrigger = '<C-Space>'
let g:UltiSnipsJumpForwardTrigger = '<C-Space>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'
let g:UltiSnipsListSnippets = '<C-l>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsSnippetDirectories = [
            \ expand('<sfile>:p:h:h:h') .'/UltiSnips']
" }}}

" ClangComplete settings {{{
let g:clang_library_path = s:clang_library_path
let g:clang_complete_complete_auto = 0
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1
let g:clang_jumpto_back_key = ''
let g:clang_print_type_key = '<Leader>gp'
let g:clang_jumpto_declaration_key = '<Leader>gd'
let g:clang_jumpto_declaration_in_preview_key = '<Leader>gg'
" }}}

" Vim-G settings {{{
if g:os ==# 'android'
    let g:vim_g_open_command = 'xdg-open'
else
    let g:vim_g_open_command = exists('$BROWSER') ?
                \ expand('$BROWSER') : 'firefox'
endif
let g:vim_g_query_url = 'https://google.com/?q='
let g:vim_g_command = 'S'
" }}}

" Polyglot settings {{{
let g:polyglot_disabled = ['html', 'scss',
            \ 'rst', 'markdown', 'pug']
if has('nvim')
    let g:polyglot_disabled += ['python', 'c', 'cpp']
endif
" }}}

" Autopairs settings {{{
let g:AutoPairsSmartMode = 1
let g:AutoPairsShortcutToggle = '<C-p>t'
let g:AutoPairsShortcutBackInsert = '<C-p>b'
let g:AutoPairsShortcutFastWrap = '<C-p>w'
let g:AutoPairsShortcutJump = '<C-p>n'
" }}}

" GitGutter settings {{{
let g:gitgutter_max_signs = 2000
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '%'
" }}}

" CSV settings {{{
let g:csv_delim = ','
let g:csv_hiGroup = 'IncSearch'
let g:csv_no_conceal = 1
let g:csv_strict_columns = 1
" }}}

" EditorConfig settings {{{
let g:EditorConfig_max_line_indicator = 'exceeding'
let g:EditorConfig_exclude_patterns = [
            \ '(scp|https\?|s\?ftp)://.*',
            \ '(term|rsync|fugitive)://.*']
" }}}

" SplitJoin settings {{{
let g:splitjoin_quiet = 1
let g:splitjoin_trailing_comma = 0
let g:splitjoin_curly_brace_padding = 0
let g:splitjoin_html_attributes_hanging = 1
" }}}

" JavaComplete2 settings {{{
let g:JavaComplete_ImportSortType = 'packageName'
let g:JavaComplete_ImportOrder = ['java.',
            \ 'javax.', 'com.', 'org.', 'net.']
" }}}

" Mundo settings {{{
let g:mundo_width = 30
let g:mundo_close_on_revert = 1
" }}}

" HTTP settings {{{
" let g:vim_http_additional_curl_args = '-isS4'
" let g:vim_http_split_vertically = 1
" }}}

" Colorizer settings {{{
let g:colorizer_skip_comments = 1
" }}}

" Discord settings {{{
let g:discord_activate_on_enter = 0
" }}}

" Multiedit settings {{{
let g:multiedit_command = 'E'
" }}}

" vim:fdl=0:

