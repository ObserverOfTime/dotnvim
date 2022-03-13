" Vim syntax file
" Language: Chatito
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>

if exists('b:current_syntax') | finish | endif

" Comment
syn keyword chatitoTodo contained TODO FIXME XXX
syn match chatitoComment /^#.*/ contains=chatitoTodo
syn match chatitoComment +^//.*+ contains=chatitoTodo

" Import
syn match chatitoImport /^import\s\+.*$/
            \ contains=chatitoImportKeyword,chatitoImportFile
syn keyword chatitoImportKeyword import
            \ contained nextgroup=chatitoImportFile
syn match chatitoImportFile /.*$/ contained skipwhite

" Intent
syn match chatitoIntent /^%\[[^\]]\+\]\((.\+)\)\=$/

" Slot
syn match chatitoSlot /^@\[[^\]]\+\]\((.\+)\)\=$/
syn match chatitoSlot /@\[[^\]]\+?\=\]/ contained

" Alias
syn match chatitoAlias /^\~\[[^\]]\+\]\((.\+)\)\=$/
syn match chatitoAlias /\~\[[^\]]\+?\=\]/ contained

" Probability
syn match chatitoProbability /\*\[[^\]]\+\]/ contained

" Value
syn match chatitoValue /^\s\{4\}.\+$/
            \ contains=chatitoProbability,chatitoSlot,chatitoAlias

hi def link chatitoTodo Todo
hi def link chatitoValue String
hi def link chatitoComment Comment
hi def link chatitoIntent Constant
hi def link chatitoImportFile Type
hi def link chatitoAlias Identifier
hi def link chatitoSlot StorageClass
hi def link chatitoImportKeyword Keyword
hi def link chatitoProbability Structure

let b:current_syntax = 'chatito'
