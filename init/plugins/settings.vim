scriptencoding utf-8

" Local variables {{{
let s:emmet_defaults = {
            \ 'default_attributes': {
            \   'a': {'href': '${cursor}', 'target': '_blank'},
            \   'button': {'type': 'submit'},
            \   'footer': {'id': 'footer'},
            \   'form': {'action': '${cursor}', 'method': 'GET'},
            \   'header': {'id': 'header'},
            \   'img': {'src': '${cursor}', 'alt': ''},
            \   'input': {'name': '${cursor}', 'type': 'text'},
            \   'label': {'for': '${cursor}'},
            \   'link': {'href': '${cursor}', 'rel': 'stylesheet',
            \            'type': 'text/css'},
            \   'main': {'id': '${cursor}'},
            \   'script': {'src': '${cursor}', 'type': 'text/javascript'},
            \   'style': {'src': '${cursor}', 'type': 'text/css'},
            \ },
            \ 'aliases': {
            \   'art': 'article',
            \   'btn': 'button',
            \   'fo': 'footer',
            \   'he': 'header',
            \   'in': 'input',
            \   'obj': 'object',
            \   'sec': 'section',
            \ },
            \ 'quote_char': '"',
            \ 'inline_break': 1
            \ }

if has('win32') || g:shell ==# 'msys'
    let s:libclang = GetPath($PROGRAMFILES, 'LLVM/lib/libclang.lib')
elseif g:shell ==# 'cygwin'
    let s:libclang = '/usr/lib/libclang.dll.a'
else
    let s:libclang = '/usr/lib/libclang.so'
endif
" }}}

" Airline settings {{{
" Config {{{
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
" Show expandtab & line + column numbers
if g:unicode
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
let g:airline#extensions#vimtex#enabled = 0
let g:airline#extensions#whitespace#conflicts_format = 'c[%s]'
let g:airline#extensions#whitespace#long_format = 'l[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mif[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mi[%s]'
let g:airline#extensions#whitespace#trailing_format = 't[%s]'
let g:airline#extensions#wordcount#formatter#default#fmt = '%sW'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
" }}}

" Symbols {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
if g:unicode
    let g:airline_powerline_fonts = 1
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.spell = '₷'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.readonly = '⊘'
    let g:airline_symbols.whitespace = '✹'
    let g:airline_symbols.notexists = ' Ɇ'
    let g:airline_symbols.dirty = ' ×'
else
    let g:airline_symbols_ascii = 1
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = 'λ'
    let g:airline_symbols.spell = 'ς'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.readonly = 'ο'
    let g:airline_symbols.whitespace = '!'
    let g:airline_symbols.notexists = ' ε'
    let g:airline_symbols.dirty = ' ~'
endif
" }}}
" }}}

if g:os !=# 'android' && v:version >= 800
    " NCM2 settings {{{
    let g:ncm2_pyclang#library_path = s:libclang
    augroup NCM2
        au!
        " Misc {{{
        if !has('nvim')
            au VimEnter * exec get(g:, 'neovim_rpc#py',
                        \ 'python3') .' import pynvim'
        endif
        au InsertEnter * call ncm2#enable_for_buffer()
        au InsertLeave * if !pumvisible() | pclose | endif
        au FileType c,cpp nnoremap <silent> <buffer> <Leader>gd
                    \ :<C-u>call ncm2_pyclang#goto_declaration_vsplit()<CR>
        if executable('node')
            au FileType pug,svelte call tern#Enable()
        endif
        " }}}

        " Sass {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'sass',
                    \ 'priority': 9,
                    \ 'subscope_enable': 1,
                    \ 'scope': ['css', 'scss', 'svelte', 'vue'],
                    \ 'mark': 'css',
                    \ 'word_pattern': '[\w-]+',
                    \ 'complete_pattern': [
                    \   ':\s*', '@[\w-]*\s*', '@media[\w\s]+\(',
                    \   '@supports \(', "@charset ['\"]"
                    \ ],
                    \ 'on_complete': [
                    \   'ncm2#on_complete#omni',
                    \   'sasscomplete#CompleteSass'
                    \ ]
                    \ })
        " }}}

        " Jedi {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'jedi',
                    \ 'priority': 9,
                    \ 'mark': 'py',
                    \ 'subscope_enable': 1,
                    \ 'scope': ['python', 'ipynb'],
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': [
                    \   '^\s*(import|from).*\s', '\.', '\(', ',\s+'
                    \ ],
                    \ 'on_complete': [
                    \   'ncm2#on_complete#omni', 'jedi#completions'
                    \ ]
                    \ })
        " }}}

        " Tern {{{
        if executable('node')
            au User Ncm2Plugin call ncm2#register_source({
                        \ 'name': 'tern',
                        \ 'priority': 9,
                        \ 'mark': 'js',
                        \ 'subscope_enable': 1,
                        \ 'scope': ['javascript'],
                        \ 'word_pattern': '[\w/]+',
                        \ 'complete_pattern': [
                        \   '\.', "require\\(['\"][^)'\"]*",
                        \   "import.*from\\s+['\"][^'\"]*"
                        \ ],
                        \ 'on_complete': [
                        \   'ncm2#on_complete#omni', 'tern#Complete'
                        \ ]
                        \ })
        endif
        " }}}

        " Emmet {{{
        au User Ncm2Plugin call ncm2#register_source({
                    \ 'name': 'emmet',
                    \ 'priority': 8,
                    \ 'subscope_enable': 1,
                    \ 'scope': ['html', 'htmldjango', 'pug',
                    \           'svelte', 'vue', 'xml'],
                    \ 'mark': 'emmet',
                    \ 'word_pattern': '[\w-]+',
                    \ 'complete_pattern': '[\w:]+',
                    \ 'on_complete': [
                    \   'ncm2#on_complete#omni', 'emmet#completeTag'
                    \ ]
                    \ })
        " }}}

        " TeX {{{
        if executable('latexmk')
            au User Ncm2Plugin call ncm2#register_source({
                        \ 'name': 'vimtex',
                        \ 'priority': 8,
                        \ 'scope': ['tex', 'bib', 'rnoweb'],
                        \ 'mark': 'tex',
                        \ 'word_pattern': '\w+',
                        \ 'complete_pattern': get(g:, 'vimtex#re#ncm2', []),
                        \ 'on_complete': [
                        \   'ncm2#on_complete#omni',
                        \   'vimtex#complete#omnifunc'
                        \ ]
                        \ })
        endif
        " }}}
    augroup END
    " }}}
