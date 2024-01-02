" Description: Scheme: Clear Black. For Vim & NeoVim, GUI & Term
"      ___  _                        __   _              _
"    / __// /   __   _    _ _      / _ \/ /   _    ___ / /_
"   / /  / /  / _ \/  \ / /_/     /  __/ /  /  \ / __//  _/
"  / /_ / /__/  __/ O // /       / _  / /__/ O // /_ /  \_
"  \___/____/\___/\___/_/       /____/____/\___/\___/_/\_/

call theme#init("clearblack", "dark")
" { Window
call theme#hl('Normal', g:theme_white, g:theme_darkgray3) " 普通文字
call theme#hl('NormalFloat', g:theme_white, g:theme_darkgray3) " 浮动窗口中的文字
call theme#hl('NormalNC', g:theme_lightgray1, g:theme_darkgray3) " 非当前窗口中的文字
call theme#hl('Pmenu', g:theme_lightgray1, g:theme_darkgray1) " 菜单
call theme#hl('PmenuSel', g:theme_white, g:theme_darkgray0) " 菜单选中项
call theme#hl('PmenuSbar', g:theme_none, g:theme_darkgray1) " 菜单滚动条
call theme#hl('PmenuThumb', g:theme_none, g:theme_gray) " 菜单滚动条滑块
call theme#hl('WildMenu', g:theme_lightgray1, g:theme_darkgreen, 'bold') " 命令行补全的匹配项(deprecated)
call theme#hl('WinBar', g:theme_lightgray1, g:theme_none, 'bold') " 当前窗口
call theme#hl('WinBarNC', g:theme_darkgray1, g:theme_darkgray4, 'underline') " 非当前窗口
call theme#hl('FloatBorder', g:theme_white, g:theme_darkgray3) " 悬浮窗口边框
" }
" { Border
call theme#set_general(g:theme_black, 'bold,underline')
" 状态行元素高亮
call theme#hl('User1', g:theme_red)
call theme#hl('User2', g:theme_darkgreen)
call theme#hl('StatusLine', g:theme_lightgray1) " 当前窗口的状态行
call theme#set_general(g:theme_black)
call theme#hl('StatusLineNC', g:theme_darkgray1) " 非当前窗口的状态行
call theme#hl('VertSplit', g:theme_black) " 窗口左右分割列
call theme#hl('TabLineFill', g:theme_darkgray1, g:theme_black, 'underline') " Tab行背景
call theme#hl('TabLine', g:theme_darkgray1, g:theme_darkgray4, 'underline') " 其他Tab标签
call theme#hl('TabLineSel', g:theme_lightgray1, g:theme_none, 'bold') " 当前Tab标签
call theme#set_general()
" }
" { Columns & Lines
call theme#set_general(g:theme_darkgray4)
call theme#hl('ColorColumn', g:theme_none) " 右边界线
call theme#hl('LineNr', g:theme_darkgray1) " 行号列, 编辑窗口或命令行. 查看命令:number, :#
call theme#hl('CursorLineNr', g:theme_lightgray1) " 光标所在行的行号
call theme#hl('SignColumn', g:theme_gray) " 标签列
call theme#hl('Folded', g:theme_gray) " 折叠行
call theme#hl('FoldColumn', g:theme_gray) " 折叠标记列
call theme#set_general()
" }
" { Search
call theme#hl('Search', g:theme_black, g:theme_gold) " 匹配项
call theme#hl('CurSearch', g:theme_black, g:theme_purple) " 光标下的匹配项
hi! link IncSearch Search
hi! link Substitute Search
call theme#hl('MatchParen', g:theme_gold, g:theme_none, 'bold,underline') " 匹配的括号对
" }
" { Message
call theme#hl('Directory', g:theme_wheaten0, g:theme_none, 'bold') " 目录名和列表里其它特殊名字
call theme#hl('Title', g:theme_darkgreen, g:theme_none, 'bold') " :set all, :autocmd 等输出的标题
call theme#hl('WarningMsg', g:theme_orange) " 警告信息
call theme#hl('ErrorMsg', g:theme_red) " 错误信息
call theme#hl('ModeMsg', g:theme_none, g:theme_none, 'bold') " 模式信息. 如: -- INSERT --
call theme#hl('MoreMsg', g:theme_gray, g:theme_none, 'bold') " |more-prompt|
call theme#hl('Question', g:theme_darkgreen, g:theme_none, 'bold') " |hit-enter| 提示和 yes/no 问题
" }
" { Diff
call theme#hl('DiffAdd', g:theme_none, g:theme_darkgray1) " 增加的行
call theme#hl('DiffChange', g:theme_none, g:theme_darkgray2) " 差异的行
call theme#hl('DiffDelete', g:theme_darkgray2, g:theme_darkgray4) " 删除的行
call theme#hl('DiffText', g:theme_none, g:theme_darkred2) " 差异行里的差异内容
" }
" { Cursor
call theme#hl('Cursor', g:theme_black, g:theme_green) " 光标
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
call theme#hl('CursorLine', g:theme_none) " 光标所在行
call theme#hl('CursorColumn', g:theme_none) " 光标所在列
call theme#hl('Visual', g:theme_white, g:theme_blue) " 可视模式的选择区
" }
" { Character
call theme#hl('NonText', g:theme_darkgray1) " 文本里实际不存在的字符: '~','@','<',...
call theme#hl('SpecialKey', g:theme_darkgray0) " 不可显ASCII字符
" }
" { Symbol. 参考:|group-name|
call theme#hl('Comment', g:theme_gray) " 注释

