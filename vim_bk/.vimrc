"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configurations of Pu's VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"pathgen
filetype off
" call pathogen#runtime_append_all_bundles()
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on                   " 语法高亮


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_do_shade = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible        " 不要使用vi的键盘模式，而是vim自己的
set shortmess=atI       " 启动的时候不显示那个援助索马里儿童的提示

function! MySys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

"Set shell to be bash
if MySys() == "unix" || MySys() == "mac"
    set shell=bash
else
    "I have to run win32 python without cygwin
    "set shell=E:cygwininsh
endif

set history=400         " 历史记录数

" filetype on                 " 侦测文件类型
if has("eval") && v:version>=600
    filetype plugin on  " 载入文件类型插件
    filetype indent on  " 为特定文件类型载入相关缩进文件
endif

if exists("&autoread")
    set autoread        " 设置当文件被改动时自动载入
endif

"Have the mouse enabled all the time:
if exists("&mouse")
    set mouse=a         " 打开鼠标支持
endif

let mapleader = ","     " Set mapleader
let g:mapleader = ","

" Fast saving
" nmap <leader>x :xa!<cr>
" nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""
" => Color and font
"""""""""""""""""""""""""""""""
syntax on                   " 语法高亮

set cul                 " 高亮光标所在行
" set cuc                 " 高亮光标所在列
" set cursorline          " 突出显示当前行

"高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%200v.*'
"           "高亮字符，让其不受100列限制

if has("multi_byte")        " 语言设置
    "set bomb
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        " Copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " Copied from someone's dotfile, untested
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
endif

if exists("&ambiwidth")
    set ambiwidth=double    " if you use vim in tty
endif

if has("gui_running")
    set guioptions-=m   " 隐藏菜单栏
    set guioptions-=T   " 隐藏工具栏
    set guioptions-=l
    set guioptions-=L   " 隐藏左侧滚动条
    set guioptions-=r   " 隐藏右侧滚动条
    set guioptions-=R
    set guioptions-=e
    set guioptions-=b   " 隐藏底部滚动条
    " set showtabline=0   " 隐藏Tab栏
    
    "set maximized
    "set lines=999 columns=999
    if MySys()=="win32"
        "start gvim maximized
        if has("autocmd")
            au GUIEnter * simalt ~x
        endif
    endif
    "let psc_style='cool'
    if v:version > 601
        "colorscheme ps_color
        "colorscheme default
        "colorscheme elflord
        colorscheme seoul256
        "colorscheme molokai
        "colorscheme desertEx
        set guifont=Monacoforpowerline\ 12
        "set guifont=DejaVuSansMono\ 13

    endif
else
    if v:version > 601
        "set background=dark
        "colorscheme default
        "colorscheme molokai
        "colorscheme seoul256-light
        colorscheme seoul256
        "colorscheme desert
        "set guifont=DejaVuSansMono\ 13
        set guifont=Monacoforpowerline\ 12
    endif
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"map <leader>1 :set syntax=cheetah<cr>
"map <leader>2 :set syntax=xhtml<cr>
"map <leader>3 :set syntax=python<cr>
"map <leader>4 :set ft=javascript<cr>
"map <leader>$ :syntax sync fromstart<cr>

"""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""
set ffs=unix,dos,mac    " 设置兼容dos和unix格式 

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>
noremap <leader>mm :%s/\r//g<CR>     " Remove the Windows ^M

"""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""
set so=7                " Set 7 lines to the curors - when moving vertical..
set wildmenu            " 增强模式中的命令行自动完成操作
" set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set cmdheight=1         " 命令行（在状态行下）的高度，默认为1
set number              " 显示行号
set lazyredraw          " Do not redraw, when running macros..
set hid                 " Change buffer - without saving

set backspace=eol,start,indent          " et backspace
set whichwrap+=<,>,h,l                  " 允许backspace和光标键跨越行边界

"Ignore case when searching
set ignorecase          " 搜索忽略大小写,但在有一个或以上大写字母时仍保持对大小写敏感
set incsearch           " 输入搜索内容时就显示搜索结果

set magic               " Set magic on

set noerrorbells        " 关闭错误信息响铃  
set novisualbell        " 关闭使用可视响铃代替呼叫  
set t_vb=               " 置空错误铃声的终端代码  

