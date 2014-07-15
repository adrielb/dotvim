setlocal efm=""
let &efm = "%+G%.%#::%.%#:%m," . &efm
setlocal commentstring=(*%s*)
