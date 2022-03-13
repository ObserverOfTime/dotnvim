My Neovim Configuration
=======================

**Neovim v0.7.0 is required.**

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
   * - ``W``
     - Save a file after creating parent directories

Syntax files
------------

Custom
^^^^^^

| Feel free to download any of these that you want.
| I might separate them from the repo at some point.
|

* `chatito <https://github.com/rodrigopivi/Chatito/blob/master/spec.md>`_
* `gitattributes <https://git-scm.com/docs/gitattributes>`_
* `gitignore <https://git-scm.com/docs/gitignore>`_
* `pymanifest <https://packaging.python.org/en/latest/guides/using-manifest-in/>`_
* `requirements <https://pip.pypa.io/en/stable/reference/requirements-file-format/>`_
* `srt <https://en.wikipedia.org/wiki/SubRip#SubRip_file_format>`_
* `vdf <https://developer.valvesoftware.com/wiki/KeyValues>`_

Vendored
^^^^^^^^

All of these are public domain.

* `ass <https://github.com/joeky888/Ass.vim>`_
* `manifest <https://github.com/alblue/vim-manifest>`_
* `openvpn <https://github.com/mvoppen/openvpn>`_

Plugins
-------

Packages
^^^^^^^^

Using packer.nvim_ as the plugin manager.

* `kyazdani42/nvim-web-devicons <https://github.com/kyazdani42/nvim-web-devicons>`_
* `rcarriga/nvim-notify <https://github.com/rcarriga/nvim-notify>`_
* `ibhagwan/fzf-lua <https://github.com/ibhagwan/fzf-lua>`_
* `ellisonleao/gruvbox.nvim <https://github.com/ellisonleao/gruvbox.nvim>`_
* `nvim-lualine/lualine.nvim <https://github.com/nvim-lualine/lualine.nvim>`_
* `lukas-reineke/virt-column.nvim <https://github.com/lukas-reineke/virt-column.nvim>`_
* `anuvyklack/pretty-fold.nvim <https://github.com/anuvyklack/pretty-fold.nvim>`_
* `folke/todo-comments.nvim <https://github.com/folke/todo-comments.nvim>`_
* `norcalli/nvim-colorizer.lua <https://github.com/norcalli/nvim-colorizer.lua>`_
* `numToStr/Comment.nvim <https://github.com/numToStr/Comment.nvim>`_
* `windwp/nvim-autopairs <https://github.com/windwp/nvim-autopairs>`_
* `gpanders/editorconfig.nvim <https://github.com/gpanders/editorconfig.nvim>`_
* `lewis6991/gitsigns.nvim <https://github.com/lewis6991/gitsigns.nvim>`_ |P|
* `ObserverOfTime/discord.nvim <https://github.com/ObserverOfTime/discord.nvim>`_ |R|
* `mattn/emmet-vim <https://github.com/mattn/emmet-vim>`_ |V|
* `AndrewRadev/splitjoin.vim <https://github.com/AndrewRadev/splitjoin.vim>`_ |V|
* `wsdjeg/vim-fetch <https://github.com/wsdjeg/vim-fetch>`_ |V|
* `tpope/vim-surround <https://github.com/tpope/vim-surround>`_ |V|
* `tpope/vim-abolish <https://github.com/tpope/vim-abolish>`_ |V|
* `tpope/vim-eunuch <https://github.com/tpope/vim-eunuch>`_ |V|
* `tpope/vim-fugitive <https://github.com/tpope/vim-fugitive>`_ |V|
* `nvim-treesitter/nvim-treesitter <https://github.com/nvim-treesitter/nvim-treesitter>`_

  - `nvim-treesitter/nvim-treesitter-refactor <https://github.com/nvim-treesitter/nvim-treesitter-refactor>`_
  - `nvim-treesitter/nvim-treesitter-textobjects <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>`_
  - `nvim-treesitter/playground <https://github.com/nvim-treesitter/playground>`_
  - `lewis6991/spellsitter.nvim <https://github.com/lewis6991/spellsitter.nvim>`_
  - `stsewd/sphinx.nvim <https://github.com/stsewd/sphinx.nvim>`_ |R|
* `mfussenegger/nvim-dap <https://github.com/mfussenegger/nvim-dap>`_

  - `rcarriga/nvim-dap-ui <https://github.com/rcarriga/nvim-dap-ui>`_
