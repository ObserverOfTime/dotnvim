---@meta

---@class CommandArgs
---@field name string
---@field args string
---@field fargs string[]
---@field nargs string
---@field bang boolean
---@field line1 integer
---@field line2 integer
---@field range integer
---@field count integer
---@field reg string
---@field mods string
---@field smods vim.api.keyset.cmd_mods

---@class AutocmdArgs
---@field buf integer
---@field event string
---@field file string
---@field match string
---@field id integer
---@field group? integer

---@class LspAttachArgs: AutocmdArgs
---@field data {client_id: integer}
