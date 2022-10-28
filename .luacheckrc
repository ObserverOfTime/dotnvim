---@diagnostic disable: undefined-global, lowercase-global

stds.nvim = {
    globals = {'vim'}
}

std = 'luajit+nvim'

globals = {'packer_plugins'}

exclude_files = {
    'plugin/packer_compiled.lua'
}
