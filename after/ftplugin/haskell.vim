setlocal expandtab
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal textwidth=80
setlocal omnifunc=necoghc#omnifunc

map <buffer> ,c :GhcModCheck<CR>
map <buffer> ,i :GhcModInfo<CR>
map <buffer> ,l :GhcModClear<CR>
map <buffer> ,L :GhcModLint<CR>
map <buffer> ,t :GhcModType<CR>
map <buffer> ,T :GhcModTypeClear<CR>
map <buffer>  K :silent HoogleInfo<CR>

let s:efm = "%f:%l:%c:,"
let s:efm .="%f:%l:%c:%m,"
let s:efm .="%m %f:%l:%c,"
let s:efm .="%m %f:%l:%c),"
let s:efm .="%+G"
let &efm=s:efm
