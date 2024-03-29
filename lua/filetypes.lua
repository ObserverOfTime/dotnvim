local extension = {}

---Convert buffer
---@param cmd string
---@param path string
---@param bufnr integer
local function convert(cmd, path, bufnr)
    vim.cmd('silent %!'..cmd:format(path))
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].readonly = true
end

---Convert `pdf -> text`
extension.pdf = function(path, bufnr)
    ---@module 'cmp'
    local cmp = package.loaded.cmp
    if cmp and cmp.visible() then return end
    convert('pdftotext -nopgbrk -layout %q -', path, bufnr)
    return 'text'
end

---Convert `class -> java`
extension.class = function(path, bufnr)
    convert('cfr %q', path, bufnr)
    return 'java'
end

---Convert `xlsx -> csv`
extension.xlsx = function(path, bufnr)
    convert('xlsx2csv -e %q', path, bufnr)
    return 'csv'
end

vim.filetype.add {
    extension = extension,
    filename = {
        ['.lintr'] = 'debcontrol',
        ['zathurarc'] = 'zathurarc'
    }
}
