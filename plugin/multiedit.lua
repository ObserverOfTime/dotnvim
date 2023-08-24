--- Like :tabedit but with multiple arguments
-- @module multiedit
-- @license MIT-0
-- @author ObserverOfTime

---@param file string
---@return boolean
local function isfile(file)
    return vim.fn.filereadable(file) == 1
end

---@param args CommandArgs
local function multiedit(args)
    local silent = {silent = true}
    if vim.tbl_isempty(args.fargs) then
        return vim.cmd.tabnew {mods = silent}
    end
    for _, arg in ipairs(args.fargs) do
        local glob = vim.fn.glob(arg)
        if glob ~= '' then
            local files = vim.tbl_filter(
                isfile, vim.fn.split(glob, '\n'))
            for _, file in ipairs(files) do
                -- file = vim.fn.fnamemodify(file, ':.')
                vim.cmd.tabedit {file, mods = silent}
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
