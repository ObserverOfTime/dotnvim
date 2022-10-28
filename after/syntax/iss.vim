syntax match Normal /{{.\{-}}/ containedin=issSection

syntax keyword issTypesFlags
            \ full compact custom default minimal
            \ containedin=issSection
syntax keyword issIconsFlags
            \ menuicon desktopicon
            \ containedin=issSection
syntax keyword issParam
            \ ExternalSize String
            \ containedin=issSection
