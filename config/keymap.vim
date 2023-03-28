" Description: Key maps

" { Edit
  " 保存容错
  noremap :W :w
  " 原功能: N/I:跳转到下一行; 新功能: 下滚屏
  noremap <C-j> 8<C-d>
  " 原功能: N:~ I:特殊字符组合输入; 新功能: 上滚屏
  noremap <C-k> 8<C-u>
  " 反向选中一个词
  noremap vv viwO
  " 正向选中一个词
  noremap vV viw
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
  " F2:
  map <F2> :e $VIM/vimfiles/config/basic.vim <CR>
  " F3:
  map <F3> :e $VIM/vimfiles/config/keymap.vim <CR>
  " F4:
  map <F4> :e $VIM/vimfiles/config/plugin.vim <CR>

  " F5:
  map <F5> :Update<CR>
  " F8:
  map <F8> :NvimTreeToggle<CR>

  "  F9: next hunk
  map <F9> <Plug>(GitGutterNextHunk)
  "  F10: previous hunk
  map <F10> <Plug>(GitGutterPrevHunk)
" }

