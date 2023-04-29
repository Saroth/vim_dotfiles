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
"""
" 通用高亮设置
" group:  高亮组名称
" fg      前景色
" a:1     背景色. 默认使用Normal配置, 若有设置s:background则使用设置
" a:2     突出显示. 默认无, 若有设置s:emphasis则使用设置
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

let s:lightred1 = ['#df5f5f', 203]
let s:lightred0 = ['#af5f5f', 167]
let s:red = ['#ff0000', 196]
let s:darkred0 = ['#df0000', 160]
let s:darkred1 = ['#af0000', 124]
let s:darkred2 = ['#5f0000', 52]
let s:lightyellow = ['#ffff87', 228]
let s:yellow = ['#ffff00', 11]
let s:gold = ['#ffdf00', 220]
let s:wheat0 = ['#dfaf5f', 179]
let s:wheat1 = ['#df8700', 172]
let s:wheat2 = ['#af5f00', 130]
let s:orange = ['#df5f00', 166]
let s:lightgreen1 = ['#87df87', 114]
let s:lightgreen0 = ['#5faf5f', 71]
let s:green = ['#00ff00', 46]
let s:darkgreen = ['#00af00', 34]
let s:deepblue = ['#00dfff', 45]
let s:blue = ['#005fdf', 26]
" }
" { Window
call s:HL('Normal', s:white, s:darkgray3) " 普通文字
call s:HL('NormalFloat', s:white, s:darkgray3) " 浮动窗口中的文字
call s:HL('NormalNC', s:lightgray1, s:darkgray3) " 非当前窗口中的文字
call s:HL('Pmenu', s:lightgray1, s:darkgray2) " 菜单
call s:HL('PmenuSel', s:white, s:darkgray0) " 菜单选中项
call s:HL('PmenuSbar', s:none, s:darkgray1) " 菜单滚动条
call s:HL('PmenuThumb', s:none, s:gray) " 菜单滚动条滑块
call s:HL('WildMenu', s:lightgray1, s:darkgreen, 'bold') " 命令行补全的匹配项(deprecated)
call s:HL('WinBar', s:lightgray1, s:none, 'bold') " 当前窗口
call s:HL('WinBarNC', s:darkgray1, s:darkgray4, 'underline') " 非当前窗口
call s:HL('FloatBorder', s:white, s:darkgray3) " 悬浮窗口边框
" }
" { Border
let s:background = s:black
let s:emphasis = 'bold,underline'
" 状态行元素高亮
call s:HL('User1', s:red)
call s:HL('User2', s:darkgreen)
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
call s:HL('Search', s:black, s:gold) " 匹配项
call s:HL('CurSearch', s:black, s:orange) " 光标下的匹配项
hi! link IncSearch Search
hi! link Substitute Search
call s:HL('MatchParen', s:gold, s:none, 'bold,underline') " 匹配的括号对
" }
" { Message
call s:HL('Directory', s:wheat0, s:none, 'bold') " 目录名和列表里其它特殊名字
call s:HL('Title', s:darkgreen, s:none, 'bold') " :set all, :autocmd 等输出的标题
call s:HL('WarningMsg', s:orange) " 警告信息
call s:HL('ErrorMsg', s:red) " 错误信息
call s:HL('ModeMsg', s:none, s:none, 'bold') " 模式信息. 如: -- INSERT --
call s:HL('MoreMsg', s:gray, s:none, 'bold') " |more-prompt|
call s:HL('Question', s:darkgreen, s:none, 'bold') " |hit-enter| 提示和 yes/no 问题
" }
" { Diff
call s:HL('DiffAdd', s:none, s:darkgray1) " 增加的行
call s:HL('DiffChange', s:none, s:darkgray2) " 差异的行
call s:HL('DiffDelete', s:darkgray2, s:darkgray4) " 删除的行
call s:HL('DiffText', s:none, s:darkred2) " 差异行里的差异内容
" }
" { Cursor
call s:HL('Cursor', s:black, s:green) " 光标
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
call s:HL('CursorLine', s:none) " 光标所在行
call s:HL('CursorColumn', s:none) " 光标所在列
call s:HL('Visual', s:white, s:blue) " 可视模式的选择区
" }
" { Character
call s:HL('NonText', s:darkgray1) " 文本里实际不存在的字符: '~','@','<',...
call s:HL('SpecialKey', s:darkgray0) " 不可显ASCII字符
" }
" { Symbol. 参考:|group-name|
call s:HL('Comment', s:gray) " 注释

call s:HL('Constant', s:darkgreen, s:none, 'bold') " 常量. 如: NULL, __FILE__
call s:HL('String', s:wheat0, s:darkgray2) " 字符串
call s:HL('Character', s:wheat1) " 字符: '\n'
call s:HL('Number', s:wheat2) " 数值
call s:HL('Boolean', s:wheat1, s:none, 'bold') " 二值. TRUE, false
call s:HL('Float', s:wheat1) " 浮点数

call s:HL('Identifier', s:deepblue) " 任何变量
call s:HL('Function', s:lightgreen1, s:none, 'bold') " 函数, 方法

call s:HL('Statement', s:darkred1) " 关键字
call s:HL('Conditional', s:darkred0) " if, then, else, endif, switch, etc.
call s:HL('Repeat', s:darkred0) " for, do, while, etc.
call s:HL('Label', s:darkred0) " case, default, etc.
call s:HL('Operator', s:lightgray0) " sizeof, +, *, etc.
call s:HL('Keyword', s:darkred1) " any other keyword
call s:HL('Exception', s:darkred0) " try, catch, throw

call s:HL('PreProc', s:lightred0) " 通用预处理
call s:HL('Include', s:lightgray0) " #include
call s:HL('Define', s:lightred1) " #define
call s:HL('Macro', s:lightred1) " 同Define
call s:HL('PerCondit', s:lightred0) " #if, #else, #endif, etc.

call s:HL('Type', s:lightgreen0) " 通用类型 int, long, char ...
call s:HL('StorageClass', s:lightred0) " static, register, volatile const ...
call s:HL('Structure', s:lightgreen0) " struct, union, enum ...
call s:HL('Typedef', s:lightgreen0, s:none, 'bold') " typedef

call s:HL('Special', s:gray) " 通用特殊符号
call s:HL('SpecialChar', s:lightyellow, s:darkgray2) " 常量中的特殊字符
call s:HL('Tag', s:deepblue) " 可ctrl-]跳转的符号
call s:HL('Delimiter', s:lightgray0) " 需要关注的字符
call s:HL('SpecialComment', s:lightred0) " 注释中的特殊字符
call s:HL('Debug', s:gray) " 调试语句

call s:HL('Underlined', s:deepblue, s:none, 'underline') " 突出显示. 如HTML链接
call s:HL('Ignore', s:darkgray1) " 忽略内容
call s:HL('Error', s:white, s:red) " 错误标注. 如: DISABLE
call s:HL('Todo', s:black, s:yellow) " 关键说明标注. 如: TODO FIXME XXX
" }
" { Plugins
" Nvim-Tree

" Default linked group follows name.

" NvimTreeSymlink
" NvimTreeSymlinkFolderName   (Directory)
" NvimTreeFolderName          (Directory)
" NvimTreeRootFolder
" NvimTreeFolderIcon
" NvimTreeOpenedFolderIcon    (NvimTreeFolderIcon)
" NvimTreeClosedFolderIcon    (NvimTreeFolderIcon)
" NvimTreeFileIcon
" NvimTreeEmptyFolderName     (Directory)
" NvimTreeOpenedFolderName    (Directory)
" NvimTreeExecFile
" NvimTreeOpenedFile
" NvimTreeModifiedFile
call s:HL('NvimTreeSpecialFile', s:darkgreen, s:none, 'bold,underline') " 特殊文件
" NvimTreeImageFile
" NvimTreeIndentMarker

" NvimTreeLspDiagnosticsError         (DiagnosticError)
" NvimTreeLspDiagnosticsWarning       (DiagnosticWarn)
" NvimTreeLspDiagnosticsInformation   (DiagnosticInfo)
" NvimTreeLspDiagnosticsHint          (DiagnosticHint)

" NvimTreeGitDirty
" NvimTreeGitStaged
" NvimTreeGitMerge
" NvimTreeGitRenamed
" NvimTreeGitNew
" NvimTreeGitDeleted
" NvimTreeGitIgnored      (Comment)

call s:HL('NvimTreeWindowPicker', s:white, s:darkgreen, 'bold') " 窗口选择器
call s:HL('NvimTreeNormal', s:lightgray1, s:darkgray3) " 默认配色

" There are also links for file highlight with git properties, linked to their
" Git equivalent:

" NvimTreeFileDirty       (NvimTreeGitDirty)
" NvimTreeFileStaged      (NvimTreeGitStaged)
" NvimTreeFileMerge       (NvimTreeGitMerge)
" NvimTreeFileRenamed     (NvimTreeGitRenamed)
" NvimTreeFileNew         (NvimTreeGitNew)
" NvimTreeFileDeleted     (NvimTreeGitDeleted)
" NvimTreeFileIgnored     (NvimTreeGitIgnored)

" There are 2 highlight groups for the live filter feature

" NvimTreeLiveFilterPrefix
" NvimTreeLiveFilterValue

" Color of the bookmark icon

" NvimTreeBookmark

" }