set showmatch           " 高亮显示匹配的括号
set showcmd             " 输入的命令显示出来

set mat=8               " How many tenths of a second to blink

set hlsearch            " 搜索时高亮显示被找到的文本

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
set laststatus=2        " 总是显示状态行
set t_Co=256
"    set statusline=
"    set statusline+=%2*%-3.3n%0*/ " buffer number
"    set statusline+=%f/ " file name
"    set statusline+=%h%1*%m%r%w%0* " flag
"    set statusline+=[
"    if v:version >= 600
"        set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
"        set statusline+=%{&fileencoding}, " encoding
"    endif
"    set statusline+=%{&fileformat}] " file format
"    if filereadable(expand("usr/share/vim//vim73/plugin/vimbuddy.vim"))
"        set statusline+= / %{VimBuddy()} " vim buddy
"    endif
"    set statusline+=%= " right align
"    set statusline+=[L=%l,C=%v]\ [P=%p%%]
"    set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor
"    set statusline+=\ [%{strftime(\"%d/%m/%y\ -\ %H:%M\")}]

" special statusbar for special window
" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f/                " file name
    set titlestring+=%h%m%r%w           " flag
    " set titlestring+=/ -/%{v:progname}  " program name
endif

"""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""
"Smart way to move btw. window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

if v:version>=700
    set switchbuf=usetab
endif

if exists("&showtabline")
    set stal=2          " always display the tab line
endif

"""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""
map <leader>cd :cd %:p:h<cr>        " Switch to current dir..

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"func! Cwd()
"    let cwd = getcwd()
"    return "e " . cwd
"endfunc

"func! DeleteTillSlash()
"    let g:cmd = getcmdline()
"    if MySys() == "unix" || MySys() == "mac"
"        let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
"    else
"        let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
"    endif
"    if g:cmd == g:cmd_edited
"        if MySys() == "unix" || MySys() == "mac"
"            let g:cmd_edited = substitute(g:cmd, "(.*[/]).*/", "", "")
"        else
"            let g:cmd_edited = substitute(g:cmd, "(.*[/]).*[/]", "", "")
"        endif
"    endif
"    return g:cmd_edited
"endfunc

"func! CurrentFileDir(cmd)
"    return a:cmd . " " . expand("%:p:h") . "/"
"endfunc

"cno $q <C->eDeleteTillSlash()<cr>
"cno $c e <C->eCurrentFileDir("e")<cr>
"cno $tc <C->eCurrentFileDir("tabnew")<cr>
"cno $th tabnew ~/
"cno $td tabnew ~/Desktop/

"Bash like
"cno <C-A> <Home>
"cno <C-E> <End>
"cno <C-K> <C-U>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb

"Open a dummy buffer for paste
"map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,"100,:20,%,n~/.viminfo

" Buffer - reverse everything ... :)
"map <F9> ggVGg?

"""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""
set nobackup            " 覆盖文件时不备份
set nowb
set noswapfile          " 不要生成swap文件,当buffer被丢弃时候隐藏它
" "set autowrite           " 自动保存
" set backupcopy=yes      " 设置备份时的行为为覆盖
" set autochdir           " 自动切换当前目录为当前文件所在的目录

"""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
    set fen
endif

if exists("&foldlevel")
    set fdl=0
endif

