" Description: Basic configurations

" { View
  set nocompatible " 不兼容模式. For Vim only
  set lazyredraw " 当运行宏时不重绘, 提高宏执行效率
  set number " 显示行号
  set nowrap " 超出显示空间时不换行
  set list " 显示不可见字符
  set listchars=eol:~,tab:>\ ,precedes:<,extends:>,nbsp:% ",trail:. 不可见字符样式

  colorscheme clearblack " 配色方案
  set hlsearch " 匹配内容高亮显示
  set nocursorline " 不高亮显示当前行. 会覆盖折叠行高亮
  set nocursorcolumn " 不高亮显示当前列
  set termguicolors " 终端界面开启真彩
  set matchpairs=(:),[:],{:} " 高亮显示匹配括号
" }
" { Window
  set noequalalways " 分割或关闭窗口时, 不自动等分
  set splitbelow " 水平分割后, 光标在下面窗口
  set splitright " 垂直分割后, 光标在右边窗口
  set scrolloff=4 " 距离上下边缘小于行数时自动滚动
  set sidescrolloff=8 " 距离左右边缘小于列数时自动滚动
  set sidescroll=8 " 左右自动滚动的列数
  set winminheight=1 " 强制窗口最小高度
  set winminwidth=2 " 强制窗口最小宽度
  set winheight=9 " 当前窗口自动高度
" }
" { Status line
  set laststatus=2 " 总是显示状态栏
  let slWinType       = '%q' " 窗口类型. 如: [Quickfix List], [Location List]
  let slFileName      = '%f' " 文件名
  let slFileStatus    = '%1*%w%h%r%m%*' " 文件状态. [Preview][Help][RO][-]. 高亮User2
  let slFileType      = '%y' " 文件类型
  let slFileEncoding  = ' %{(&fenc == ""?&enc:&fenc).(&bomb?",BOM":"")}' " 文件编码
  let slFileFormat    = ' %{&fileformat}' " 文件格式. dos/unix/mac
  let slFilePosition  = ' %2*%l/%L,%v-0x%02B%*' " 光标信息. 高亮User4
  " 超出可显空间时, 文件信息左侧截断
  let slString        = '%<'.slWinType.slFileName.slFileStatus
        \.' %='.slFileType.slFileEncoding.slFilePosition
  set statusline=%!slString
" }
" { Encoding
  filetype on " 启用文件类型侦测
  filetype plugin on " 针对不同的文件类型加载对应的插件
  filetype plugin indent on " 启用缩进
  set encoding=utf-8 " 设置内部编码
  set fileencoding=utf-8 " 设置默认文件编码
  " 设置支持打开的文件的编码
  set fileencodings=ucs-bom,utf-8,
        \gbk,cp936,gb2312,gb18030,
        \bug5,eucjp,euc-kr,latin-1,chinese
  set fileformat=unix " 设置新文件的<EOL>格式
  language messages en_US.UTF-8 " 设置语言. 统一使用英文, 避免混乱
" }
" { Indent
  set nosmartindent " 智能对齐
  set autoindent " 自动缩进
  set expandtab " 扩展制表符. 将输入的Tab替换为空格. 其他方式输入制表符: <c-v><c-i>
  set tabstop=4 " Tab字符显示宽度
  set shiftwidth=4 " 每次按Tab缩进的宽度
  set smarttab " 按backspace智能删除shiftwidth宽度的空格
  set cindent shiftwidth=4 " 设置C语言Tab长度为4个空格
  set cinoptions=l1,g0 " 设置C语言缩进规则(参考help手册)
" }
" { Edit
  set mouse= " 不使用鼠标. 方便在终端复制文字
  set nohidden " 未保存文件不允许切换缓冲区, 确保编辑结果正确写入
  set linebreak " 整词换行. 需要textwidth>0. 手动执行换行: gq
  " 设置<c-a>递增和<c-x>递减时, 支持的字符格式
  "       alpha: 字母
  "       hex: '0x'开头的16进制数值
  "       octal: '0'开头的8进制数值
  "       bin: '0b'开头的2进制数值
  "       unsigned: 无符号数值(负号在数字中间的数值). 如:
  "                   '2020-01' <c-a> '2020-02'
  set nrformats=hex,octal,bin,unsigned
  set incsearch " 即时搜索, 并自动跳转到光标后的第一个匹配项
  set ignorecase " 搜索忽略大小写
  set smartcase " 有一个或以上大写字母时仍保持对大小写敏感
  if has('nvim') " For Neovim only
    set inccommand=split " 即时预览替换命令的效果
  endif

  set foldenable " 启用折叠
  set foldcolumn=0 " 折叠标识列宽度
  set foldlevel=99 " 设置初始的折叠级别
  set foldmethod=marker foldmarker={,} " 设置代码折叠模式
  " 自动格式化选项
  "   j:  合并多行注释时自动移除注释符
  "   c:  注释内容长度超出textwidth时，自动换行并添加注释符
  "   r:  在注释行按Enter换行时，自动添加注释符
  "   o:  在注释行按o换行时，自动添加注释符
  "   q:  允许gq自动格式化注释
  "   l:  编辑长度超出textwidth的注释，不自动换行
  set formatoptions=jcrql
" }
" { Completion. Based on Ctag. Deprecated.
  " " 设置自动补全提示内容的获取范围
  " " i:    搜索包含, include文件较多时速度极慢. 使用<c-x><c-i>搜索include
  " " t:    搜索tags，tags文件较大时速度较慢. 使用<c-x><c-]>搜索tags
  " set complete=.,w,b,u,U,k,s
  " " 设置补全选项
  " "       menuone:  总是弹出补全项菜单
  " "       longest:  使用最常用的候选项
  " "       preview:  弹出补全项的详细信息窗口
  " set completeopt=menuone,longest
  " " 设置补全信息预览窗口高度
  " set previewheight=9
  " " 锁定补全信息预览窗口高度
  " " set winfixheight
  " " show tag with function protype.
  " set showfulltag
" }

