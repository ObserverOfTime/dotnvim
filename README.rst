My Neovim Configuration
=======================

**Neovim nightly is required.**

.. contents::
   :local:
   :backlinks: top

Settings
--------

See `lua/settings.lua <lua/settings.lua>`_

Mappings
--------

See `lua/mappings.lua <lua/mappings.lua>`_

Commands
--------

.. list-table::
   :stub-columns: 1

   * - ``Copy``
     - Copy the current file
   * - ``CopyFile``
     - Copy file to the clipboard
   * - ``CopyPath``
     - Copy path the the clipboard
   * - ``Delete``
     - Delete the current file
   * - ``DelTrail``
     - Delete trailing whitespace
   * - ``E``
     - Edit multiple files in tabs
   * - ``Move``
     - Move the current file
   * - ``Term``
     - Open a terminal in a horizontal split
   * - ``TermExec``
     - Execute the selection in the terminal

Plugins
-------

Using lazy.nvim_ as the plugin manager.

* `nvim-tree/nvim-web-devicons <https://github.com/nvim-tree/nvim-web-devicons>`_
* `rcarriga/nvim-notify <https://github.com/rcarriga/nvim-notify>`_
* `liangxianzhe/floating-input.nvim <https://github.com/liangxianzhe/floating-input.nvim>`_
* `ibhagwan/fzf-lua <https://github.com/ibhagwan/fzf-lua>`_
* `ellisonleao/gruvbox.nvim <https://github.com/ellisonleao/gruvbox.nvim>`_
* `nvim-lualine/lualine.nvim <https://github.com/nvim-lualine/lualine.nvim>`_
* `luukvbaal/statuscol.nvim <https://github.com/luukvbaal/statuscol.nvim>`_
* `lukas-reineke/virt-column.nvim <https://github.com/lukas-reineke/virt-column.nvim>`_
* `bbjornstad/pretty-fold.nvim <https://github.com/bbjornstad/pretty-fold.nvim>`_
* `tiagovla/scope.nvim <https://github.com/tiagovla/scope.nvim>`_
* `folke/todo-comments.nvim <https://github.com/folke/todo-comments.nvim>`_
* `uga-rosa/ccc.nvim <https://github.com/uga-rosa/ccc.nvim>`_
* `numToStr/Comment.nvim <https://github.com/numToStr/Comment.nvim>`_

   - `JoosepAlviste/nvim-ts-context-commentstring <https://github.com/JoosepAlviste/nvim-ts-context-commentstring>`_
* `windwp/nvim-autopairs <https://github.com/windwp/nvim-autopairs>`_
* `kylechui/nvim-surround <https://github.com/kylechui/nvim-surround>`_
* `lewis6991/gitsigns.nvim <https://github.com/lewis6991/gitsigns.nvim>`_
* `pwntester/octo.nvim <https://github.com/pwntester/octo.nvim>`_ |P|
* `ObserverOfTime/nvimcord <https://github.com/ObserverOfTime/nvimcord>`_
* `wsdjeg/vim-fetch <https://github.com/wsdjeg/vim-fetch>`_ |V|
* `tpope/vim-abolish <https://github.com/tpope/vim-abolish>`_ |V|

  - `smjonas/live-command.nvim <https://github.com/smjonas/live-command.nvim>`_
* `tpope/vim-fugitive <https://github.com/tpope/vim-fugitive>`_ |V|
* `nvim-treesitter/nvim-treesitter <https://github.com/nvim-treesitter/nvim-treesitter>`_

  - `nvim-treesitter/nvim-treesitter-refactor <https://github.com/nvim-treesitter/nvim-treesitter-refactor>`_
  - `nvim-treesitter/nvim-treesitter-textobjects <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>`_
* `Wansmer/treesj <https://github.com/Wansmer/treesj>`_
* `stsewd/sphinx.nvim <https://github.com/stsewd/sphinx.nvim>`_ |R|
* `mfussenegger/nvim-dap <https://github.com/mfussenegger/nvim-dap>`_

  - `rcarriga/nvim-dap-ui <https://github.com/rcarriga/nvim-dap-ui>`_ |N|
* `hrsh7th/nvim-cmp <https://github.com/hrsh7th/nvim-cmp>`_

  - `FelipeLema/cmp-async-path <https://codeberg.org/FelipeLema/cmp-async-path>`_
  - `hrsh7th/cmp-buffer <https://github.com/hrsh7th/cmp-buffer>`_
  - `hrsh7th/cmp-nvim-lsp <https://github.com/hrsh7th/cmp-nvim-lsp>`_
  - `wookayin/cmp-omni <https://github.com/wookayin/cmp-omni>`_
  - `petertriho/cmp-git <https://github.com/petertriho/cmp-git>`_ |P|
  - `dcampos/cmp-snippy <https://github.com/dcampos/cmp-snippy>`_

    + `ObserverOfTime/nvim-snippy <https://github.com/ObserverOfTime/nvim-snippy>`_