* `hrsh7th/nvim-cmp <https://github.com/hrsh7th/nvim-cmp>`_

  - `hrsh7th/cmp-path <https://github.com/hrsh7th/cmp-path>`_
  - `hrsh7th/cmp-buffer <https://github.com/hrsh7th/cmp-buffer>`_
  - `hrsh7th/cmp-nvim-lsp <https://github.com/hrsh7th/cmp-nvim-lsp>`_
  - `petertriho/cmp-git <https://github.com/petertriho/cmp-git>`_ |P|
  - `dcampos/cmp-snippy <https://github.com/dcampos/cmp-snippy>`_

    + `ObserverOfTime/nvim-snippy <https://github.com/ObserverOfTime/nvim-snippy>`_
* `neovim/nvim-lspconfig <https://github.com/neovim/nvim-lspconfig>`_

  - `kosayoda/nvim-lightbulb <https://github.com/kosayoda/nvim-lightbulb>`_
  - `simrat39/symbols-outline.nvim <https://github.com/simrat39/symbols-outline.nvim>`_
  - `folke/lua-dev.nvim <https://github.com/folke/lua-dev.nvim>`_
* `jose-elias-alvarez/null-ls.nvim <https://github.com/jose-elias-alvarez/null-ls.nvim>`_ |P|
* `mbbill/undotree <https://github.com/mbbill/undotree>`_ |V|
* `kg8m/vim-simple-align <https://github.com/kg8m/vim-simple-align>`_ |V|
* `chrisbra/unicode.vim <https://github.com/chrisbra/unicode.vim>`_ |V|
* `danymat/neogen <https://github.com/danymat/neogen>`_
* `akinsho/toggleterm.nvim <https://github.com/akinsho/toggleterm.nvim>`_
* `ellisonleao/glow.nvim <https://github.com/ellisonleao/glow.nvim>`_
* `jbyuki/nabla.nvim <https://github.com/jbyuki/nabla.nvim>`_
* `chrisbra/csv.vim <https://github.com/chrisbra/csv.vim>`_ |V| |S|
* `seletskiy/vim-pug <https://github.com/seletskiy/vim-pug>`_ |S|
* `vio/vim-stylus <https://github.com/vio/vim-stylus>`_ |S|
* `kchmck/vim-coffee-script <https://github.com/kchmck/vim-coffee-script>`_ |S|
* `wsdjeg/vim-livescript <https://github.com/wsdjeg/vim-livescript>`_ |S|
* `dieterplex/vim-smali <https://github.com/dieterplex/vim-smali>`_ |S|
* `MatthewDietrich/cup.vim <https://github.com/MatthewDietrich/cup.vim>`_ |S|
* `MartinDelille/vim-qmake <https://github.com/MartinDelille/vim-qmake>`_ |S|
* `aklt/plantuml-syntax <https://github.com/aklt/plantuml-syntax>`_ |S|
* `sayak-k/vim-log-highlighting <https://github.com/sayak-k/vim-log-highlighting>`_ |S|

| |S| Syntax file plugin
| |V| Legacy VimL plugin
| |R| Remote Python plugin
| |P| Requires plenary.nvim_

.. |V| replace:: :sup:`V`
.. |S| replace:: :sup:`S`
.. |R| replace:: :sup:`R`
.. |P| replace:: :sup:`P`

.. _packer.nvim: https://github.com/wbthomason/packer.nvim
.. _plenary.nvim: https://github.com/nvim-lua/plenary.nvim

Personal
^^^^^^^^

:dabline: Customise tabline colours and close icon
:multiedit: Edit multiple files in separate tabs

Tree-sitter
-----------

* bibtex
* c |T|
* cmake
* comment
* cpp |T|
* css |T|
* html
* java |T|
* javascript |T|
* jsdoc
* json |T|
* kotlin |T|
* latex |H|
* lua |T|
* make
* markdown
* nix |T|
* python |T|
* query
* r |T|
* regex
* rst
* scss |H| |T|
* svelte
* toml |T|
* typescript |H| |T|
* vim |T|
* yaml |T|

| |H| Custom highlights
| |T| Custom text objects

.. |H| replace:: :sup:`H`
.. |T| replace:: :sup:`T`

Language Servers
----------------

