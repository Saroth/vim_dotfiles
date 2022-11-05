" Description: Scheme: Clear Black. For Vim & NeoVim, GUI & Term
"      ___  _                        __   _              _
"    / __// /   __   _    _ _      / _ \/ /   _    ___ / /_
"   / /  / /  / _ \/  \ / /_/     /  __/ /  /  \ / __//  _/
"  / /_ / /__/  __/ O // /       / _  / /__/ O // /_ /  \_
"  \___/____/\___/\___/_/       /____/____/\___/\___/_/\_/

" { Init
hi clear
set background=dark
let g:colors_name = "clearblack"

if exists("syntax_on")
  syntax reset
endif

let s:background = v:null " 通用背景色
let s:emphasis = v:null " 通用字体格式
function! s:HL(group, fg, ...)
    let bg = s:background is v:null ? s:none : s:background
    if a:0 > 0
        let bg = a:1
    endif
    let em = s:emphasis is v:null ? s:emphasis_none : s:emphasis
    if a:0 > 1 && strlen(a:2)
        let em = a:2
    endif
    let hi_cfg = [ 'highlight', a:group,
                \'guifg=' . a:fg[0], 'ctermfg=' . a:fg[1],
                \'guibg=' . bg[0], 'ctermbg=' . bg[1],
                \'gui=' . em, 'cterm=' . em]
    let hi_str = join(hi_cfg, ' ')
    " echo hi_str
    execute hi_str
endfunction

let s:none = ['NONE', 'NONE']
let s:emphasis_none = 'NONE,'

let s:white = ['#ffffff', 15]
let s:lightgray1 = ['#c0c0c0', 7]
let s:lightgray0 = ['#a8a8a8', 248]
let s:gray = ['#808080', 8]
let s:darkgray0 = ['#606060', 241]
let s:darkgray1 = ['#444444', 238]
let s:darkgray2 = ['#303030', 236]
let s:darkgray3 = ['#262626', 235]
let s:darkgray4 = ['#121212', 233]
let s:black = ['#000000', 0]

let s:red = ['#ff0000', 196]
let s:darkred0 = ['#5f0000', 52]
let s:gold = ['#ffdf00', 220]
let s:orange2 = ['#dfaf5f', 179]
let s:orange3 = ['#dfdf5f', 191]
let s:orange4 = ['#df5f00', 166]
let s:green = ['#00ff00', 46]
let s:green1 = ['#00df00', 40]
let s:darkgreen0 = ['#00af00', 34]
let s:green3 = ['#008700', 28]
let s:green4 = ['#005f00', 22]
let s:cyan0 = ['#00ffff', 51]
let s:cyan1 = ['#00dfff', 45]
let s:cyan2 = ['#00afff', 39]
let s:cyan3 = ['#0087ff', 33]
let s:cyan4 = ['#005fff', 27]

call s:HL('Normal', s:white, s:darkgray3) " 全局
" }
" { Window border
let s:background = s:black
let s:emphasis = 'bold,underline'
" 状态行元素高亮
call s:HL('User1', s:red)
call s:HL('User2', s:darkgreen0)
call s:HL('StatusLine', s:lightgray1) " 当前窗口的状态行
let s:emphasis = v:null
call s:HL('StatusLineNC', s:darkgray1) " 非当前窗口的状态行
call s:HL('VertSplit', s:black) " 窗口左右分割列
call s:HL('TabLineFill', s:darkgray1, s:black, 'underline') " Tab行背景
call s:HL('TabLine', s:darkgray1, s:darkgray4, 'underline') " 其他Tab标签
call s:HL('TabLineSel', s:lightgray1, s:none, 'bold') " 当前Tab标签
" }
" { Columns & Lines
let s:background = s:darkgray4
call s:HL('ColorColumn', s:none) " 右边界线
call s:HL('LineNr', s:darkgray1) " 行号列, 编辑窗口或命令行. 查看命令:number, :#
call s:HL('CursorLineNr', s:lightgray1) " 光标所在行的行号
call s:HL('SignColumn', s:gray) " 标签列
call s:HL('Folded', s:gray) " 折叠行
call s:HL('FoldColumn', s:gray) " 折叠标记列
let s:background = v:null
" }
" { Search
call s:HL('Search', s:black, s:gold) " 搜索匹配高亮. 见:hlsearch
hi! link IncSearch Search
call s:HL('MatchParen', s:black, s:gold) " 匹配的括号对
" }
" { Menu
call s:HL('Pmenu', s:lightgray1, s:darkgray2) " 菜单
call s:HL('PmenuSel', s:white, s:darkgray0) " 菜单选中项
call s:HL('PmenuSbar', s:none, s:darkgray1) " 菜单滚动条
call s:HL('PmenuThumb', s:none, s:gray) " 菜单滚动条滑块
call s:HL('WildMenu', s:lightgray1, s:green3, 'bold') " 命令行补全的匹配项(deprecated)
" }
" { Message
call s:HL('Title', s:darkgreen0, s:none, 'bold') " :set all, :autocmd 等输出的标题
call s:HL('WarningMsg', s:orange4) " 警告信息
call s:HL('ErrorMsg', s:red) " 错误信息
call s:HL('ModeMsg', s:none, s:none, 'bold') " 模式信息. 如: -- INSERT --
call s:HL('MoreMsg', s:gray, s:none, 'bold') " |more-prompt|
call s:HL('Question', s:darkgreen0, s:none, 'bold') " |hit-enter| 提示和 yes/no 问题
" }
" { Diff
call s:HL('DiffAdd', s:none, s:darkgray1) " 增加的行
call s:HL('DiffChange', s:none, s:darkgray2) " 差异的行
call s:HL('DiffDelete', s:darkgray2, s:darkgray4) " 删除的行
call s:HL('DiffText', s:none, s:darkred0) " 差异行里的差异内容
" }
" { Cursor
call s:HL('Cursor', s:black, s:green) " 光标
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
call s:HL('CursorLine', s:none) " 光标所在行
call s:HL('CursorColumn', s:none) " 光标所在列
call s:HL('Visual', s:none, s:black, 'underline') " 可视模式的选择区
" }
" { Character & Symbol
call s:HL('NonText', s:darkgray1) " 文本里实际不存在的字符: '~','@','<',...
call s:HL('SpecialKey', s:darkgray0) " 特殊字符