call theme#hl('Constant', g:theme_darkgreen, g:theme_none, 'bold') " 常量. 如: NULL, __FILE__
call theme#hl('String', g:theme_wheaten0, g:theme_darkgray2) " 字符串
call theme#hl('Character', g:theme_wheaten1) " 字符: '\n'
call theme#hl('Number', g:theme_wheaten2) " 数值
call theme#hl('Boolean', g:theme_wheaten1, g:theme_none, 'bold') " 二值. TRUE, false
call theme#hl('Float', g:theme_wheaten1) " 浮点数

call theme#hl('Identifier', g:theme_lightblue0) " 任何变量
call theme#hl('Function', g:theme_lightgreen1, g:theme_none, 'bold') " 函数, 方法

call theme#hl('Statement', g:theme_darkred1) " 关键字
call theme#hl('Conditional', g:theme_darkred0) " if, then, else, endif, switch, etc.
call theme#hl('Repeat', g:theme_darkred0) " for, do, while, etc.
call theme#hl('Label', g:theme_darkred0) " case, default, etc.
call theme#hl('Operator', g:theme_lightgray0) " sizeof, +, *, etc.
call theme#hl('Keyword', g:theme_darkred1) " any other keyword
call theme#hl('Exception', g:theme_darkred0) " try, catch, throw

call theme#hl('PreProc', g:theme_lightred0) " 通用预处理
call theme#hl('Include', g:theme_lightgray0) " #include
call theme#hl('Define', g:theme_lightred1) " #define
call theme#hl('Macro', g:theme_lightred1) " 同Define
call theme#hl('PerCondit', g:theme_lightred0) " #if, #else, #endif, etc.

call theme#hl('Type', g:theme_lightgreen0) " 通用类型 int, long, char ...
call theme#hl('StorageClass', g:theme_lightred0) " static, register, volatile const ...
call theme#hl('Structure', g:theme_lightgreen0) " struct, union, enum ...
call theme#hl('Typedef', g:theme_lightgreen0, g:theme_none, 'bold') " typedef

call theme#hl('Special', g:theme_lightgreen0, g:theme_none, 'bold') " 通用特殊符号
call theme#hl('SpecialChar', g:theme_lightyellow, g:theme_darkgray2) " 常量中的特殊字符
call theme#hl('Tag', g:theme_deepblue) " 可ctrl-]跳转的符号
call theme#hl('Delimiter', g:theme_lightgray0) " 需要关注的字符
call theme#hl('SpecialComment', g:theme_lightred0) " 注释中的特殊字符
call theme#hl('Debug', g:theme_gray) " 调试语句

call theme#hl('Underlined', g:theme_deepblue, g:theme_none, 'underline') " 突出显示. 如HTML链接
call theme#hl('Ignore', g:theme_darkgray1) " 忽略内容
call theme#hl('Error', g:theme_white, g:theme_red) " 错误标注. 如: DISABLE
call theme#hl('Todo', g:theme_black, g:theme_yellow) " 关键说明标注. 如: TODO FIXME XXX
" }
" { Nvim-Tree

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
call theme#hl('NvimTreeSpecialFile', g:theme_darkgreen, g:theme_none, 'bold,underline') " 特殊文件
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

call theme#hl('NvimTreeWindowPicker', g:theme_white, g:theme_darkgreen, 'bold') " 窗口选择器
call theme#hl('NvimTreeNormal', g:theme_lightgray1, g:theme_darkgray3) " 默认配色

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

