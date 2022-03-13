" Vim syntax file
" Language: SubRip
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>

if exists('b:current_syntax') | finish | endif

setlocal spell

" Number
syn match srtNumber /^\d\+$/

" Range
syn region srtRange matchgroup=srtTime
            \ start=/\d\d:\d\d:\d\d,\d\d\d/
            \ end=/\d\d:\d\d:\d\d,\d\d\d/
            \ oneline skipwhite nextgroup=srtCoordinates
syn match srtCoordinates /X1:\d\+ X2:\d\+ Y1:\d\+ Y2:\d\+/

" Bold
syn region srtBold matchgroup=srtFormat
            \ start=+<b>+ end=+</b>+ transparent
syn region srtBold matchgroup=srtFormat
            \ start=+{b}+ end=+{/b}+ transparent

" Italics
syn region srtItalics matchgroup=srtFormat
            \ start=+<i>+ end=+</i>+ transparent
syn region srtItalics matchgroup=srtFormat
            \ start=+{i}+ end=+{/i}+ transparent

" Underline
syn region srtUnderline matchgroup=srtFormat
            \ start=+<u>+ end=+</u>+ transparent
syn region srtUnderline matchgroup=srtFormat
            \ start=+{u}+ end=+{/u}+ transparent

" Font
syn region srtFont matchgroup=srtFormat
            \ start=+<font[^>]*>+ end=+</font>+

" Position
syn match srtPosition /{\\a\d\+}/

hi def link srtNumber Number
hi def link srtFormat Special
hi def link srtRange Delimiter
hi def link srtTime Identifier
hi def link srtPosition Keyword
hi def link srtCoordinates Macro

let b:current_syntax = 'srt'
