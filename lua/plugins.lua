--- Plugins
local function plugins(use)
    local c = require 'config'

    --#region Utilities
    use {
        'kyazdani42/nvim-web-devicons',
        cond = [[vim.g.in_term]]
    }
    use {
        'rcarriga/nvim-notify',
        cond = [[vim.g.in_term]],
        config = [[require('config').notify()]]
    }
    use {
        'ibhagwan/fzf-lua',
        config = [[require('config').fzf()]]
    }
    --#endregion

    --#region Look and Feel
    use {
        'ellisonleao/gruvbox.nvim',
        cond = [[vim.g.in_term]],
        config = [[require('config.colorscheme')]]
    }
    use {
        'nvim-lualine/lualine.nvim',
        cond = [[vim.g.in_term]],
        config = [[require('config.statusline')]]
    }
    use {
        'lukas-reineke/virt-column.nvim',
        cond = [[vim.g.in_term]],
        config = [[require('config').virtcolumn()]]
    }
    use {
        'anuvyklack/pretty-fold.nvim',
        config = [[require('config').prettyfold()]]
    }
    use {
        'folke/todo-comments.nvim',
        config = [[require('config').todocomments()]]
    }
    use {
        'norcalli/nvim-colorizer.lua',
        ft = c.color_fts,
        config = [[require('config'):colorizer()]]
    }
    --#endregion

    --#region Miscellanea
    use {
        'numToStr/Comment.nvim',
        as = 'comment.nvim',
        config = [[require('config').comment()]]
    }
    use {
        'windwp/nvim-autopairs',
        config = [[require('config').autopairs()]]
    }
    use {
        'gpanders/editorconfig.nvim',
        cond = [[vim.fn.findfile('.editorconfig', '.;') ~= '']]
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        cond = [[vim.g.in_term]],
        config = [[require('config').gitsigns()]]
    }
    use {
        -- TODO: rewrite in Lua
        'ObserverOfTime/discord.nvim',
        run = ':UpdateRemotePlugins'
    }
    use {
        -- XXX: no alternative
        'mattn/emmet-vim',
        ft = c.emmet_fts
    }
    use {
        -- XXX: no good alternative
        'AndrewRadev/splitjoin.vim'
    }
    use {
        -- XXX: no alternative
        'wsdjeg/vim-fetch'
    }
    use {
        -- XXX: no good alternative
        'tpope/vim-surround',
        -- XXX: no alternative
        'tpope/vim-abolish',
        -- XXX: no alternative
        'tpope/vim-eunuch',
        -- XXX: no good alternative
        'tpope/vim-fugitive'
    }
    --#endregion

    --#region Tree-sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }
    use {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
    }
    use {
        'nvim-treesitter/playground',
        cmd = {'TSPlaygroundToggle'}
    }
    use {
        'lewis6991/spellsitter.nvim',
        config = [[require('spellsitter').setup()]]
    }
    use {
        'stsewd/sphinx.nvim',
        run = ':UpdateRemotePlugins'
    }
    --#endregion

    --#region Debugging
    use {
        'mfussenegger/nvim-dap',
        ft = c.debug_fts,
        cond = [[vim.g.in_term]],
        config = [[require('config.debugger')]]
    }
    use {
        'rcarriga/nvim-dap-ui',
        ft = c.debug_fts,
        cond = [[vim.g.in_term]],
        config = [[require('dapui').setup()]]
    }
    --#endregion

    --#region Completion
    use {
        'hrsh7th/nvim-cmp',
        config = [[require('config.completion')]]
    }
    use {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp'
    }
    use {
        'petertriho/cmp-git',
        requires = {'nvim-lua/plenary.nvim'},
        ft = {'gitcommit'},
        config = [[require('cmp_git').setup()]]
    }
    use {
        'dcampos/cmp-snippy',
        requires = {'ObserverOfTime/nvim-snippy'},
        config = [[require('snippy').setup()]]
    }
    --#endregion

    --#region LSP
    use {
        'kosayoda/nvim-lightbulb',
        fts = c.lsp_fts
    }
    use {
        'simrat39/symbols-outline.nvim',
        fts = c.lsp_fts
    }
    use {
        'folke/lua-dev.nvim',
        ft = {'lua'}
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = [[require('config.linters')]]
    }
    use {
        'neovim/nvim-lspconfig',
        fts = c.lsp_fts,
        config = [[require('config.lsp')]]
    }
    -- }}}

    --#region Commands
    use {
        -- XXX: nvim-lua/wishlist#21
        'mbbill/undotree',
        cmd = {'UndotreeToggle'}
    }
    use {
        --- XXX: no alternative
        'kg8m/vim-simple-align',
        branch = 'vim9',
        cmd = {'SimpleAlign'}
    }
    use {
        -- XXX: no alternative
        'chrisbra/unicode.vim',
        cond = [[vim.g.in_term]],
        keys = {'ga'},
        cmd = {'Digraphs', 'UnicodeName', 'UnicodeTable'},
        config = [[vim.keymap.set('n', 'ga', '<Plug>(UnicodeGA)')]]
    }
    use {
        'danymat/neogen',
        cmd = {'Neogen'},
        config = [[require('config').neogen()]]
    }
    use {
        'akinsho/toggleterm.nvim',
        keys = {'<Leader>t'},
        cmd = {'ToggleTerm', 'TermExec'},
        config = [[require('config').toggleterm()]]
    }
    --#endregion

    --#region Filetypes
    use {
        'ellisonleao/glow.nvim',
        ft = {'markdown'},
        cond = [[vim.fn.executable('glow') == 1]]
    }
    use {
        'jbyuki/nabla.nvim',
        ft = {'tex', 'rmd', 'rnoweb'}
    }
    use {
        -- XXX: no alternative
        'chrisbra/csv.vim',
        ft = {'csv'}
    }
    use {
        -- XXX: tree-sitter-pug is a WIP
        'seletskiy/vim-pug',
        ft = {'pug'}
    }
    use {
        --- XXX: no tree-sitter parser
        'vio/vim-stylus',
        ft = {'stylus'}
    }
    use {
        --- XXX: no tree-sitter parser
        'kchmck/vim-coffee-script',
        ft = {'coffee'}
    }
    use {
        -- XXX: no tree-sitter parser
        'wsdjeg/vim-livescript',
        ft = {'livescript'}
    }
    use {
        -- XXX: tree-sitter-smali is a WIP
        'dieterplex/vim-smali',
        ft = {'smali'}
    }
    use {
        -- XXX: no tree-sitter parser
        'MatthewDietrich/cup.vim',
        ft = {'cup'}
    }
    use {
        -- XXX: no tree-sitter parser
        'MartinDelille/vim-qmake',
        ft = {'qmake'}
    }
    use {
        -- XXX: tree-sitter-plantuml is a WIP
        'aklt/plantuml-syntax',
        ft = {'plantuml'}
    }
    use {
        -- XXX: no tree-sitter parser
        'sayak-k/vim-log-highlighting',
        commit = '66208db', -- MTDL9#12
        ft = {'log'}
    }
    --#endregion
end

--#region Config
require('packer').startup {
    plugins, config = {
        auto_reload_compiled = false,
        git = {default_url_format = 'git@github.com:%s'},
        display = {open_fn = require('packer.util').float}
    }
}
--#endregion
