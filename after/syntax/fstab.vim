syn keyword fsOptionsGeneral lazytime
syn keyword fsOptionsKeywords nodiscard hidden nohidden

syn keyword fsTypeKeyword contained exfat ntfs3

syn match fsOptionsSize /\d\+[MG]/
syn match fsOptionsTime /\d\+[smh]/

syn match fsOptionsKeywords contained
    \ /\<size=/ nextgroup=fsOptionsSize
syn match fsOptionsKeywords contained
    \ /\<x-systemd\.device-timeout=/ nextgroup=fsOptionsTime

hi! link fsDevice Structure
hi! link fsMountPoint Special
hi! link fsOptionsTime Number
