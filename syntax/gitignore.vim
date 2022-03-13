" Vim syntax file
" Language: gitignore
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>

if exists('b:current_syntax') | finish | endif

" Comment
syn keyword gitignoreTodo contained TODO FIXME XXX
syn match gitignoreComment /^#.*/ contains=gitignoreTodo

" Pattern
syn match gitignorePattern /^#\@!.*$/
            \ contains=gitignoreNegation,gitignoreGlob,gitignoreRange,gitignoreSeparator
syn match gitignoreNegation /^!/ contained
syn match gitignoreGlob /\\\@<![?*]/ contained
syn match gitignoreRange /\\\@<!\[.\{-}\]/ contained
syn match gitignoreSeparator +/+ contained

hi def link gitignoreTodo Todo
hi def link gitignoreGlob Special
hi def link gitignoreRange Special
hi def link gitignoreComment Comment
hi def link gitignorePattern Identifier
hi def link gitignoreSeparator Delimiter
hi def link gitignoreNegation SpecialChar

let b:current_syntax = 'gitignore'