:bib: texlab_
:c: clangd_
:cmake: cmake-language-server_
:cpp: clangd_
:css: vscode-css-languageserver_
:dockerfile: docker-langserver_
:groovy: gradle-language-server_
:html: vscode-html-languageserver_
:javascript: typescript-language-server_
:json: vscode-json-languageserver_
:kotlin: kotlin-language-server_
:less: vscode-css-languageserver_
:lua: lua-language-server_
:python: jedi-language-server_
:r: `r-languageserver`_
:rst: esbonio_
:scss: vscode-css-languageserver_
:sh: bash-language-server_
:stylus: vscode-css-languageserver_
:svelte: svelteserver_
:svg: lemminx_
:tex: texlab_
:typescript: typescript-language-server_
:vim: `vim-language-server`_
:xml: lemminx_
:yaml: yaml-language-server_

Linters
-------

:css: stylelint_
:html: tidy_
:htmldjango: djlint_
:javascript: eslint_
:kotlin: ktlint_
:less: stylelint_
:lua: luacheck_
:pug: pug-lint_
:python:
   | flake8_
   | mypy_
   | pylint_
:rst: rstcheck_
:scss: stylelint_
:sh: shellcheck_
:stylus: stylint_
:svelte:
   | eslint_
   | stylelint_
:typescript: eslint_
:vim: vint_

Formatters
----------

:css: stylelint_
:html: tidy_
:javascript: eslint_
:kotlin: ktlint_
:less: stylelint_
:lua: stylua_
:perl: perltidy_
:python:
   | autopep8_
   | isort_
:scss: stylelint_
:sh: shfmt_
:svelte:
   | eslint_
   | stylelint_
:svg: xmllint_
:typescript: eslint_
:xml: xmllint_

Debuggers
---------

:c: lldb-vscode_
:cpp: lldb-vscode_
:javascript: vscode-node-debug2_
:python: debugpy_

.. footer::

   Licensed under `MIT No Attribution <LICENSE>`_.

.. _autopep8: https://github.com/hhatto/autopep8
.. _bash-language-server: https://github.com/bash-lsp/bash-language-server
.. _clangd: https://clangd.llvm.org/
.. _cmake-language-server: https://github.com/regen100/cmake-language-server
.. _debugpy: https://github.com/microsoft/debugpy
.. _djlint: https://djlint.com/
.. _docker-langserver: https://github.com/rcjsuen/dockerfile-language-server-nodejs
.. _esbonio: https://github.com/swyddfa/esbonio
.. _eslint: https://eslint.org/
.. _flake8: https://flake8.pycqa.org/
.. _gradle-language-server: https://github.com/naco-siren/vscode-gradle-language/tree/master/server
.. _isort: https://pycqa.github.io/isort/
.. _jedi-language-server: https://github.com/pappasam/jedi-language-server
.. _kotlin-language-server: https://github.com/fwcd/kotlin-language-server
.. _ktlint: https://ktlint.github.io/
.. _lemminx: https://github.com/eclipse/lemminx
.. _lldb-vscode: https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-vscode
.. _lua-language-server: https://github.com/sumneko/lua-language-server/
.. _luacheck: https://luacheck.readthedocs.io/
.. _mypy: https://mypy.readthedocs.io/
.. _perltidy: https://metacpan.org/dist/Perl-Tidy/view/bin/perltidy
.. _pug-lint: https://github.com/pugjs/pug-lint
.. _pylint: https://pylint.org/
.. _`r-languageserver`: https://github.com/REditorSupport/languageserver
.. _rstcheck: https://github.com/myint/rstcheck
.. _shellcheck: https://github.com/koalaman/shellcheck
.. _shfmt: https://github.com/mvdan/sh
.. _stylelint: https://stylelint.io/
.. _stylint: https://simenb.github.io/stylint/
.. _stylua: https://github.com/JohnnyMorganz/StyLua
.. _svelteserver: https://github.com/sveltejs/language-tools/tree/master/packages/language-server
.. _texlab: https://github.com/latex-lsp/texlab
.. _tidy: https://www.html-tidy.org/
.. _typescript-language-server: https://github.com/typescript-language-server/typescript-language-server
.. _`vim-language-server`: https://github.com/iamcco/vim-language-server
.. _vint: https://github.com/Vimjas/vint
.. _vscode-css-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/css-language-features/server
.. _vscode-html-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/html-language-features/server
.. _vscode-json-languageserver: https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server
.. _vscode-node-debug2: https://github.com/microsoft/vscode-node-debug2/tree/v1.42.10
.. _xmllint: https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html
.. _yaml-language-server: https://github.com/redhat-developer/yaml-language-server
