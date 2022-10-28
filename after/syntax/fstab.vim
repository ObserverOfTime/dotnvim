syn keyword fsOptionsGeneral lazytime
syn keyword fsOptionsKeywords nodiscard hidden nohidden

syn keyword fsTypeKeyword exfat ntfs3 contained

syn match fsOptionsSize /\d\+[MG]/
syn match fsOptionsTime /\d\+[smh]/

syn match fsOptionsKeywords
            \ /\<size=/
            \ contained
            \ nextgroup=fsOptionsSize
syn match fsOptionsKeywords
            \ /\<x-systemd\.device-timeout=/
            \ contained
            \ nextgroup=fsOptionsTime

hi! link fsDevice Structure
hi! link fsMountPoint Special
hi! link fsOptionsTime Number
