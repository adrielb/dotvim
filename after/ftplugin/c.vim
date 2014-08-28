
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

" PETSc error format
" Match Petsc errors (stack trace)
let s:efm = "%m line %l in %f,"
" Ignore all other lines with [r]PETSC ERROR:...
let s:efm .= "%+G[%.]PETSC ERROR:%m,"
" Ignore -log_summary output
"/home/abergman/projects/DCell/FiberField/tests/ao.x on a gcc-debug named Gigabyte with 2 processors, by abergman Mon May 12 14:30:52 2014 Ignore -log_summary output
                      "on a      named      with      processors, by 
"let s:efm .= "%+G%.%# on a %.%# named %.%# with %.%# processors, by %.%#,"
let s:efm .= "%+G%.%# on a %m,"
let s:efm .= "%+GConfigure run at: %.%#,"
let s:efm .= "%+GLibraries compiled on%.%#,"

" prepend to global efm
let &efm = s:efm . &efm
