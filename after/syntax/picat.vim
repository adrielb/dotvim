if exists("b:current_syntax")
    finish
endif

" syntax keyword picatKeyword import end mip
" syntax keyword picatFunction println sum min foreach new_array time2 solve
for k in g:semanticBlacklistOverride['picat']
  exec "syntax keyword picatKeyword " . k
endfor
syntax match picatComment "\v\%.*$"
syntax region picatComment start="/\*" end="\*/"
syntax region picatString start=+"+ end=+"+

highlight link picatKeyword Keyword
highlight link picatFunction Function
highlight link picatComment Comment

let b:current_syntax = "picat"
