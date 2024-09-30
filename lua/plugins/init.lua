local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system {
        'git', 'clone', '--filter=blob:none', '--branch=stable',
        'https://github.com/folke/lazy.nvim.git', lazypath
    }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {'Failed to clone lazy.nvim:\n', 'ErrorMsg'},
            {out,                            'WarningMsg'},
            {'\nPress any key to exit...'}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)


require('lazy').setup('plugins.specs', {
    root = vim.fn.stdpath('data')..'/site/lazy',
    git = {
        url_format = 'git@github.com:%s.git'
    },
    dev = {
        path = '/mnt/ext/Code',
        fallback = true
    },
    install = {
        colorscheme = {'gruvbox', 'desert'}
    },
    change_detection = {
        enabled = false
    },
    performance = {
        rtp = {
            paths = {
                '/usr/share/vim/vimfiles'
            },
            disabled_plugins = {
                'tohtml', 'tutor', 'skim', 'fzf'
            }
        }
    },
    build = {
        warn_on_override = false
    },
    readme = {
        enabled = false
    },
    rocks = {
        enabled = false
    }
})
