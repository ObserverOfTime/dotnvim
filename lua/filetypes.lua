--#region File conversions
local extension = {}

--- Convert buffer
local function convert(cmd, path, bufnr)
    vim.api.nvim_command('silent %!'..cmd:format(path))
    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
    vim.api.nvim_buf_set_option(bufnr, 'readonly', true)
end

--- Convert pdf -> text
extension.pdf = function(path, bufnr)
    convert('pdftotext -nopgbrk -layout %q -', path, bufnr)
    return 'text'
end

--- Convert class -> java
extension.class = function(path, bufnr)
    convert('cfr %q', path, bufnr)
    return 'java'
end

--- Convert xlsx -> csv
extension.xlsx = function(path, bufnr)
    convert('xlsx2csv -e %q', path, bufnr)
    return 'csv'
end
--#endregion

--#region Custom filetypes
vim.filetype.add {
    extension = extension,
    filename = {
        ['.lintr']               = 'debcontrol',
        ['dev-requirements.txt'] = 'requirements',
        ['MANIFEST.in']          = 'pymanifest',
        ['requirements.txt']     = 'requirements',
    }
}
--#endregion

-- Add vim files to runtime
vim.opt.runtimepath:append('/usr/share/vim/vimfiles')
