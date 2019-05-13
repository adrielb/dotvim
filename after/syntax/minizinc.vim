if exists("b:current_syntax")
    finish
endif

syntax match minizincComment "\v\%.*$"
syntax region picatString start=+"+ end=+"+
highlight link minizincComment Comment

let b:current_syntax = "minizinc"
