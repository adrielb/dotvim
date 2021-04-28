messages clear
source autoload/functions.vim

let file = '/home/abergman/projects/MyProject/src/some.code'
let project = functions#ValidProjectDir(file)
if project !=# 'MyProject'
  echoerr project
endif

let file = '/home/abergman/blog/Blog123_Some_post/src/Some_post.jl'
let project = functions#ValidProjectDir(file)
if project !=# 'Blog123_Some_post'
  echoerr project
endif

let file = 'dont/match/me.txt'
let project = functions#ValidProjectDir(file)
if project !=# ''
  echoerr project
endif

let file = 'fugitive://home/abergman/projects/dont/match/me.txt'
let project = functions#ValidProjectDir(file)
if project !=# ''
  echoerr project
endif


" messages

" nmap <leader>m :update<BAR>source test/test_dir_match.vim<CR>
