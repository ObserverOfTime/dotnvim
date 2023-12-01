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

   * - ``CopyFile``
     - Copy file to the clipboard
   * - ``DelTrail``
     - Delete trailing whitespace
   * - ``SynStack``
     - Show syntax groups under cursor
   * - ``Term``
     - Open a terminal in a horizontal split
   * - ``TermExec``
     - Execute the selection in the terminal

Plugins
-------

Packages
^^^^^^^^

Using lazy.nvim_ as the plugin manager.

* `nvim-tree/nvim-web-devicons <https://github.com/nvim-tree/nvim-web-devicons>`_
* `rcarriga/nvim-notify <https://github.com/rcarriga/nvim-notify>`_
* `rohit-s8/floating-input.nvim <https://github.com/rohit-s8/floating-input.nvim>`_
* `ibhagwan/fzf-lua <https://github.com/ibhagwan/fzf-lua>`_
* `ellisonleao/gruvbox.nvim <https://github.com/ellisonleao/gruvbox.nvim>`_
* `nvim-lualine/lualine.nvim <https://github.com/nvim-lualine/lualine.nvim>`_
* `luukvbaal/statuscol.nvim <https://github.com/luukvbaal/statuscol.nvim>`_
* `lukas-reineke/virt-column.nvim <https://github.com/lukas-reineke/virt-column.nvim>`_
* `anuvyklack/pretty-fold.nvim <https://github.com/anuvyklack/pretty-fold.nvim>`_
* `folke/todo-comments.nvim <https://github.com/folke/todo-comments.nvim>`_
* `uga-rosa/ccc.nvim <https://github.com/uga-rosa/ccc.nvim>`_
* `numToStr/Comment.nvim <https://github.com/numToStr/Comment.nvim>`_

   - `JoosepAlviste/nvim-ts-context-commentstring <https://github.com/JoosepAlviste/nvim-ts-context-commentstring>`_
* `windwp/nvim-autopairs <https://github.com/windwp/nvim-autopairs>`_
* `kylechui/nvim-surround <https://github.com/kylechui/nvim-surround>`_
* `lewis6991/gitsigns.nvim <https://github.com/lewis6991/gitsigns.nvim>`_
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

  - `rcarriga/nvim-dap-ui <https://github.com/rcarriga/nvim-dap-ui>`_
* `hrsh7th/nvim-cmp <https://github.com/hrsh7th/nvim-cmp>`_

  - `FelipeLema/cmp-async-path <https://github.com/FelipeLema/cmp-async-path>`_
  - `hrsh7th/cmp-buffer <https://github.com/hrsh7th/cmp-buffer>`_
  - `hrsh7th/cmp-nvim-lsp <https://github.com/hrsh7th/cmp-nvim-lsp>`_
  - `petertriho/cmp-git <https://github.com/petertriho/cmp-git>`_ |P|
  - `dcampos/cmp-snippy <https://github.com/dcampos/cmp-snippy>`_

    + `ObserverOfTime/nvim-snippy <https://github.com/ObserverOfTime/nvim-snippy>`_
* `simrat39/symbols-outline.nvim <https://github.com/simrat39/symbols-outline.nvim>`_
* `folke/neodev.nvim <https://github.com/folke/neodev.nvim>`_
* `nvimtools/none-ls.nvim <https://github.com/nvimtools/none-ls.nvim>`_ |P|
* `mbbill/undotree <https://github.com/mbbill/undotree>`_ |V|
* `mg979/vim-lion <https://github.com/mg979/vim-lion>`_ |V|
* `chrisbra/unicode.vim <https://github.com/chrisbra/unicode.vim>`_ |V|
* `danymat/neogen <https://github.com/danymat/neogen>`_
* `andythigpen/nvim-coverage <https://github.com/andythigpen/nvim-coverage>`_ |P|
* `chrisbra/csv.vim <https://github.com/chrisbra/csv.vim>`_ |V| |S|
* `seletskiy/vim-pug <https://github.com/seletskiy/vim-pug>`_ |S|
* `vio/vim-stylus <https://github.com/vio/vim-stylus>`_ |S|
* `kchmck/vim-coffee-script <https://github.com/kchmck/vim-coffee-script>`_ |S|
* `wsdjeg/vim-livescript <https://github.com/wsdjeg/vim-livescript>`_ |S|
* `aklt/plantuml-syntax <https://github.com/aklt/plantuml-syntax>`_ |S|

| |S| Syntax file plugin
| |V| Legacy VimL plugin
| |R| Remote Python plugin
| |P| Requires plenary.nvim_

.. |V| replace:: :sup:`V`
.. |S| replace:: :sup:`S`
.. |R| replace:: :sup:`R`
.. |P| replace:: :sup:`P`

.. _lazy.nvim: https://github.com/folke/lazy.nvim
.. _plenary.nvim: https://github.com/nvim-lua/plenary.nvim

Personal
^^^^^^^^

:dabline: Customise tabline colours and close icon
:multiedit: Edit multiple files in separate tabs
:nyx: File utilities (``Move``, ``Copy``, ``Delete``)

Tree-sitter
-----------