call s:HL('Boolean', s:orange4, s:none, 'bold') " 二值. true/false
call s:HL('Boolean', s:orange4) " 数值
hi! link Float Boolean
call s:HL('Character', s:orange3) " 字符
call s:HL('String', s:orange2, s:darkgray2) " 字符串

call s:HL('Type', s:orange2) " 类型 int, long, char ...
" " static, register, volatile const .
" hi StorageClass guifg=#af5f5f                           ctermfg=131
" " struct, union, enum ...
" hi Structure    gui=bold,underline guifg=#5faf5f        cterm=bold,underline ctermfg=71
" " typedef
" hi Typedef      guifg=#5faf5f                           ctermfg=71

call s:HL('Comment', s:gray) " 注释
call s:HL('Constant', s:darkgreen0, s:none, 'bold') " 常量. 如: NULL, __FILE__
" " 任何变量
" hi Identifier   guifg=#00afff                           ctermfg=39
" " 函数、类方法
" hi Function     gui=bold guifg=#87df87                  cterm=bold ctermfg=114
" " 任何关键字  break ...
" hi Statement    guifg=#af0000                           ctermfg=124
" " if, then, else, endif, switch, etc., ...
" hi Conditional  guifg=#af0000                           ctermfg=124
" " for, do, while, etc., ...
" hi Repeat       guifg=#af0000                           ctermfg=124
" " case, default, etc., ...
" hi Label        guifg=#af0000                           ctermfg=124
" " "sizeof", "+", "*", etc., ...
" hi Operator     guifg=#808080                           ctermfg=244
" " any other keyword
" hi Keyword      guifg=#df0000                           ctermfg=160
" " try, catch, throw, ...
" hi Exception    guifg=#df0000                           ctermfg=160
"
" " 通用预处理命令
" hi PreProc      guifg=#af5f5f                           ctermfg=131
" " #include
" hi Include      guifg=#9e9e9e                           ctermfg=247
" " 
" hi Define       guifg=#af5f5f                           ctermfg=131
" " #define
" hi Macro        guifg=#df5f5f                           ctermfg=167
" " #if, #else, #endif ...
" hi PerCondit    guifg=#af5f5f                           ctermfg=131
"
" " 特殊符号
" hi Special      guifg=#606060                           ctermfg=241
" " 字符串中的特殊字符
" hi SpecialChar  guifg=#ffff87 guibg=#303030             ctermfg=228 ctermbg=236
" " 有效链接
" hi Tag          guifg=#00df00                           ctermfg=40
" " 需要注意的字符
" hi Delimiter    guifg=#808080                           ctermfg=8
" " 注释里的特殊字符
" hi SpecialComment   guifg=#afaf5f                       ctermfg=143
"
" " 文本突出显示, HTML链接
" hi Underlined   gui=underline guifg=#00afff             cterm=underline ctermfg=39
" " 留空，被隐藏
" hi Ignore       guifg=#3a3a3a                           ctermfg=237
" " 任何有错的构造 如关键字 FIXME DISABLE
" hi Error        guifg=White guibg=Red                   ctermfg=15 ctermbg=9
" " 任何需要特殊注意的部分；关键字 TODO WARN XXX NOTE
" hi Todo         guifg=Blue guibg=Yellow                 ctermfg=12 ctermbg=11
" }

" " 目录名 (还有列表里的其它特殊名字)
" hi Directory    gui=bold guifg=#ffdf5f                  cterm=bold ctermfg=221

" hi SpellBad     gui=undercurl   guisp=Red               cterm=undercurl
" hi SpellCap     gui=undercurl   guisp=Blue              cterm=undercurl
" hi SpellRare    gui=undercurl   guisp=Magenta           cterm=undercurl
" hi SpellLocal   gui=undercurl   guisp=DarkCyan          cterm=undercurl

