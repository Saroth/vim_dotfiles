" Install: curl -fLo $VIM/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" Manager:
" { coc.nvim        语言服务插件管理
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " :CocInstall coc-vimlsp
  " :CocInstall coc-sql
  " :CocInstall coc-xml
  " :CocInstall coc-html
  " :CocInstall coc-css
  " :CocInstall coc-eslint    " 需要eslint: sudo npm install -g eslint
  " :CocInstall coc-tsserver
  " [x] :CocInstall coc-ccls      " 需要ccls: sudo dnf install ccls. 存在问题, 改用clangd
  " :CocInstall coc-clangd    " 需要clangd
  " :CocInstall coc-cmake
  " :CocInstall coc-java      " 需要jdtls: 要求版本0.57.
  "                               下载地址: https://download.eclipse.org/jdtls/milestones/0.57.0/
  "                               安装到coc插件目录: ~/.config/coc/extensions/coc-java-data/server
  "                               当自动安装失败, 或jdtls启动失败时, 可尝试手动安装
  " :CocInstall coc-go        " 需要gotags/gopls:
  "                               sudo dnf install gotags golang-x-tools-gopls
  " :CocInstall coc-pyright   " 需要pylint/jedi:
  "                               sudo pip3 install pylint jedi
  " :CocInstall coc-sumneko-lua   " lua语法补全, 支持nvim接口补全
  " 补全插件:
  " :CocInstall coc-tabnine   " AI补全, 内存占用极大
  " :CocInstall coc-omni
  " :CocInstall coc-snippets  " 代码块方案
  " 其他插件:
  " :CocInstall coc-highlight
  let g:coc_config_home = $VIM.'/config'
  call theme#hl("CocFloating", g:theme_none, g:theme_darkgray2)
  call theme#hl("CocFloatThumb", g:theme_none, g:theme_gray)
  call theme#hl("CocFloatSbar", g:theme_none, g:theme_darkgray1)
  call theme#hl("CocFloatDividingLine", g:theme_black)
  call theme#hl("CocFloatActive", g:theme_none, g:theme_gray)
  call theme#hl("CocErrorFloat", g:theme_red)
  call theme#hl("CocHintFloat", g:theme_lightblue0)

  " 使用<tab>触发补全，切换补全项，切换片段输入点.
  " 可设置suggest.noselect默认不选中.
  let g:coc_snippet_next = '<tab>'
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  inoremap <silent><expr> <tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<tab>" : coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  " 使用<CR>选中补全项。如需要忽略补全直接换行，按<c-j>
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  " 代码诊断点跳转
  nmap <silent> g[ <Plug>(coc-diagnostic-prev)
  nmap <silent> g] <Plug>(coc-diagnostic-next)
  " 代码导航跳转
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " 使用<K>在预览窗口显示文档
  nnoremap <silent> K :call ShowDocumentation()<CR>
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
  " 光标停留时高亮符号和定义
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " 符号重命名
  nmap <leader>rn <Plug>(coc-rename)
  " 对选中代码格式化
  xmap <leader>f <Plug>(coc-format-selected)
  nmap <leader>f <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying code actions to the selected code block
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)
  " Remap keys for applying code actions at the cursor position
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Remap keys for apply code actions affect whole buffer
  nmap <leader>as  <Plug>(coc-codeaction-source)
  " Apply the most preferred quickfix action to fix diagnostic on the current line
  nmap <leader>qf  <Plug>(coc-fix-current)
  " Remap keys for applying refactor code actions
  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  " Run the Code Lens action on the current line
  " nmap <leader>cl  <Plug>(coc-codelens-action)  " 与注释插件冲突

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  if has('nvim-0.4.0') || has('patch-8.2.0750')
    " 映射<C-f>和<C-b>用于滚动弹窗内容, 如函数说明等
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges
  " Requires 'textDocument/selectionRange' support of language server
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer
  command! -nargs=0 Format :call CocActionAsync('format')
  " Add `:Fold` command to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
  " Add `:OR` command for organize imports of the current buffer
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }
" { fugitive        Git管理. Invoke most by :Git *** :Gdiff :Gstatus ...
  Plug 'tpope/vim-fugitive'
" }
" Completion:
" { Visincr         快捷递增输入. Block selected and type :I, :II, :IO, :IIO, :IR, :IIR, IX
  Plug 'vim-scripts/Visincr'
" }
" { auto-pairs      匹配括号自动补全
  Plug 'jiangmiao/auto-pairs'
" }
" Formatter:
" { vim-markdown    Markdowm语法支持. 功能: 段落折叠, 文本格式
  Plug 'plasticboy/vim-markdown'
  let g:vim_markdown_folding_disabled=0 " 禁用折叠
  let g:vim_markdown_folding_style_pythonic = 1 " 类似python-mode的折叠样式
  let g:vim_markdown_override_foldtext = 0 " 不设置折叠文本
  let g:vim_markdown_math=1 " 使用数学符号
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
  let g:indent_guides_exclude_filetypes = ['help', 'NvimTree', 'dashboard']
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
        \ 'uml': { 'imageFormat': 'svg' },
        \ }
" }

" All of your Plugs must be added before the following line
call plug#end()

