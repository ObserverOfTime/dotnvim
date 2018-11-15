" vim-airline template by chartoin (http://github.com/chartoin)
" Base 16 Grayscale Scheme by Alexandre Gavioli (https://github.com/Alexx2/)
" Based on vim-airline-themes base16_grayscale
let s:gui00 = '#252525'
let s:gui01 = '#101010'
let s:gui02 = '#464646'
let s:gui03 = '#525252'
let s:gui04 = '#ababab'
let s:gui05 = '#b9b9b9'
let s:gui06 = '#e3e3e3'
let s:gui07 = '#f7f7f7'
let s:gui08 = '#7c7c7c'
let s:gui09 = '#999999'
let s:gui0A = '#a0a0a0'
let s:gui0B = '#8e8e8e'
let s:gui0C = '#868686'
let s:gui0D = '#686868'
let s:gui0E = '#747474'
let s:gui0F = '#5e5e5e'

let s:cterm00 = 235
let s:cterm01 = 233
let s:cterm02 = 238
let s:cterm03 = 239
let s:cterm04 = 248
let s:cterm05 = 250
let s:cterm06 = 254
let s:cterm07 = 15
let s:cterm08 = 243
let s:cterm09 = 246
let s:cterm0A = 247
let s:cterm0B = 245
let s:cterm0C = 244
let s:cterm0D = 241
let s:cterm0E = 243
let s:cterm0F = 240

let g:airline#themes#grayscale#palette = {}

let s:N1 = [s:gui01, s:gui0B, s:cterm01, s:cterm0B]
let s:N2 = [s:gui05, s:gui02, s:cterm05, s:cterm02]
let s:N3 = [s:gui05, s:gui01, s:cterm05, s:cterm01]
let g:airline#themes#grayscale#palette.normal =
            \ airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1 = [s:gui01, s:gui0D, s:cterm01, s:cterm0D]
let s:I2 = [s:gui05, s:gui02, s:cterm05, s:cterm02]
let s:I3 = [s:gui05, s:gui01, s:cterm05, s:cterm01]
let g:airline#themes#grayscale#palette.insert =
            \ airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1 = [s:gui01, s:gui08, s:cterm01, s:cterm08]
let s:R2 = [s:gui05, s:gui03, s:cterm05, s:cterm03]
let s:R3 = [s:gui05, s:gui01, s:cterm05, s:cterm01]
let g:airline#themes#grayscale#palette.replace =
            \ airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1 = [s:gui01, s:gui0E, s:cterm01, s:cterm0E]
let s:V2 = [s:gui05, s:gui03, s:cterm05, s:cterm03]
let s:V3 = [s:gui05, s:gui01, s:cterm05, s:cterm01]
let g:airline#themes#grayscale#palette.visual =
            \ airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA1 = [s:gui04, s:gui01, s:cterm04, s:cterm01]
let s:IA2 = [s:gui04, s:gui01, s:cterm04, s:cterm01]
let s:IA3 = [s:gui04, s:gui01, s:cterm04, s:cterm01]
let g:airline#themes#grayscale#palette.inactive =
            \ airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

