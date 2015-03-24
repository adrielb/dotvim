setlocal expandtab
setlocal autoindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

let s:efm = "%+GInput file=%f,"
let s:efm .= "ERROR at line %l,"
let &efm = s:efm . &efm
