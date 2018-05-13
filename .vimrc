" vim-plug配置文件
call plug#begin('~/.vim/plugged')

"自定义插件列表开始
Plug 'maralla/completor.vim' 
Plug 'vim-scripts/indentpython.vim'   
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'tell-k/vim-autopep8'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'bling/vim-bufferline'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'bling/vim-airline'

" 自定义插件列表结束

call plug#end()

" 插件相关设置
let g:completor_python_binary = '/usr/bin/python' " 补全设置
"let g:completor_clang_binary = '/path/to/clang'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
"let g:completor_node_binary = '/path/to/node'
"let g:completor_racer_binary = '/path/to/racer'
"let g:completor_gocode_binary = '/path/to/gocode'
map <C-n> :NERDTreeToggle<CR> " 开关树形目录的快捷键
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$'] " 设置忽略.pyc文件
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR> " 设置快捷键F8代替:Autopep8 
let g:pymode_python = 'python3' " python-mode 配置
 
" 基础设置

set nocompatible "关闭与vi的兼容模式
set number "显示行号
set nowrap    "不自动折行
set showmatch    "显示匹配的括号
set scrolloff=3        "距离顶部和底部3行"
set encoding=utf-8  "编码
set fenc=utf-8      "编码
set mouse=a        "启用鼠标
set hlsearch        "搜索高亮
syntax on    "语法高亮

set foldmethod=indent
set foldlevel=99
 
" press space to fold/unfold code
nnoremap <space> za
vnoremap <space> zf

" 为py文件添加下支持pep8风格的配置
au BufNewFile,BufRead *.py
\ set tabstop=4   "tab宽度
\ set softtabstop=4 
\ set shiftwidth=4  
\ set textwidth=79  "行最大宽度
\ set expandtab       "tab替换为空格键
\ set autoindent      "自动缩进
\ set fileformat=unix   "保存文件格式

" 如果想让新窗口在右边或者下方打开，添加配置
set splitbelow
set splitright

" 一键执行各种代码
""""""""""""""""""""""
    "Quickly Run
    """"""""""""""""""""""
    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python2.7 %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc
