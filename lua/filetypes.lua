--#region File conversions
local extension = {}

--- Convert buffer
local function convert(cmd, path, bufnr)
    vim.api.nvim_command(
        'silent %!'..cmd:format(path)
    )
    vim.api.nvim_buf_set_option(
        bufnr, 'modifiable', false
    )
    vim.api.nvim_buf_set_option(
        bufnr, 'readonly', true
    )
end

if vim.fn.executable('pdftotext') == 1 then
    --- Convert pdf -> text
    extension.pdf = function(path, bufnr)
        convert('pdftotext -nopgbrk -layout %q -', path, bufnr)
        return 'text'
    end
end

if vim.fn.executable('cfr') == 1 then
    --- Convert class -> java
    extension.class = function(path, bufnr)
        convert('cfr %q', path, bufnr)
        return 'java'
    end
end

if vim.fn.executable('xlsx2csv') == 1 then
    --- Convert xlsx -> csv
    extension.xlsx = function(path, bufnr)
        convert('xlsx2csv -e %q', path, bufnr)
        return 'csv'
    end
end
--#endregion

--#region Custom filetypes
vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 1

extension.ass = 'ass'
extension.chatito = 'chatito'
extension.ovpn = 'openvpn'
extension.srt = 'srt'
extension.tikz = 'tex'
extension.vdf = 'vdf'

vim.filetype.add {
    extension = extension,
    filename = {
        ['.gitattributes'] = 'gitattributes',
        ['.gitignore'] = 'gitignore',
        ['.latexmkrc'] = 'perl',
        ['.lintr'] = 'debcontrol',
        ['.luacheckrc'] = 'lua',
        ['.SRCINFO'] = 'dosini',
        ['dev-requirements.txt'] = 'requirements',
        ['MANIFEST.in'] = 'pymanifest',
        ['MANIFEST.MF'] = 'manifest',
        ['requirements.txt'] = 'requirements',
        ['Rprofile'] = 'r',
        ['vifmrc'] = 'vim',
    },
    pattern = {
        ['.*/git/ignore'] = 'gitignore',
        ['.*/info/attributes'] = 'gitattributes',
        ['.*/info/exclude'] = 'gitignore',
        ['.*/openvpn/.*/.*%.conf'] = 'openvpn',
    }
}
--#endregion

-- Add vim files to runtime
vim.opt.runtimepath:append('/usr/share/vim/vimfiles')
