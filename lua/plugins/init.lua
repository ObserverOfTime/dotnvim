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
    custom_keys = {
        ['<localleader>l'] = false,
        ['<localleader>t'] = false
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
                'spellfile', 'tohtml', 'tutor', 'skim'
            }
        }
    },
    readme = {
        enabled = false
    }
})
