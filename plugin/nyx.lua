---Unix utilities
---@license MIT-0
---@author ObserverOfTime

local wrap = vim.schedule_wrap

---@private
---@param err string
local function notify_error(err)
    vim.notify(err, vim.log.levels.ERROR, {title = 'nyx.nvim'})
end

---Delete a file
---@param args CommandArgs
local function delete(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    vim.api.nvim_buf_delete(buf, {force = args.bang})
    if not vim.api.nvim_buf_is_loaded(buf) then
        vim.uv.fs_unlink(file, wrap(function(err)
            if err ~= nil then return notify_error(err) end
        end))
    end
end

---Copy a file
---@param args CommandArgs
local function copy(args)
    local cow = vim.g.nyx_cow or false
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    vim.uv.fs_copyfile(file, args.args, {
        excl = not args.bang,
        ficlone_force = cow
    }, wrap(function(err)
        if err ~= nil then return notify_error(err) end
        local fname = vim.fn.fnameescape(args.args)
        vim.cmd.edit {fname, bang = args.bang}
    end))
end

---Move a file
---@param args CommandArgs
local function move(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    if not args.bang and vim.uv.fs_stat(args.args) then
        local msg = 'EEXIST: file already exists: %s'
        return notify_error(msg:format(file, args.args))
    end
    vim.uv.fs_rename(file, args.args, wrap(function(err)
        if err ~= nil then return notify_error(err) end
        local fname = vim.fn.fnameescape(args.args)
        vim.cmd.edit {fname, bang = args.bang}
        vim.api.nvim_buf_delete(buf, {force = args.bang})
    end))
end

vim.api.nvim_create_user_command('Delete', delete, {
    bang = true, desc = 'delete the current file'
})

vim.api.nvim_create_user_command('Copy', copy, {
    nargs = 1, complete = 'dir', bang = true,
    desc = 'copy the current file'
})

vim.api.nvim_create_user_command('Move', move, {
    nargs = 1, complete = 'file', bang = true,
    desc = 'move the current file'
})
