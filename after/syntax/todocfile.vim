if exists("b:current_syntax")
    finish
endif

syntax match todoFile "^.\{-}\ze:"
syntax keyword todoKw todo TODO Todo
syntax match todoLineCol ":\d*:\d*:"

highlight default link todoKw Todo
highlight default link todoLineCol Number
highlight default link todoFile String

let b:current_syntax = 'todocfile'
