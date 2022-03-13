" Vim syntax file
" Language: pymanifest
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>
" TODO: trailing comments

if exists('b:current_syntax') | finish | endif

" Comment
syn keyword pymanifestTodo contained TODO FIXME XXX
syn region pymanifestComment start=/#/ end=/$/
            \ contains=pymanifestTodo

" Command
syn match pymanifestCommand
            \ /^\s*\v((recursive-|global-)?(in|ex)clude|graft|prune)/
            \ nextgroup=pymanifestPattern

" Pattern
syn region pymanifestPattern start=/\s/ end=+$+
            \ contains=pymanifestGlob,pymanifestRange,pymanifestSeparator,pymanifestLineBreak
syn match pymanifestLineBreak /\\$/ contained
syn match pymanifestGlob /\\\@<![?*]/ contained
syn match pymanifestRange /\\\@<!\[.\{-}\]/ contained
syn match pymanifestSeparator +/+ contained

hi def link pymanifestTodo Todo
hi def link pymanifestGlob Special
hi def link pymanifestRange Special
hi def link pymanifestComment Comment
hi def link pymanifestCommand Keyword
hi def link pymanifestPattern Identifier
hi def link pymanifestSeparator Delimiter
hi def link pymanifestLineBreak SpecialKey

let b:current_syntax = 'pymanifest'
