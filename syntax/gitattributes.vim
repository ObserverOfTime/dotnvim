" Vim syntax file
" Language: gitattributes
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>

if exists('b:current_syntax') | finish | endif

" Comment
syn keyword gitattributesTodo contained TODO FIXME XXX
syn match gitattributesComment /^#.*/ contains=gitattributesTodo

" Pattern
syn match gitattributesPattern /^#\@!\v(".+"|\S+)/
            \ nextgroup=gitattributesAttribute skipwhite
            \ contains=gitattributesGlob,gitattributesRange,gitattributesSeparator
syn match gitattributesGlob /\\\@<![?*]/ contained
syn match gitattributesRange /\\\@<!\[.\{-}\]/ contained
syn match gitattributesSeparator +/+ contained

" Attribute
syn match gitattributesAttribute /\S\+/ contained
            \ nextgroup=gitattributesAttribute skipwhite
            \ contains=gitattributesPrefix,gitattributesAssign,gitattributesValue
syn match gitattributesPrefix +\s\@<=[!-]+ contained
syn match gitattributesAssign /=/ contained
syn match gitattributesValue /=\@<=\S\+/ contained

" Macro
syn match gitattributesMacro /^\[attr\]\S\+/
            \ nextgroup=gitattributesAttribute skipwhite

hi def link gitattributesTodo Todo
hi def link gitattributesGlob Special
hi def link gitattributesMacro Define
hi def link gitattributesRange Special
hi def link gitattributesAttribute Type
hi def link gitattributesValue Constant
hi def link gitattributesAssign Operator
hi def link gitattributesComment Comment
hi def link gitattributesPrefix SpecialChar
hi def link gitattributesPattern Identifier
hi def link gitattributesSeparator Delimiter

let b:current_syntax = 'gitattributes'
