" Install: curl -fLo $VIM/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" Manager:
" coc.nvim 已迁移到 lua/plugin/coc.lua
" { fugitive        Git管理. Invoke most by :Git *** :Gdiff :Gstatus ...
  Plug 'tpope/vim-fugitive'
" }
" { dadbod.vim      数据库交互插件/UI. invoke by :DBUI
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
" }
" { vim-startify    启动页
  Plug 'mhinz/vim-startify'
  let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'
  let g:startify_bookmarks = [
        \ { 'h': '~' },
        \ { 'v': '~/.config/nvim' },
        \ { 'c': getcwd() },
        \ ]
  let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
" }
" Completion:
" { Visincr         快捷递增输入. Block selected and type :I, :II, :IO, :IIO, :IR, :IIR, IX
  Plug 'vim-scripts/Visincr'
" }
" Formatter:
" { kotlin-vim      Kotlin的语法支持.
  Plug 'udalov/kotlin-vim'
" }
" { vim-easy-align  代码对齐. selected and type :EasyAlign
  Plug 'junegunn/vim-easy-align'
" }
" { vim-table-mode  表格插件, Enable: <leader>tm
"                                 Insert Column: <leader>tic
"                                 Delete Row: <leader>tdc
"                                 Delete Row: <leader>tdd
  Plug 'dhruvasagar/vim-table-mode'
  let g:table_mode_corner = '|' " 兼容Markdown的制表分隔符
  let g:table_mode_syntax = 0 " XXX: 影响编辑速度, 关闭表格高亮
" }
" { nerdcommenter   快捷注释 invoke by <leader>cc, ...
  Plug 'scrooloose/nerdcommenter'
  let g:NERDSpaceDelims = 1 " 在左注释符之后, 右注释符之前插入空格
  let g:NERDRemoveExtraSpaces = 1 " 在取消注释后同时去掉添加的空格
  " 其他类型的文件的注释符
  let g:NERDCustomDelimiters = {
        \ 'vimentry': { 'left': '--' },
        \ }
" }
" Search:
" { LeaderF         文件搜索. invoke by <leader>ff
  " nvim依赖pynvim: pip3 install pynvim
  Plug 'Yggdroot/LeaderF'
  let g:Lf_ShortcutF = '<leader>ff' " 文件搜索触发键
  let g:Lf_ShortcutB = '<leader>fb' " 缓存搜索触发键
  let g:Lf_CursorBlink = 0 " 光标闪烁
  let g:Lf_StlSeparator = { 'left': '', 'right': '' } " 状态栏分隔符
  let g:Lf_CommandMap = {'<C-S>': ['<C-V>']} " 修改内建映射
  " 忽略匹配
  let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
        \}
  " 如果工程有版本管理, 则使用版本管理工具索引文件, g:Lf_WildIgnore将失效
  let g:Lf_UseVersionControlTool = 1
" }
" { CtrlSF          全局搜索. invoke by <leader>gg
  Plug 'dyng/ctrlsf.vim'
  let g:ctrlsf_auto_focus = {
        \ "at": "start"
        \ }
  " 结果上下文行数
  let g:ctrlsf_context = '-C 1'
  " 1:正则搜索, 或使用-R选项
  let g:ctrlsf_regex_pattern = 0
  " 异步搜索
  let g:ctrlsf_search_mode = 'async'
  " 紧凑显示
  let g:ctrlsf_default_view_mode = 'compact'
  let g:ctrlsf_position = 'bottom'
  let g:ctrlsf_winsize = '30%'
  nmap     <leader>gg <Plug>CtrlSFCwordExec
  vmap     <leader>gg <Plug>CtrlSFVwordExec
  nmap     <leader>gw <Plug>CtrlSFCCwordExec
  nmap     <leader>gp <Plug>CtrlSFPwordExec
  nnoremap <leader>go :CtrlSFOpen<CR>
  nnoremap <leader>gt :CtrlSFToggle<CR>
  inoremap <leader>gt <Esc>:CtrlSFToggle<CR>
  let g:ctrlsf_mapping = {
        \ "quit": "<esc>",
        \ }
