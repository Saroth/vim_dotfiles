" Description: Scheme: Clear Black. For Vim & NeoVim, GUI & Term
"      ___  _                       ___   _              _
"    / __// /   __   _   __ _      / _ \/ /   _    ___ / /_
"   / /  / /  / _ \/  \ /  _/     /  __/ /  /  \ / __//  _/
"  / /_ / /__/  __/ / // /       / _  / /__/ / // /_ /  \
"  \___/____/\___/\___/_/       /____/____/\___/\___/_/\_/

" ____{ prepare

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set background=dark
" set background=light

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "clearblack"

" }_____________________________________________________________________________
" ____{ UI colors define
" 全局默认定义  ==== Global default setting ====
hi Normal       guifg=#ffffff guibg=#262626             ctermfg=231 ctermbg=235

" 特殊字符
hi SpecialKey   guifg=#606060                           ctermfg=241

" 文本里实际不存在的字符: '~','@','<',...
hi NonText      gui=bold guifg=#444444                  cterm=bold ctermfg=238

" 目录名 (还有列表里的其它特殊名字)
hi Directory    gui=bold guifg=#ffdf5f                  cterm=bold ctermfg=221

" 命令行上的错误信息
hi ErrorMsg     guibg=#ff0000                           ctermbg=196

" incsearch高亮
hi IncSearch    guifg=#000000 guibg=#878700             ctermfg=16 ctermbg=100
" 最近搜索模式的高亮 (见 'hlsearch')。
"               也用于 quickfix 当前行的高亮和其它类似的要突出显示的项目
hi Search       guifg=#000000 guibg=#dfdf5f             ctermfg=16 ctermbg=185

" |more-prompt|
hi MoreMsg      gui=bold guifg=#808080                  cterm=bold ctermfg=244

" 'showmode' 消息 (例如，"-- INSERT --")
hi ModeMsg      gui=bold                                cterm=bold

" ":number" 和 ":#" 命令与置位 'number' 选项时的行号
hi LineNr       guifg=#444444 guibg=#121212             ctermfg=238 ctermbg=233

" |hit-enter| 提示和 yes/no 问题
hi Question     gui=bold guifg=#00af00                  cterm=bold ctermfg=34

" 当前窗口的状态行
hi StatusLine   gui=bold,underline guifg=#9e9e9e guibg=#000000  cterm=bold,underline ctermfg=247 ctermbg=16
" 非当前窗口的状态行
hi StatusLineNC gui=none guifg=#606060 guibg=#000000    cterm=none ctermfg=241 ctermbg=16
" 分离垂直分割窗口的列
hi VertSplit    gui=none guifg=#000000 guibg=#000000    cterm=none ctermfg=16 ctermbg=16

" ":set all"、":autocmd" 等输出的标题
hi Title        gui=bold guifg=#E0A0A0                  cterm=bold ctermfg=217

" 可视模式的选择区
hi Visual       gui=underline guibg=#000000             cterm=underline ctermbg=16
" Vim 是 "选择区的非拥有者" 时，可视模式的选择区。
"               只有 X11 GUI 的 |gui-x11| 和 |xterm-clipboard| 才提供此支持
hi VisualNOS    gui=bold,underline                      cterm=bold,underline

" 警告消息
hi WarningMsg   guifg=#ff0000                           ctermfg=196

" 命令行补全的匹配项高亮
hi WildMenu     gui=bold guifg=#d0d0d0 guibg=#008700    cterm=bold ctermfg=252 ctermbg=28

" 折叠的行
hi Folded       guifg=#808080 guibg=#1c1c1c             ctermfg=244 ctermbg=234
" 折叠标记列
hi FoldColumn   guifg=#808080 guibg=#1c1c1c             ctermfg=244 ctermbg=234

" diff 模式: 增加的行
hi DiffAdd      guibg=#444444                           ctermbg=238
" diff 模式: 改变的行
hi DiffChange   guibg=#303030                           ctermbg=236
" diff 模式: 删除的行
hi DiffDelete   guifg=#3a3a3a guibg=#121212             ctermfg=237 ctermbg=233
" diff 模式: 改变行里的改动文本
hi DiffText     guibg=#5f0000                           ctermbg=52

" 显示标签的列
hi SignColumn   guifg=#005f00  guibg=#121212            ctermfg=22 ctermbg=233
hi SpellBad     gui=undercurl   guisp=Red               cterm=undercurl
hi SpellCap     gui=undercurl   guisp=Blue              cterm=undercurl
hi SpellRare    gui=undercurl   guisp=Magenta           cterm=undercurl
hi SpellLocal   gui=undercurl   guisp=DarkCyan          cterm=undercurl

