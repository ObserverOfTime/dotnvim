local wrap = vim.schedule_wrap
local ERROR = vim.log.levels.ERROR

---Edit multiple files in tabs
---@param args vim.api.keyset.create_user_command.command_args
local function multiedit(args)
    local silent = {silent = true}
    if vim.tbl_isempty(args.fargs) then
        return vim.cmd.tabnew {mods = silent}
    end
    for _, arg in ipairs(args.fargs) do
        local glob = vim.fn.glob(arg)
        if glob ~= '' then
            for _, file in ipairs(vim.fn.split(glob, '\n')) do
                if vim.fn.filereadable(file) == 1 then
                    -- file = vim.fn.fnamemodify(file, ':.')
                    vim.cmd.tabedit {file, mods = silent}
                end
            end
        else
            vim.cmd.tabedit {arg, mods = silent}
        end
    end
end

---Delete a file
---@param args vim.api.keyset.create_user_command.command_args
local function delete(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    vim.api.nvim_buf_delete(buf, {force = args.bang})
    if not vim.api.nvim_buf_is_loaded(buf) then
        vim.uv.fs_unlink(file, wrap(function(err)
            if err ~= nil then return vim.notify(err, ERROR) end
        end))
    end
end

---Copy a file
---@param args vim.api.keyset.create_user_command.command_args
local function copy(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    vim.uv.fs_copyfile(file, args.args, {
        excl = not args.bang,
        ficlone_force = true
    }, wrap(function(err)
        if err ~= nil then return vim.notify(err, ERROR) end
        local fname = vim.fn.fnameescape(args.args)
        vim.cmd.edit {fname, bang = args.bang}
    end))
end

---Move a file
---@param args vim.api.keyset.create_user_command.command_args
local function move(args)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    if not args.bang and vim.uv.fs_stat(args.args) then
        local msg = 'EEXIST: file already exists: %s'
        return vim.notify(msg:format(file, args.args), ERROR)
    end
    vim.uv.fs_rename(file, args.args, wrap(function(err)
        if err ~= nil then return vim.notify(err, ERROR) end
        local fname = vim.fn.fnameescape(args.args)
        vim.cmd.edit {fname, bang = args.bang}
        vim.api.nvim_buf_delete(buf, {force = args.bang})
    end))
end

vim.api.nvim_create_user_command('E', multiedit, {
    nargs = '*',
    complete = 'file',
    desc = 'edit multiple files in tabs'
})

vim.api.nvim_create_user_command('Delete', delete, {
    bang = true,
    desc = 'delete the current file'
})

vim.api.nvim_create_user_command('Copy', copy, {
    nargs = 1,
    complete = 'dir',
    bang = true,
    desc = 'copy the current file'
})

vim.api.nvim_create_user_command('Move', move, {
    nargs = 1,
    complete = 'file',
    bang = true,
    desc = 'move the current file'
})