* `hedyhli/outline.nvim <https://github.com/hedyhli/outline.nvim>`_
* `mfussenegger/nvim-jdtls <https://github.com/mfussenegger/nvim-jdtls>`_
* `mbbill/undotree <https://github.com/mbbill/undotree>`_ |V|
* `vim-laundry/vim-lion <https://github.com/vim-laundry/vim-lion>`_ |V|
* `chrisbra/unicode.vim <https://github.com/chrisbra/unicode.vim>`_ |V|
* `chrishrb/gx.nvim <https://github.com/chrishrb/gx.nvim>`_
* `RaafatTurki/hex.nvim <https://github.com/RaafatTurki/hex.nvim>`_
* `prichrd/netrw.nvim <https://github.com/prichrd/netrw.nvim>`_
* `AckslD/nvim-FeMaco.lua <https://github.com/AckslD/nvim-FeMaco.lua>`_
* `danymat/neogen <https://github.com/danymat/neogen>`_
* `chrisbra/csv.vim <https://github.com/chrisbra/csv.vim>`_ |V| |S|
* `seletskiy/vim-pug <https://github.com/seletskiy/vim-pug>`_ |S|
* `vio/vim-stylus <https://github.com/vio/vim-stylus>`_ |S|
* `wsdjeg/vim-livescript <https://github.com/wsdjeg/vim-livescript>`_ |S|
* `aklt/plantuml-syntax <https://github.com/aklt/plantuml-syntax>`_ |S|

| |S| Syntax file plugin
| |V| Legacy VimL plugin
| |R| Remote Python plugin
| |P| Requires plenary.nvim_
| |N| Requires nvim-nio_

.. |V| replace:: :sup:`V`
.. |S| replace:: :sup:`S`
.. |R| replace:: :sup:`R`
.. |P| replace:: :sup:`P`
.. |N| replace:: :sup:`N`

.. _lazy.nvim: https://github.com/folke/lazy.nvim
.. _plenary.nvim: https://github.com/nvim-lua/plenary.nvim
.. _nvim-nio: https://github.com/nvim-neotest/nvim-nio

Tree-sitter
-----------

* awk
* bash |H|
* bibtex
* c
* cmake
* cpp
* css |H|
* desktop
* diff
* disassembly
* dockerfile
* doxygen
* editorconfig
* git_config
* git_rebase
* gitattributes
* gitcommit
* gitignore
* go
* gomod
* gpg
* groovy
* hlsplaylist
* html
* http
* java
* javascript
* jsdoc
* json
* jsonc
* jq
* kconfig
* kotlin |H|
* latex |H|
* lua
* luadoc
* luap
* markdown |I|
* markdown_inline
* meson
* pascal
* passwd
* pem
* powershell
* printf
* properties
* pymanifest
* python |I|
* query
* r
* readline
* regex
* requirements
* rnoweb
* rst
* rust
* scss |H|
* smali
* sql
* ssh_config
* svelte
* swift
* test
* toml
* typescript
* udev
* vim
* vimdoc
* xcompose
* xml
* yaml
* zathurarc
* zig

| |I| Custom injections
| |H| Custom highlights

.. |H| replace:: :sup:`H`
.. |I| replace:: :sup:`I`

Language Servers
----------------

:bib: texlab_
:c: clangd_
:cmake: neocmakelsp_
:cpp: clangd_
:css: vscode-css-languageserver_ & emmet-language-server_
:dockerfile: docker-langserver_
:go: gopls_
:gomod: gopls_
:html: vscode-html-languageserver_ & emmet-language-server_
:htmldjango: django-template-lsp_ & emmet-language-server_
:java: jdtls_
:javascript: typescript-language-server_ & eslint-language-server_
:json: vscode-json-languageserver_
:jsonc: vscode-json-languageserver_
:kotlin: kotlin-language-server_
:less: vscode-css-languageserver_ & emmet-language-server_
:lua: lua-language-server_
:python: pyright_ & ruff_
:pug: emmet-language-server_
:query: ts_query_ls_
:r: `r-languageserver`_
:rmd: `r-languageserver`_
:rnoweb: texlab_
:rst: esbonio_
:rust: rust-analyzer_
:scss: vscode-css-languageserver_ & emmet-language-server_
:sh: bash-language-server_
:sql: sqls_
:stylus: emmet-language-server_
:svelte: svelteserver_ & emmet-language-server_ & eslint-language-server_
:svg: lemminx_ & emmet-language-server_
:swift: sourcekit-lsp_
:tex: texlab_ & ltex-ls_
:toml: taplo_
:typescript: typescript-language-server_ & eslint-language-server_
:vim: `vim-language-server`_
:xml: lemminx_ & emmet-language-server_
:yaml: yaml-language-server_
:zig: zls_

