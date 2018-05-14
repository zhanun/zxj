" vim-plug配置文件================
" vim-plus安装：
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

"自定义插件列表开始=======================
Plug 'maralla/completor.vim' 
Plug 'vim-scripts/indentpython.vim'   
Plug 'vim-syntastic/syntastic'
"Plug 'w0rp/ale'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Yggdroot/indentLine'
Plug 'tell-k/vim-autopep8'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
"Plug 'bling/vim-bufferline'
Plug 'jeetsukumaran/vim-buffergator'
"Plug 'bling/vim-airline'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" 自定义插件列表结束======================
call plug#end()
" vim-plug配置结束================


" 设置前导键leader为空格键
let mapleader = "\<space>"

" 插件相关设置

"异步插件设置======================
"下面这句不设置就是检测所有，设置后只检测设置的
"let g:ale_linters = {
"\   'javascript': ['eslint'],
"\   'python': ['flake8', 'pylint'],
"\}

" Check Python files with flake8 and pylint.
"let b:ale_linters = ['flake8', 'pylint']

" Fix Python files with autopep8 and yapf.
"let b:ale_fixers = ['autopep8', 'yapf']

" Disable warnings about trailing whitespace for Python files.
"let b:ale_warn_about_trailing_whitespace = 0
" Show 5 lines of errors (default: 10)

"let g:ale_list_window_size = 5

" 开启异步检测插件airline接口
"let g:airline#extensions#ale#enabled = 1

" 没有状态栏插件时，用下面函数创建
"function! LinterStatus() abort
"    let l:counts = ale#statusline#Count(bufnr(''))
"
"    let l:all_errors = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors
"
"    return l:counts.total == 0 ? 'OK' : printf(
"    \   '%dW %dE',
"    \   all_non_errors,
"    \   all_errors
"    \)
"endfunction
"set statusline=%{LinterStatus()}
" ==========================

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
"set guifont=Monaco:h13  
"关闭 swap files
set noswapfile


" 开启系统剪贴板
set clipboard=unnamed

" 开启代码自动折叠，修改快捷键空格折叠展开
set foldmethod=indent
set foldlevel=99
" press space to fold/unfold code
nnoremap <space> za
vnoremap <space> zf

" 开启python识别虚拟环境，如果不兼容可注释掉
" 如果报错，尝试 sudo apt install vim-nox-py2
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" 为py文件添加下支持pep8风格的配置

let python_highlight_all=1
"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set autoindent
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=80

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerfull
set backspace=indent,eol,start

"----------Stop python PEP 8 stuff--------------

" 全栈开发，你可以设置针对每种文件类型设置au命令
au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2
\ set softtabstop=2
\ set shiftwidth=2

" 如果想让新窗口在右边或者下方打开，添加配置
set splitbelow
set splitright
" :sv <filename>命令纵向分割布局打开一个文件
"  相反的命令:vs <filename> 横向分割布局

" 一键执行各种代码
""""""""""""""""""""""
"""Quickly Run
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
"    exec "!go build %<"
    exec "!time go run %"
elseif &filetype == 'mkd'
    exec "!~/.vim/markdown.pl % > %.html &"
    exec "!firefox %.html &"
endif
    endfunc