" 菜单
hi Pmenu        guibg=#303030 guifg=#d0d0d0             ctermbg=236 ctermfg=252
" 菜单选中项
hi PmenuSel     guibg=#606060 guifg=#ffffff             ctermbg=241 ctermfg=231
" 菜单滚动条
hi PmenuSbar    guibg=#444444                           ctermbg=238
" 菜单滚动条滑块
hi PmenuThumb   guibg=#808080                           ctermbg=244

hi TabLine      gui=underline guibg=#606060             ctermbg=59 cterm=underline
hi TabLineSel   gui=bold                                cterm=bold
hi TabLineFill  gui=reverse                             cterm=reverse

" 光标所在列
hi CursorColumn guibg=#606060                           ctermbg=241
" 光标所在行
hi CursorLine   guibg=#606060                           ctermbg=241
" 光标所在的字符
hi Cursor       guifg=#000000 guibg=#eeeeee             ctermfg=16 ctermbg=255
hi lCursor      guifg=#000000 guibg=#b2b2b2

" 匹配的括号
hi MatchParen   gui=bold,underline guifg=#ffaf00 guibg=bg cterm=bold,underline ctermfg=214 ctermbg=bg

" 右边界线
hi ColorColumn  guibg=#303030                           ctermbg=236


" }_____________________________________________________________________________
" ____{ variables colors define

" 任何注释
hi Comment      guifg=#808080                           ctermfg=244

" 任何常量 如: NULL
hi Constant     gui=bold guifg=#00af00                  cterm=bold ctermfg=34
" 字符
hi Character    guifg=#df8700                           ctermfg=172
" 字符串
hi String       guifg=#dfaf5f guibg=#303030             ctermfg=179 ctermbg=236
" 数字
hi Number       guifg=#af5f00                           ctermfg=130
hi Boolean      gui=bold guifg=#df5f00                  cterm=bold ctermfg=166
hi Float        guifg=#af5f00                           ctermfg=130

" 任何变量
hi Identifier   guifg=#00afff                           ctermfg=39
" 函数、类方法
hi Function     gui=bold guifg=#87df87                  cterm=bold ctermfg=114

" 任何关键字  break ...
hi Statement    guifg=#af0000                           ctermfg=124
" if, then, else, endif, switch, etc., ...
hi Conditional  guifg=#af0000                           ctermfg=124
" for, do, while, etc., ...
hi Repeat       guifg=#af0000                           ctermfg=124
" case, default, etc., ...
hi Label        guifg=#af0000                           ctermfg=124
" "sizeof", "+", "*", etc., ...
hi Operator     guifg=#808080                           ctermfg=244
" any other keyword
hi Keyword      guifg=#df0000                           ctermfg=160
" try, catch, throw, ...
hi Exception    guifg=#df0000                           ctermfg=160

" 通用预处理命令
hi PreProc      guifg=#af5f5f                           ctermfg=131
" #include
hi Include      guifg=#9e9e9e                           ctermfg=247
" 
hi Define       guifg=#af5f5f                           ctermfg=131
" #define
hi Macro        guifg=#df5f5f                           ctermfg=167
" #if, #else, #endif ...
hi PerCondit    guifg=#af5f5f                           ctermfg=131

" 类型 int, long, char ...
hi Type         guifg=#5faf5f                           ctermfg=71
" static, register, volatile const .
hi StorageClass guifg=#af5f5f                           ctermfg=131
" struct, union, enum ...
hi Structure    gui=bold,underline guifg=#5faf5f        cterm=bold,underline ctermfg=71
" typedef
hi Typedef      guifg=#5faf5f                           ctermfg=71

" 特殊符号
hi Special      guifg=#606060                           ctermfg=241
" 字符串中的特殊字符
hi SpecialChar  guifg=#ffff87 guibg=#303030             ctermfg=228 ctermbg=236
" 有效链接
hi Tag          guifg=#00df00                           ctermfg=40
" 需要注意的字符
hi Delimiter    guifg=#808080                           ctermfg=8
" 注释里的特殊字符
hi SpecialComment   guifg=#afaf5f                       ctermfg=143

" 文本突出显示, HTML链接
hi Underlined   gui=underline guifg=#00afff             cterm=underline ctermfg=39

" 留空，被隐藏
hi Ignore       guifg=#3a3a3a                           ctermfg=237

" 任何有错的构造 如关键字 FIXME DISABLE
hi Error        guifg=White guibg=Red                   ctermfg=15 ctermbg=9
" 任何需要特殊注意的部分；关键字 TODO WARN XXX NOTE
hi Todo         guifg=Blue guibg=Yellow                 ctermfg=12 ctermbg=11

" }_____________________________________________________________________________