Linters
-------

:css: stylelint_
:html: tidy_
:htmldjango: djlint_
:less: stylelint_
:lua: stylua_
:pug: pug-lint_
:python: mypy_
:rst: rstcheck_
:scss: stylelint_
:svelte: stylelint_
:vim: vint_

Formatters
----------

:css: stylelint_
:html: tidy_
:less: stylelint_
:lua: stylua_
:scss: stylelint_
:svelte: stylelint_
:svg: xmllint_
:xml: xmllint_

Debuggers
---------

:c: lldb-dap_
:cpp: lldb-dap_
:javascript: vscode-firefox-debug_ / vscode-js-debug_
:rust: lldb-dap_
:typescript: vscode-js-debug_
:lua: local-lua-debugger-vscode_
:python: debugpy_
:zig: lldb-dap_

.. footer::

   Licensed under `MIT No Attribution <LICENSE>`_.

.. _bash-language-server: https://github.com/bash-lsp/bash-language-server
.. _clangd: https://github.com/clangd/clangd
.. _debugpy: https://github.com/microsoft/debugpy
.. _django-template-lsp: https://github.com/fourdigits/django-template-lsp
.. _djlint: https://github.com/djlint/djLint
.. _docker-langserver: https://github.com/rcjsuen/dockerfile-language-server-nodejs
.. _emmet-language-server: https://github.com/olrtg/emmet-language-server
.. _esbonio: https://github.com/swyddfa/esbonio
.. _eslint-language-server: https://github.com/microsoft/vscode-eslint/tree/main/server
.. _gopls: https://github.com/golang/tools/tree/master/gopls
.. _jdtls: https://github.com/eclipse-jdtls/eclipse.jdt.ls
.. _kotlin-language-server: https://github.com/fwcd/kotlin-language-server
.. _lemminx: https://github.com/eclipse/lemminx
.. _lldb-dap: https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-dap
.. _local-lua-debugger-vscode: https://github.com/tomblind/local-lua-debugger-vscode
.. _ltex-ls: https://github.com/valentjn/ltex-ls
.. _lua-language-server: https://github.com/sumneko/lua-language-server
.. _mypy: https://github.com/python/mypy
.. _neocmakelsp: https://github.com/Decodetalkers/neocmakelsp
.. _pug-lint: https://github.com/pugjs/pug-lint
.. _pyright: https://github.com/microsoft/pyright
.. _r-languageserver: https://github.com/REditorSupport/languageserver
.. _rstcheck: https://github.com/rstcheck/rstcheck
.. _ruff: https://github.com/astral-sh/ruff/tree/main/crates/ruff_server
.. _rust-analyzer: https://github.com/rust-lang/rust-analyzer
.. _sourcekit-lsp: https://github.com/apple/sourcekit-lsp
.. _sqls: https://github.com/sqls-server/sqls
.. _stylelint: https://github.com/stylelint/stylelint
.. _stylua: https://github.com/JohnnyMorganz/StyLua
.. _svelteserver: https://github.com/sveltejs/language-tools/tree/master/packages/language-server
.. _taplo: https://github.com/tamasfe/taplo/tree/master/crates/taplo-lsp
.. _texlab: https://github.com/latex-lsp/texlab
.. _tidy: https://github.com/htacg/tidy-html5
.. _ts_query_ls: https://github.com/ribru17/ts_query_ls
.. _typescript-language-server: https://github.com/typescript-language-server/typescript-language-server
.. _vim-language-server: https://github.com/iamcco/vim-language-server
.. _vint: https://github.com/Vimjas/vint
.. _vscode-css-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/css-language-features/server
.. _vscode-firefox-debug: https://github.com/firefox-devtools/vscode-firefox-debug
.. _vscode-html-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/html-language-features/server
.. _vscode-js-debug: https://github.com/microsoft/vscode-js-debug
.. _vscode-json-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server
.. _xmllint: https://gitlab.gnome.org/GNOME/libxml2/-/blob/master/xmllint.c
.. _yaml-language-server: https://github.com/redhat-developer/yaml-language-server
.. _zls: https://github.com/zigtools/zls
