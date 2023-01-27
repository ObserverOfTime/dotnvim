--- Unix utilities
-- @module nyx
-- @license MIT-0
-- @author ObserverOfTime

local wrap = vim.schedule_wrap

local function notify_error(err)
    vim.notify(err, vim.log.levels.ERROR, {title = 'nyx.nvim'})
end

local function delete(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    vim.api.nvim_buf_delete(buf, {force = args.bang})
    if not vim.api.nvim_buf_is_loaded(buf) then
        vim.loop.fs_unlink(file, wrap(function(err)
            if err ~= nil then return notify_error(err) end
        end))
    end
end

local function copy(args)
    local cow = vim.g.nyx_cow or false
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    vim.loop.fs_copyfile(file, args.args, {
        excl = not args.bang,
        ficlone_force = cow
    }, wrap(function(err)
        if err ~= nil then return notify_error(err) end
        vim.cmd.edit {args.args, bang = args.bang}
    end))
end

local function move(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    if not args.bang and vim.loop.fs_stat(args.args) then
        local msg = 'EEXIST: file already exists: %s'
        return notify_error(msg:format(file, args.args))
    end
    vim.loop.fs_rename(file, args.args, wrap(function(err)
        if err ~= nil then return notify_error(err) end
        vim.api.nvim_buf_delete(buf, {force = args.bang})
        vim.cmd.edit {args.args, bang = args.bang}
    end))
end

vim.api.nvim_create_user_command('Delete', delete, {
    bang = true, desc = 'Delete the current file'
})

vim.api.nvim_create_user_command('Copy', copy, {
    nargs = 1, complete = 'dir', bang = true,
    desc = 'Copy the current file'
})

vim.api.nvim_create_user_command('Move', move, {
    nargs = 1, complete = 'file', bang = true,
    desc = 'Move the current file'
})
