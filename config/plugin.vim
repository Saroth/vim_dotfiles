" Install: curl -fLo $VIM/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" Manager:
" coc.nvim 已迁移到 lua/plugin/coc.lua
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
" { sneak.Vim       字符跳转, 增强f/F功能. 跳转到指定的2个字符. invoke by f??
  Plug 'justinmk/vim-sneak'
  map f <Plug>Sneak_s
  map F <Plug>Sneak_S
" }
" Decorate:
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

" All of your Plugs must be added before the following line
call plug#end()