endif

if g:os !=# 'android'
    " Ale settings {{{
    " Config {{{
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_linters_explicit = 1
    let g:ale_list_window_size = 5
    let g:ale_virtualenv_dir_names = ['.venv']
    " }}}

    " Symbols {{{
    if g:unicode
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

    " Aliases {{{
    let g:ale_linter_aliases = {}
    let g:ale_linter_aliases.rmd = ['r', 'markdown']
    let g:ale_linter_aliases.svelte = ['javascript', 'css']
    let g:ale_linter_aliases.vue = ['javascript']
    " }}}

    " Linters {{{
    let g:ale_linters = {}
    let g:ale_linters.c = ['clang', 'clangtidy']
    let g:ale_linters.cpp = g:ale_linters.c
    let g:ale_linters.cmake = ['cmakelint']
    let g:ale_linters.css = ['stylelint']
    let g:ale_linters.html = ['htmlhint']
    let g:ale_linters.javascript = ['eslint']
    let g:ale_linters.json = ['jq']
    let g:ale_linters.kotlin = ['ktlint']
    let g:ale_linters.lua = ['luacheck']
    let g:ale_linters.make = ['checkmake']
    let g:ale_linters.pug = ['puglint']
    let g:ale_linters.python = ['flake8', 'isort']
    let g:ale_linters.r = ['lintr']
    let g:ale_linters.rmd = g:ale_linters.r
    let g:ale_linters.rst = ['rstcheck']
    let g:ale_linters.rust = ['rustc', 'rustfmt']
    let g:ale_linters.scss = g:ale_linters.css
    let g:ale_linters.sh = ['shellcheck']
    let g:ale_linters.svelte = g:ale_linters.javascript + g:ale_linters.css
    let g:ale_linters.vim = ['vint']
    let g:ale_linters.vue = g:ale_linters.javascript
    let g:ale_linters.xml = ['xmllint']
    " }}}

    " Fixers {{{
    let g:ale_fixers = {}
    let g:ale_fixers.c = ['clangtidy', 'clang-format']
    let g:ale_fixers.cpp = g:ale_fixers.c
    let g:ale_fixers.css = ['stylelint']
    let g:ale_fixers.javascript = ['eslint']
    let g:ale_fixers.json = ['jq']
    let g:ale_fixers.python = ['autopep8', 'isort']
    let g:ale_fixers.r = ['styler']
    let g:ale_fixers.rust = ['rustfmt']
    let g:ale_fixers.scss = g:ale_fixers.css
    let g:ale_fixers.sh = ['shfmt']
    let g:ale_fixers.svelte = g:ale_fixers.javascript + g:ale_fixers.css
    let g:ale_fixers.vue = g:ale_fixers.javascript
    let g:ale_fixers.xml = ['xmllint']
    " }}}

    " Options {{{
    " Shell {{{
    let g:ale_sh_shellcheck_exclusions = 'SC1090,SC2128,SC2164'
    let g:ale_sh_shfmt_options = '-s -ci -i 2 -bn'
    " }}}
    " C {{{
    let g:ale_c_clang_options = '-std=c99 -Wall -Wextra'
    let g:ale_c_gcc_options = g:ale_c_clang_options
    let g:ale_c_cc_options = g:ale_c_clang_options
    let g:ale_c_clangformat_options = '-style=file'
    " }}}
    " C++ {{{
    let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wextra'
    let g:ale_cpp_gcc_options = g:ale_cpp_clang_options
    let g:ale_cpp_cc_options = g:ale_cpp_clang_options
    let g:ale_cpp_clangformat_options = g:ale_c_clangformat_options
    " }}}
    " CMake {{{
    let g:ale_cmake_cmakelint_executable = 'cmake-lint'
    let g:ale_cmake_cmakelint_options = '--tab-size 4'
    " }}}
    " JavaScript {{{
    let g:ale_javascript_eslint_suppress_missing_config = 1
    " }}}
    " }}}
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
endif