* awk
* bash |H|
* bibtex
* c
* cmake
* cpp
* css
* diff
* dockerfile
* html
* http
* gitattributes
* gitcommit
* gitignore
* glimmer
* java
* javascript
* jsdoc
* json
* jsonc
* kotlin
* latex |H|
* lua
* luadoc
* luap
* markdown |H| |I|
* markdown_inline |H|
* python
* query
* r
* regex
* rnoweb
* rst
* rust
* scss |H|
* svelte
* toml
* typescript
* vim
* vimdoc
* xml
* yaml

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
:html: vscode-html-languageserver_ & emmet-language-server_
:htmldjango: emmet-language-server_
:javascript: typescript-language-server_
:json: vscode-json-languageserver_
:less: vscode-css-languageserver_ & emmet-language-server_
:lua: lua-language-server_
:python: pyright_
:pug: emmet-language-server_
:r: `r-languageserver`_
:rmd: `r-languageserver`_
:rnoweb: texlab_
:rst: esbonio_
:rust: rust-analyzer_
:scss: vscode-css-languageserver_ & emmet-language-server_
:sh: bash-language-server_
:stylus: emmet-language-server_
:svelte: svelteserver_ & emmet-language-server_
:svg: lemminx_ & emmet-language-server_
:tex: texlab_ & ltex-ls_
:toml: taplo_
:typescript: typescript-language-server_
:vim: `vim-language-server`_
:xml: lemminx_ & emmet-language-server_
:yaml: yaml-language-server_

Linters
-------

:css: stylelint_
:html: tidy_
:htmldjango: djlint_
:javascript: eslint_d_
:less: stylelint_
:lua: luacheck_
:pug: pug-lint_
:python:
   | flake8_
   | mypy_
   | pylint_
   | ruff_
:rst: rstcheck_
:scss: stylelint_
:stylus: stylint_
:svelte:
   | eslint_d_
   | stylelint_
:typescript: eslint_d_
:vim: vint_

Formatters
----------

:css: stylelint_
:html: tidy_
:javascript: eslint_d_
:kotlin: ktlint_
:less: stylelint_
:lua: stylua_
:python:
   | autopep8_
   | isort_
:scss: stylelint_
:sh: shfmt_
:svelte:
   | eslint_d_
   | stylelint_
:svg: xmllint_
:typescript: eslint_d_
:xml: xmllint_

Debuggers
---------

:c: lldb-vscode_
:cpp: lldb-vscode_
:javascript: vscode-js-debug_
:typescript: vscode-js-debug_
:lua: local-lua-debugger-vscode_
:python: debugpy_

.. footer::

   Licensed under `MIT No Attribution <LICENSE>`_.

.. _autopep8: https://github.com/hhatto/autopep8
.. _bash-language-server: https://github.com/bash-lsp/bash-language-server
.. _clangd: https://clangd.llvm.org/
.. _debugpy: https://github.com/microsoft/debugpy
.. _djlint: https://djlint.com/
.. _docker-langserver: https://github.com/rcjsuen/dockerfile-language-server-nodejs
.. _emmet-language-server: https://github.com/olrtg/emmet-language-server
.. _esbonio: https://github.com/swyddfa/esbonio
.. _eslint_d: https://github.com/mantoni/eslint_d.js
.. _flake8: https://flake8.pycqa.org/
.. _isort: https://pycqa.github.io/isort/
.. _ktlint: https://ktlint.github.io/
.. _lemminx: https://github.com/eclipse/lemminx
.. _lldb-vscode: https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-dap
.. _local-lua-debugger-vscode: https://github.com/tomblind/local-lua-debugger-vscode
.. _ltex-ls: https://github.com/valentjn/ltex-ls
.. _lua-language-server: https://github.com/sumneko/lua-language-server
.. _luacheck: https://luacheck.readthedocs.io/
.. _mypy: https://mypy.readthedocs.io/
.. _neocmakelsp: https://github.com/Decodetalkers/neocmakelsp
.. _pug-lint: https://github.com/pugjs/pug-lint
.. _pylint: https://pylint.org/
.. _pyright: https://github.com/microsoft/pyright
.. _`r-languageserver`: https://github.com/REditorSupport/languageserver
.. _rstcheck: https://github.com/myint/rstcheck
.. _ruff: https://beta.ruff.rs/
.. _rust-analyzer: https://github.com/rust-lang/rust-analyzer
.. _shfmt: https://github.com/mvdan/sh
.. _stylelint: https://stylelint.io/
.. _stylint: https://simenb.github.io/stylint/
.. _stylua: https://github.com/JohnnyMorganz/StyLua
.. _svelteserver: https://github.com/sveltejs/language-tools/tree/master/packages/language-server
.. _taplo: https://github.com/tamasfe/taplo/tree/master/crates/taplo-lsp
.. _texlab: https://github.com/latex-lsp/texlab
.. _tidy: https://www.html-tidy.org/
.. _typescript-language-server: https://github.com/typescript-language-server/typescript-language-server
.. _`vim-language-server`: https://github.com/iamcco/vim-language-server
.. _vint: https://github.com/Vimjas/vint
.. _vscode-css-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/css-language-features/server
.. _vscode-html-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/html-language-features/server
.. _vscode-json-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server
.. _vscode-js-debug: https://github.com/microsoft/vscode-js-debug
.. _xmllint: https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html
.. _yaml-language-server: https://github.com/redhat-developer/yaml-language-server
