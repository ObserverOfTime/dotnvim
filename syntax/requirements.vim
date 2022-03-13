" Vim syntax file
" Language: requirements
" License: MIT-0
" Maintainer: ObserverOfTime <chronobserver@disroot.org>
" TODO: line breaks, options, urls, variables

if exists('b:current_syntax') | finish | endif

" Comment
syn keyword requirementsTodo contained TODO FIXME XXX
syn region requirementsComment start=/#/ end=/$/
            \ contains=requirementsTodo

" Package
syn match requirementsPackage /^[a-zA-Z0-9][a-zA-Z0-9_.-]*[a-zA-Z0-9]/
            \ nextgroup=requirementsExtras,requirementsVersion,requirementsMarkers

" Extras
syn match requirementsExtras /\[\S\+\]/ contains=requirementsDelimiter
            \ nextgroup=requirementsVersion,requirementsMarkers

" Version
syn region requirementsVersion matchgroup=requirementsSpecifier
            \ start=/\s*\zs\(===\|[><=!~]=\|[><]\)/ end=/\ze\([,;#\s]\|$\)/
            \ oneline nextgroup=requirementsMarkers,requirementsDelimiter

" Markers
syn region requirementsMarkers matchgroup=requirementsDelimiter
            \ start=/\s*\zs;/ end=/\ze\(#\|$\)/ oneline

" Delimiter
syn match requirementsDelimiter /,/ nextgroup=requirementsVersion

hi def link requirementsTodo Todo
hi def link requirementsMarkers Macro
hi def link requirementsExtras Special
hi def link requirementsComment Comment
hi def link requirementsVersion Constant
hi def link requirementsPackage Identifier
hi def link requirementsSpecifier Operator
hi def link requirementsDelimiter Delimiter

let b:current_syntax = 'requirements'