"""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""
set shiftwidth=4        " 设定 << 和 >> 命令移动时的宽度为 4  
set softtabstop=4       " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4           " Tab键的宽度
set expandtab           " 用空格代替制表符
" set noexpandtab         " 不要用空格代替制表符
set backspace=2
set smarttab            " 在行和段开始处使用制表符
set lbr
"set listchars=precedes:«,extends:»,tab:▸·,trail:∙,eol:¶
"set tw=500

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
set autoindent          " Auto indent
set smartindent         " 开启新行时使用智能自动缩进

if has("cindent")
    set cindent         " C-style indenting
endif

set wrap                " Wrap line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YankRing           " 查看寄存器内容
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y :YRShow<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Minibuffer         " Minibuffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:miniBufExplMapWindowNavVim = 1 
" let g:miniBufExplMapWindowNavArrows = 1 
" let g:miniBufExplMapCTabSwitchBufs = 1 
" let g:miniBufExplModSelTarget = 1
" let g:miniBufExplorerMoreThanOne = 0
" let g:miniBufExplUseSingleClick = 1
" let g:miniBufExplVSplit = 35
" let g:miniBufExplSplitBelow=0

""""""""""""""""""""""""""""""
" => LaTeX Suite thing
""""""""""""""""""""""""""""""
"set grepprg=grep -r -s -n
"let g:Tex_DefaultTargetFormat="pdf"
"let g:Tex_ViewRule_pdf='xpdf'

"if has("autocmd")
"    "Binding
"    au BufRead *.tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>
"
"    "Auto complete some things ;)
"    au BufRead *.tex ino <buffer> $i indent
"    au BufRead *.tex ino <buffer> $* cdot
"    au BufRead *.tex ino <buffer> $i item
"    au BufRead *.tex ino <buffer> $m [<cr>]<esc>O
"endif

""**********************************************************""
set confirm             " 在处理未保存或只读文件的时候，弹出确认
""**********************************************************""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagList(ctags)     " 查看函数列表，需要ctags程序 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let Tlist_Ctags_Cmd="/usr/bin/ctags"
" let Tlist_Compart_Format=1          " 压缩方式 
" let Tlist_Sort_Type="name"          " 按照名称排序 
" let Tlist_Show_Menu=1
" let Tlist_Exist_OnlyWindow=1        " 如果taglist窗口是最后一个窗口，则退出vim  
" let Tlist_Use_Right_Window=1        " 在右侧(1), 左侧(0)窗口中显示taglist窗口  
" let Tlist_File_Fold_Auto_Close=1    " 关闭其他文件的tags  
" let Tlist_Enable_Fold_Column=0      " 不要显示折叠树
" let Tlist_Auto_Open=0               " 默认自动打开Taglist   
" let Tlist_Auto_Update=1             " 自动更新
" let Tlist_Show_One_File=1           " 不同时显示多个文件的tag，只显示当前文件的 
" let Tlist_Hightlight_Tag_On_BufEnter = 1    " 标签高亮  

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" set tags=+tag
set tags+=./tags,./../tags,./*/tag  " use currentdir up dir recuit sub dir tag

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" => tagbar             " 查看函数列表
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
map <F4> :TagbarToggle<cr> 
let g:tagbar_ctags_bin = '/usr/bin/ctags'
let g:tagbar_autofocus = 1
let g:tagbar_width = 35


""""""""""""""""""""""""""""""
" => VIM
""""""""""""""""""""""""""""""
if has("autocmd") && v:version>600
    au BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" => MISC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " Paste toggle - when pasting something in, don't indent.
" set pastetoggle=<F3>

"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"clipboard with xclip
"if MySys() == "unix"
"    vmap <F6> :!xclip -sel c<CR>
"    map <F7> :-1r!xclip -o -seln c<CR>'z
"endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cscope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set csto=0      " 1表示优先使用ctags数据库,0表示优先使用cscope数据库  
    set cst         " 始终同时查找cscope数据库和tags文件
    set csverb      " 显示表示表示执行成功或失败的信息
endif


function Do_CsTag()
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h > cscope.files"
            " silent! execute "del cscope.files"
            " silent! execute "for /r . %%a in (*.c,*.cpp,*.h,*.hpp) do echo %%a >> cscope.files"
        endif
        silent! execute "!cscope -Rbq"
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        endif
    endif
endf
map <C-F10> :call Do_CsTag()<CR>

" "" s    C symbol        查找c语言符号，即函数名、宏、枚举值等出现的地方
" "" g    definition      查找函数、宏、枚举等定义的位置
" "" c    calling         查找调用本函数的函数 
" "" t    text string     查找制定的字符串
" "" e    egrep pattern   查找egrep模式
" "" f    file            查找并打开文件，类似vim的find
" "" i    including       查找包含本文件的文件
" "" d    called by       查找本函数调用的函数

" nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
" nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" "   "查找时就会使vim水平分隔窗口，结果显示在新的窗口中
" nmap <C-s-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
" nmap <C-s-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
" nmap <C-s-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
" nmap <C-s-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
" nmap <C-s-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
" nmap <C-s-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
" nmap <C-s-\>i :scs find i <C-R>=expand("<cfile>")<CR>$<CR>
" nmap <C-s-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>

""**********************************************************""
set selection=exclusive     " 打开鼠标支持
set selectmode=mouse,key
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
set formatoptions=tcrqn     " format
set completeopt=longest,menu
set complete=.,i
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
""**********************************************************""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => powerline           " statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Powerline_symbols='fancy'
let g:Powerline_cache_enabled = 1
" let g:Powerline_dividers_override = ['>>', '>', '<<', '<']
" let g:Powerline_symbols_override = {
            " \   'BRANCH': [0x2b60]
            " \ , 'RO'    : [0x2b64]
            " \ , 'FT'    : [0x2b62, 0x2b63]
            " \ , 'LINE'  : [0x2b61]
            " \}
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => dict               " 语法词典
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => matchit            " 扩展%匹配范围，根据filetype做不同的匹配
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType java set omnifunc=javacomplete#Complete
runtime macros/matchit.vim
let g:acp_behaviorSnipmateLength=1

""**********************************************************""
nmap <F5> :cn<cr>
nmap <F6> :cp<cr>
nmap <F8> :EasyBuffer<cr>
nmap <s-T> :CommandT<cr>

nmap <F9> :Pyrun<cr> 

nnoremap <F7> :UndotreeToggle<cr>

" silent! cs add /home/mars/src/qt484/cscope.out
if has("persistent_undo")
    set undodir='/home/mars/undo_tree/'
    set undofile
endif
""**********************************************************""

"rope python
"rope python default values
" Load rope plugin
let pymode_rope_vim_completion=1

let g:pymode_rope = 1

" Auto create and open ropeproject
let g:pymode_rope_auto_project = 1

" Enable autoimport
let g:pymode_rope_enable_autoimport = 1

" Auto generate global cache
let g:pymode_rope_autoimport_generate = 1

let g:pymode_rope_autoimport_underlineds = 0

let g:pymode_rope_codeassist_maxfixes = 10

let g:pymode_rope_sorted_completions = 1

let g:pymode_rope_extended_complete = 1

let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]

let g:pymode_rope_confirm_saving = 1

let g:pymode_rope_global_prefix = "<C-x>p"

let g:pymode_rope_local_prefix = "<C-c>r"

let g:pymode_rope_vim_completion = 1

let g:pymode_rope_guess_project = 1

let g:pymode_rope_goto_def_newwin = ""

let g:pymode_rope_always_show_complete_menu = 0

""**********************************************************""
" => clang autocomplete     " 
""**********************************************************""
"clang_config
let g:clang_auto_select=1
"let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1

let g:clang_snippets_engine="clang_complete"
"let g:clang_snippets_engine="snipmate"
"let g:clang_trailing_placeholder=1

let g:clang_conceal_snippets=1
"set concealcursor=in
"set conceallevel=2

let g:clang_exec="clang"
let g:clang_user_options=""
"let g:clang_user_options='2>/dev/null || exit 0"'
let g:clang_auto_user_options="path, .clang_complete, clang"
let g:clang_use_library=1
let g:clang_library_path="/usr/lib/"
"let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=1

let g:clang_hl_errors=1
let g:clang_complete_copen=1

nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>
"nnoremap <Leader>r :call ClangGetReferences()<CR>
"nnoremap <Leader>d :call ClangGetDeclarations()<CR>
"nnoremap <Leader>s :call ClangGetSubclasses()<CR>

"nmap <C-F11>:!make CC='~/.vim/bundle/clang_complete/bin/cc_args.py gcc' CXX='~/.vim/bundle/clang_complete/bin/cc_args.py g++' -B <cr>
"let g:SuperTabMappingForward="<tab>"

""**********************************************************""
let g:splice_initial_mode = "compare"
let g:splice_initial_layout_grid = 2
let g:splice_initial_layout_compare = 1
""**********************************************************""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SrcExpl        " 让VIM拥有source insight 一样的预览窗口  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" // The switch of the Source Explorer 
nmap <F10> :SrcExplToggle<CR> 

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to Avoid conflicts, the Source Explorer should know what plugins 
" // are using buffers. And you need add their bufname into the list below 
" // according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<C-F11>" 

" // Set "<F3>" key for displaying the previous definition in the jump list 
let g:SrcExpl_prevDefKey = "<C-3>" 

" // Set "<F4>" key for displaying the next definition in the jump list 
let g:SrcExpl_nextDefKey = "<C-4>" 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fuzzfinder         " 自动补全
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <c-s-f> :FufBufferTag<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => qt help plugin     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"qt help plugin
let g:qthelp_tags='/usr/local/Trolltech/Qt-4.8.4/doc/tags'
"let g:qthelp_tags+='/usr/local/qwt-6.1.0-rc3/doc/tags'
let g:qthelp_browser='/opt/google/chrome/google-chrome'

nmap <c-s-g> :QHelpOnThis<CR>
"just for the target
nmap <C-F7> :! ./CMDSim<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim easy align     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <silent> <Enter> :EasyAlign<cr>
"let g:easy_align_ignore_comment = 0
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': { 'pattern': '//\+\|/\*\|\*/' },
\ '#': { 'pattern': '#\+' },
\ ']': {
\     'pattern':       '[\[\]]',
\     'margin_left':   '',
\     'margin_right':  '',
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'margin_left':   '',
\     'margin_right':  '',
\     'stick_to_left': 0
\   }
\ }

"""vim easytags
""let g:easytags_cmd = '/usr/local/bin/ctags'
""let g:easytags_file = '~/lib_indx/easytags/tags'
""
""set tags+=./tags
"""let g:easytags_dynamic_files = 1
""let g:easytags_dynamic_files = 2
""let g:easytags_by_filetype = 1
""let g:easytags_events = ['BufWritePost']
""let g:easytags_include_members = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MiniBufExpl        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

" MiniBufExpl Colors
"hi MBENormal               guifg=#808080 guibg=fg
"hi MBEChanged              guifg=#CD5907 guibg=fg
"hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
"hi MBEVisibleChanged       guifg=#F1266F guibg=fg
"hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
"hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg
"
""**********************************************************""
map <leader>gc :CscopeGen<CR>
""**********************************************************""

"syntastic
let g:syntastic_check_on_open=1 
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
" "for qt checking source by .clang_complete gen files
" let g:syntastic_cpp_include_dirs=['/usr/local/Trolltech/Qt-4.8.4/include/', '/usr/share/qt4/mkspecs/linux-g++/', '/usr/include/qt4/QtCore', '/usr/include/qt4/QtGui', '/usr/local/qwt-6.1.0-rc3/include', '/usr/local/Trolltech/Qt-4.8.4/include/QtCore/', '/usr/local/Trolltech/Qt-4.8.4/include/QtGui/'] 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quickfix          "                 "  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   :cc         显示详细错误信息 ( :help :cc )
"   :cp         跳到上一个错误 ( :help :cp )
"   :cn         跳到下一个错误 ( :help :cn )
"   :cl         列出所有错误 ( :help :cl )
"   :cw         如果有错误列表，则打开quickfix窗口 ( :help :cw )
"   :col        到前一个旧的错误列表 ( :help :col )
"   :cnew       到后一个较新的错误列表 ( :help :cnew )

function ToggleQuickfix()           " ToggleQuickfix window
    " remember where we are 
    let winnr = winnr() 
    " find qf window, if any 
    let qfw = 0 
    windo if &l:buftype == "quickfix" | 
                \    let qfw = winnr() | endif 
    if qfw 
        " close qf window 
        cclose 
    else 
        " open qf window as last window, fullwidth 
        bot copen 
    endif 
    " go back to where we started from 
    if (winnr >= qfw) && (winnr > 1) 
        let winnr = winnr - 1 
    endif 
    exe winnr "wincmd w" 
endfunction 
command -nargs=0 -bar FF call ToggleQuickfix() 

function ShowError()
    execute ":Errors"
endfunction
command -nargs=0 -bar EE call ShowError() 

""**********************************************************""
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
hi colorcolumn guibg=darkblue
hi colorcolumn ctermbg=darkblue

let g:fullscreen = 0
function! ToggleFullscreen()
    if g:fullscreen == 1
        let g:fullscreen = 0
        let mod = "remove"
    else
        let g:fullscreen = 1
        let mod = "add"
    endif
    call system("wmctrl -ir " . v:windowid . " -b " . mod . ",fullscreen")
endfunction
map <silent> <F11> :call ToggleFullscreen()<CR>

let g:xptemplate_vars="$author=tlhc&$email=tongl@bjcarnation.com.cn"
""**********************************************************""
""**********************************************************""
""**********************************************************""
""**********************************************************""
""**********************************************************""
""**********************************************************""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => a.vim          " 头/源文件快速切换     " 不需要配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""头/源文件切换命令
"   ":A 头文件／源文件切换
"   ":AS 分割窗后并切换头/源文件(切割为上下两个窗口)
"   ":AV 垂直切割窗口后切换头/源文件(切割为左右两个窗口)
"   ":AT 新建Vim标签式窗口后切换
"   ":AN 在多个匹配文件间循环切换
""将光标所在处单词作为文件名打开
"   ":IH 切换至光标所在文件
"   ":IHS 分割窗口后切换至光标所在文件(指将光标所在处单词作为文件名打开)
"   ":IHV 垂直分割窗口后切换
"   ":IHT 新建标签式窗口后切换
"   ":IHN 在多个匹配文件间循环切换
""快捷键操作
"   "<Leader>ih 切换至光标所在文件*
"   "<Leader>is 切换至光标所在处(单词所指)文件的配对文件(如光标所在处为foo.h，则切换至foo.c/foo.cpp...)
"   "<Leader>ihn 在多个匹配文件间循环切换

let g:alternateSearchPath='sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:../../include'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree           " 以树状方式浏览系统中的文件和目录 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :ERDtree 打开NERD_tree
" :NERDtreeClose 关闭NERD_tree
" o 打开关闭文件或者目录 t 在标签页中打开  
" T 在后台标签页中打开 ! 执行此文件  
" p 到上层目录 P 到根目录  
" K 到第一个节点 J 到最后一个节点  
" u 打开上层目录 m 显示文件系统菜单（添加、删除、移动操作）  
" r 递归刷新当前目录 R 递归刷新当前根目录  

nmap <F3> :NERDTreeToggle<cr>       " 列出当前目录文件

if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g`\"" |
                \ endif
endif

autocmd vimenter * if !argc() | NERDTree | endif
"                       " 当打开vim且没有文件时自动打开NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"                       " 只剩 NERDTree时自动关闭
let NERDTreeIgnore=['cscope*','tags','*_bk*','review']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERD_commenter     " 代码注释
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [count],cc 光标以下count行逐行添加注释(7,cc)  
" [count],cu 光标以下count行逐行取消注释(7,cu)  
" [count],cm 光标以下count行尝试添加块注释(7,cm)  
" ,cA 在行尾插入 /* */,并且进入插入模式。 这个命令方便写注释。  
" **注**：count参数可选，无则默认为选中行或当前行  

let NERDSpaceDelims=1        " 让注释符与语句之间留一个空格  
let NERDCompactSexyComs=1    " 多行注释时样子更好看



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => bufexplorer        " Buffers切换
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" \be 全屏方式查看全部打开的文件列表  
" \bv 左右方式查看
" \bs 上下方式查看  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" => autocomplpop       " 自动补全插件，会自动弹出补全框   " 不需要配置  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" => indentLine            "    " 不需要配置  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" " => omincppcomplete    " C++自动补全插件  
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" "CTage配置需要  
" "--c++-kinds=+p : 为标签添加函数原型(prototype)信息  
" "--fields=+iaS : 为标签添加继承信息(inheritance)，访问控制(access)信息，函数特  
" "征(function Signature,如参数表或原型等)  
" "--extra=+q : 为类成员标签添加类标识  
 
" let OmniCpp_MayCompleteDot = 1      " autocomplete with .   
" let OmniCpp_MayCompleteArrow = 1    " autocomplete with ->   
" let OmniCpp_MayCompleteScope = 1    " autocomplete with ::   
" let OmniCpp_SelectFirstItem = 2     " select first item (but don't insert)   
" let OmniCpp_NamespaceSearch = 2     " search namespaces in this and included files   
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window   
" let OmniCpp_GlobalScopeSearch=1   
" let OmniCpp_DisplayMode=1   
" let OmniCpp_DefaultNamespaces=["android"]  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" => mark.vim           " 给各种tags标记不同的颜色
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" <C-\>m mark or unmark the word under (or before) the cursor  
" <C-\>r manually input a regular expression. 用于搜索.  
" <C-\>n clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .  
" <C-\>* 当前MarkWord的下一个
" <C-\># 当前MarkWord的上一个  
" <C-\>/ 所有MarkWords的下一个
" <C-\>? 所有MarkWords的上一个  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vcscommand.vim     " SVN/git管理工具   " 不需要配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => make one file        " 单个文件编译
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <F5> :call Do_OneFileMake()<CR>
" function Do_OneFileMake()
    " if expand("%:p:h")!=getcwd()
        " echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press <F7> to redirect to the dir of this file." | echohl None
        " return
    " endif
    " let sourcefileename=expand("%:t")
    " if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c"))
        " echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        " return
    " endif
    " let deletedspacefilename=substitute(sourcefileename,' ','','g')
    " if strlen(deletedspacefilename)!=strlen(sourcefileename)
        " echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
        " return
    " endif
    " if &filetype=="c"
        " if g:iswindows==1
            " set makeprg=gcc\ -o\ %<.exe\ %
        " else
            " set makeprg=gcc\ -o\ %<\ %
        " endif
    " elseif &filetype=="cpp"
        " if g:iswindows==1
            " set makeprg=g++\ -o\ %<.exe\ %
        " else
            " set makeprg=g++\ -o\ %<\ %
        " endif
        " "elseif &filetype=="cs"
        " "set makeprg=csc\ \/nologo\ \/out:%<.exe\ %
    " endif
    " if(g:iswindows==1)
        " let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'.exe','g')
        " let toexename=outfilename
    " else
        " let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'','g')
        " let toexename=outfilename
    " endif
    " if filereadable(outfilename)
        " if(g:iswindows==1)
            " let outdeletedsuccess=delete(getcwd()."\\".outfilename)
        " else
            " let outdeletedsuccess=delete("./".outfilename)
        " endif
        " if(outdeletedsuccess!=0)
            " set makeprg=make
            " echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
            " return
        " endif
    " endif
    " execute "silent make"
    " set makeprg=make
    " execute "normal :"
    " if filereadable(outfilename)
        " if(g:iswindows==1)
            " execute "!".toexename
        " else
            " execute "!./".toexename
        " endif
    " endif
    " execute "copen"
" endfunction
" """""""""""""""""""""""""""""""
" " => 进行make的设置
" """""""""""""""""""""""""""""""
" map <F6> :call Do_make()<CR>
" map <c-F6> :silent make clean<CR>
" function Do_make()
    " set makeprg=make
    " execute "silent make"
    " execute "copen"
" endfunction

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => General
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set clipboard+=unnamed  " 共享剪贴板
" set bufhidden=hide  
" set enc=utf-8               " 编码设置
" set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" set ruler           " 在编辑过程中，在右下角显示光标位置的状态行
" "set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
" set linespace=0         " 字符间插入的像素行数目
" set report=0            " 通过使用: commands命令，告诉我们文件的哪一行被改变过
" set scrolloff=5         " 光标移动到buffer的顶部和底部时保持5行距离
" set iskeyword+=_,$,@,%,#,-      " 带有如下符号的单词不要被换行分割
" set matchtime=5         " 短暂跳转到匹配括号的时间（单位是十分之一秒）



" """""""""""""""""""""""""""""""
" " => Files and backup
" """""""""""""""""""""""""""""""

" " set foldenable          " 开始折叠  
" " set foldmethod=syntax   " 设置语法折叠
" " set foldcolumn=0        " 设置折叠区域的宽度  
" " set foldlevel=1         " 设置折叠层数为  
" " set foldclose=all       " 设置为自动关闭折叠   
" set foldmethod=manual   " 手动折叠  

" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>  
" "           " 用空格键来开关折叠  

" set gdefault            "行内替换
" set smartcase
" " set nowrapscan          " 禁止在搜索到文件两端时重新搜索  

nmap <leader>tt :%s/\t/    /g<CR>
" "           "将tab替换为空格

















