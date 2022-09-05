--- Like :tabedit but with multiple arguments
-- @module multiedit
-- @license MIT-0
-- @author ObserverOfTime

local function isfile(file)
    return vim.fn.filereadable(file) == 1
end

local function multiedit(args)
    if vim.tbl_isempty(args.fargs) then
        return vim.api.nvim_command('silent tabnew')
    end
    for _, arg in ipairs(args.fargs) do
        ---@diagnostic disable-next-line: missing-parameter
        local glob = vim.fn.glob(arg)
        if glob ~= '' then
            local files = vim.tbl_filter(
                isfile, vim.fn.split(glob, '\n'))
            for _, file in ipairs(files) do
                -- file = vim.fn.fnamemodify(file, ':.')
                vim.api.nvim_command('silent tabedit '..file)
            end
        else
            vim.api.nvim_command('silent tabedit '..arg)
        end
    end
end

vim.api.nvim_create_user_command('E', multiedit, {
    nargs = '*', complete = 'file',
    desc = 'lua multiedit(...)'
})