" }
" { sneak.Vim       字符跳转, 增强f/F功能. 跳转到指定的2个字符. invoke by f??
  Plug 'justinmk/vim-sneak'
  map f <Plug>Sneak_s
  map F <Plug>Sneak_S
" }
" Decorate:
" { gitgutter       显示git修改标记
  Plug 'airblade/vim-gitgutter'
  " 标记符号
  let g:gitgutter_sign_modified = '!'
  let g:gitgutter_sign_modified_removed = '!_'
  " Sign colors:
  call theme#hl("GitGutterAdd", g:theme_green, g:theme_darkgray4)
  call theme#hl("GitGutterChange", g:theme_gold, g:theme_darkgray4)
  call theme#hl("GitGutterDelete", g:theme_darkred0, g:theme_darkgray4)
  " Mappings
  map gn <Plug>(GitGutterNextHunk)
  map gp <Plug>(GitGutterPrevHunk)
" }
" { indent-guides   缩进指示条. Enable/Disable: <leader>ig
  Plug 'preservim/vim-indent-guides'
  let g:indent_guides_enable_on_vim_startup = 1   " 自启动
  let g:indent_guides_auto_colors = 1 " 自动配色
  let g:indent_guides_color_change_percent = 4    " 缩进颜色改变比例
  let g:indent_guides_guide_size = 1  " 缩进指示条宽度
  let g:indent_guides_start_level = 2 " 显示起始列
  let g:indent_guides_exclude_buftype = 1   " 在非文件缓冲区禁用
  " 不显示的文件类型
  let g:indent_guides_exclude_filetypes = ['help', 'NvimTree', 'dashboard', 'startify']
  let g:indent_guides_exclude_buftypes = ['terminal', 'nofile']
" }
" { rainbow         括号高亮匹配
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1
  let g:rainbow_conf = {
        \ 'guifgs': [
        \   '#ff0000', '#ff8700', '#ffff00', '#87ff00',
        \   '#00ff00', '#00ff87', '#00ffff', '#00a7ff',
        \   '#5f5fff', '#a700ff', '#ff00ff', '#ff0087',
        \ ],
        \ 'ctermfgs': [
        \   196, 208, 226, 118,
        \   46, 48, 51, 33,
        \   63, 93, 13, 198,
        \ ],
        \ 'operators': '_,_',
        \ 'parentheses': [
        \   'start=/(/ end=/)/ fold',
        \   'start=/\[/ end=/\]/ fold',
        \   'start=/{/ end=/}/ fold',
        \ ],
        \ 'separately': { '*': {}, }
        \ }
" }
" { xterm-color-table       终端颜色表. :XtermColorTable
  Plug 'guns/xterm-color-table.vim'
" }
" { markdown-preview.nvim   Markdown实时预览, invoked by :MarkdownPreview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  let g:mkdp_auto_start = 0 " 1: 打开markdown文件buffer时自动打开预览
  let g:mkdp_auto_close = 1 " 1: 关闭buffer时自动关闭预览
  let g:mkdp_refresh_slow = 1 " 1: 仅保存或退出编辑模式时刷新预览
  let g:mkdp_browser = '' " 预览使用的浏览器
  let g:mkdp_echo_preview_url = 1 " 显示预览地址
  let g:mkdp_port = '' " 自定义端口, 使用固定端口会导致无法多开
  let g:mkdp_open_to_the_world = 1 " 局域网内可访问
  " let g:mkdp_theme = 'light' 默认主题
  " 样式配置
  " let g:mkdp_markdown_css = $VIM.'/vimfiles/tools/css/markdown.css'
  " let g:mkdp_highlight_css = $VIM.'/vimfiles/tools/css/highlight.css'
  " 转换选项.
  " uml.imageFormat: 默认为img, 生成png图片, png中文字体模糊, 改用svg图片
  let g:mkdp_preview_options = {
        \ 'uml': {
        \ 'server': 'http://47.93.4.73:51801',
        \ 'imageFormat': 'svg',
        \ },
        \ }
" }

" All of your Plugs must be added before the following line
call plug#end()

