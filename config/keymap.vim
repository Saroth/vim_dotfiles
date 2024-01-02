" Description: Key maps

" { Edit
  " 保存容错
  noremap :W :w
  " 原功能: N/I:跳转到下一行; 新功能: 下滚屏
  noremap <C-j> 8<C-d>
  " 原功能: N:~ I:特殊字符组合输入; 新功能: 上滚屏
  noremap <C-k> 8<C-u>
  " 选中一个词
  noremap vv viwO
  " 保持选中状态调整缩进
  vnoremap < <gv
  vnoremap > >gv
" }
" { Command line
  " 在命令行的补全菜单中, 上下键和左右键功能对换. 上下选择补全项, 左右返回和确认
  cnoremap <expr> <Up> wildmenumode() ? "\<Left>" : "\<Up>"
  cnoremap <expr> <Down> wildmenumode() ? "\<Right>" : "\<Down>"
  cnoremap <expr> <Left> wildmenumode() ? "\<Up>" : "\<Left>"
  cnoremap <expr> <Right> wildmenumode() ? "\<Down>" : "\<Right>"
" }
" { Function key
  map <F2> :e $VIM/config/basic.vim <CR>
  map <F3> :e $VIM/config/keymap.vim <CR>
  map <F4> :e $VIM/config/plugin.vim <CR>

  map <F5> :CocList<CR>
  map <F6> :CocRestart<CR>
  map <F7> :call CocAction('diagnosticRefresh')<CR>
  map <F8> :NvimTreeFindFileToggle<CR>

" }

