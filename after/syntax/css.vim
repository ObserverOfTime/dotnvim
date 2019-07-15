syn match cssUIProp contained /pointer-events/
syn match cssPositioningProp contained /align-items/
syn match cssPositioningProp contained /flex-\(direction\|basis\|shrink\|grow\)/
syn match cssValueLength contained /[0-9\.\-]\+%/
syn match cssValueLength contained /[0-9\.]\+v[wh]/
syn match cssVendor contained /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
syn match cssPseudoClassID contained /-webkit-scrollbar[a-zA-Z-]*/
syn match cssPseudoClassID contained /-moz-focus\(-inner\|ring\)/
syn match cssPseudoClassID contained /-moz-placeholder/
syn match cssPositioningAttr /flex-start/
syn match cssPositioningAttr /space-\(between\|around\|evenly\)/

syn keyword cssTextAttr wrap
syn keyword cssPositioningAttr flex

hi! link cssPseudoClassID Special
hi! link cssVendor cssProp
hi! link cssUIProp cssProp
hi! link cssPositioningProp cssProp

hi! cssProp ctermfg=107 guifg=#8EC07C
