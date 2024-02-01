---Like `:tabedit` but with multiple arguments
---@license MIT-0
---@author ObserverOfTime

---Edit multiple files in tabs
---@param args CommandArgs
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
                    file = vim.fn.fnamemodify(file, ':.')
                    vim.cmd.tabedit {file, mods = silent}
                end
            end
        else
            vim.cmd.tabedit {arg, mods = silent}
        end
    end
end

vim.api.nvim_create_user_command('E', multiedit, {
    nargs = '*', complete = 'file',
    desc = 'edit multiple files in tabs'
})
