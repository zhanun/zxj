" zxj's vim配置
" ================================================================================================
" Vundle配置部分

set nocompatible              " be iMproved, required
filetype off                  " required
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


"自定义插件列表开始

Plugin 'maralla/completor.vim' 
Plugin 'vim-scripts/indentpython.vim'	
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'tell-k/vim-autopep8'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'

" 自定义插件列表结束
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" 插件相关设置
let g:completor_python_binary = '/usr/bin/python' " 补全设置
map <C-n> :NERDTreeToggle<CR> " 开关树形目录的快捷键
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$'] " 设置忽略.pyc文件
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR> " 设置快捷键F8代替:Autopep8 

 
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


set tabstop=4   "tab宽度
set softtabstop=4 
set shiftwidth=4  
set textwidth=79  "行最大宽度
set expandtab       "tab替换为空格键
set autoindent      "自动缩进
set fileformat=unix   "保存文件格式

" 如果想让新窗口在右边或者下方打开，添加配置
set splitbelow
set splitright

" 一键执行各种代码
""""""""""""""""""""""
""" Quickly Run
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