if has('nvim')
    " Semshi & Chromatica settings {{{
    let g:chromatica#enable_at_startup = 1
    let g:chromatica#libclang_path = s:libclang
    let g:semshi#active = 1
    let g:semshi#error_sign = 0
    " }}}
endif

" Javascript settings {{{
let g:javascript_conceal_this = '@'
let g:javascript_conceal_prototype = '#'
if g:unicode
    let g:javascript_conceal_function = 'ƒ'
    let g:javascript_conceal_arrow_function = '⇒'
    let g:javascript_conceal_null = 'ø'
    let g:javascript_conceal_undefined = '¿'
    let g:javascript_conceal_NaN = '₦'
else
    let g:javascript_conceal_function = 'φ'
    let g:javascript_conceal_arrow_function = 'λ'
    let g:javascript_conceal_null = 'ν'
    let g:javascript_conceal_undefined = 'υ'
endif
let g:javascript_plugin_jsdoc = 1
let g:tern_show_signature_in_pum = 1
let g:vim_json_syntax_conceal = 1
let g:vim_json_syntax_concealcursor = ''
let g:vim_json_warnings = 0
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
            \ 'svelte': extend({
            \   'extends': 'html',
            \   'empty_element_suffix': '/>',
            \ }, s:emmet_defaults),
            \ 'php': {
            \   'extends': 'html',
            \   'filters': 'html,c'
            \ },
            \ 'javascript': {'extends': 'jsx'},
            \ 'htmldjango': {'extends': 'html'},
            \ 'vue': {'extends': 'svelte'},
            \ }
" }}}

" TeX settings {{{
let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}
let g:vimtex_complete_bib = {'simple': 1}
let g:vimtex_complete_close_braces = 1
let g:vimtex_syntax_conceal = {}
let g:vimtex_syntax_conceal['accents'] = 1
let g:vimtex_syntax_conceal['fancy'] = g:unicode
let g:vimtex_syntax_conceal['greek'] = 1
let g:vimtex_syntax_conceal['math_bounds'] = 1
let g:vimtex_syntax_conceal['math_delimiters'] = g:unicode
let g:vimtex_syntax_conceal['math_fracs'] = g:unicode
let g:vimtex_syntax_conceal['math_super_sub'] = g:unicode
let g:vimtex_syntax_conceal['math_symbols'] = g:unicode
let g:vimtex_syntax_conceal['styles'] = 1
" }}}

" Markdown settings {{{
let g:vim_markdown_fenced_languages = [
            \ 'bash=sh',
            \ 'js=javascript',
            \ 'ini=dosini',
            \ ]
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_edit_url_in = 'vsplit'
let g:vim_markdown_conceal = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
" }}}

" RST settings {{{
let g:rst_use_emphasis_colors = 1
let g:rst_syntax_code_list = {}
let g:rst_syntax_code_list.sh = ['bash', 'sh']
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
            \ fnamemodify($MYVIMRC, ':h') .'/UltiSnips']
" }}}

" Pear Tree settings {{{
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 1
" }}}

" Vifm settings {{{
let g:vifm_replace_netrw = 1
if executable('konsole')
    let g:vifm_term = 'konsole --profile NvimTerm -e'
endif
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

" DoGe settings {{{
let g:doge_mapping = '<Leader>dg'
let g:doge_doc_standard_python = 'sphinx'
let g:doge_doc_standard_c = 'doxygen_qt'
let g:doge_doc_standard_cpp = 'doxygen_qt'
" }}}

" Shell settings {{{
let g:is_bash = 1
let g:sh_no_error = 1
let g:sh_fold_enabled = 3
" }}}

" Mundo settings {{{
let g:mundo_width = 30
let g:mundo_close_on_revert = 1
" }}}

" Colorizer settings {{{
let g:colorizer_skip_comments = 1
let g:colorizer_auto_filetype = join(g:_color_fts, ',')
" }}}

" R settings {{{
let g:R_assign = 0
let g:R_args = ['--no-save', '--quiet']
" }}}

" Doxygen settings {{{
let g:load_doxygen_syntax = 1
" }}}

" Hugefile settings {{{
let g:hugefile_trigger_size = 50
" }}}

" Discord settings {{{
let g:discord_activate_on_enter = 0
" }}}

" Multiedit settings {{{
let g:multiedit_command = 'E'
" }}}

" vim:fdl=0:
