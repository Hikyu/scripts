">>>>>>vim 配置
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 开启实时搜索功能
set incsearch
" 设置窗口大小
set lines=35 columns=118
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu
" 插入新行，但不进入插入模式
nnoremap <Leader>o o<Esc>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 禁止光标闪烁
"set gcr=a:block-blinkon0
" 总是显示状态栏
set laststatus=2
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
"set cursorline
"set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" 去边框
set go=
" 禁止声音
set noeb
" 设置背景透明
hi Normal  ctermfg=252 ctermbg=none
" 出错时闪烁
set vb
">>>>插件管理
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'altercation/vim-colors-solarized'
Plugin 'nathanaelkane/vim-indent-guides' 
call vundle#end()
filetype plugin indent on

">>>>主题
syntax enable
"set background=dark
"set background=light
"colorscheme solarized
">>>>>缩进
" 随 vim 自启动
"let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
"let g:indent_guides_start_level=2
" 色块宽度
"let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
":nmap <silent> <Leader>i <Plug>IndentGuidesToggle
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
" 禁止折行
set nowrap
" 设置字体大小
set guifont=Monospace\ 12
" >>>>窗口最大化
"function s:CheckOS()
"
"    if has('win32')
"        return 'windows'
"    else
"        return 'linux'
"    endif
"
"endfunction
"
"function s:Window()
"
"    if has('gui')
"        set guiheadroom=0
"        winsize 123 31
"    endif
"
"endfunction
"
"if <sid>CheckOS()=='windows'
"
"    autocmd GUIEnter * simalt ~x
"
"elseif <sid>CheckOS()=='linux'
"
"    autocmd VimEnter * call <sid>Window()
"
"endif
