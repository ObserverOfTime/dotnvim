" Vim syntax file
" Language: VDF
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>

if exists('b:current_syntax') | finish | endif

" Comment
syn keyword vdfTodo contained TODO FIXME XXX
syn match vdfComment +//.*+ contains=vdfTodo

" Macro
syn match vdfMacro /^#.*/

" Tag
syn region vdfTag start=/"/ skip=/\\"/ end=/"/
            \ nextgroup=vdfValue skipwhite oneline

" Section
syn region vdfSection matchgroup=vdfBrace
            \ start=/{/ end=/}/ transparent fold
            \ contains=vdfTag,vdfSection,vdfComment,vdfConditional

" Conditional
syn match vdfConditional /\[\$\w\{1,1021}\]/ nextgroup=vdfTag

" Value
syn region vdfValue start=/"/ skip=/\\"/ end=/"/
            \ oneline contained contains=vdfVariable,vdfNumber,vdfEscape
syn region vdfVariable start=/%/ skip=/\\%/ end=/%/ contained
syn match vdfEscape /\\[nt"\\]/ contained
syn match vdfNumber /"\d\+"/ contained

hi def link vdfTodo Todo
hi def link vdfTag Keyword
hi def link vdfMacro Macro
hi def link vdfValue String
hi def link vdfNumber Number
hi def link vdfEscape Special
hi def link vdfBrace Delimiter
hi def link vdfComment Comment
hi def link vdfVariable Identifier
hi def link vdfConditional Constant

let b:current_syntax = 'vdf'
