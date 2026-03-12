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
  noremap <F2> :e $VIM/config/basic.vim <CR>
  noremap <F3> :e $VIM/config/keymap.vim <CR>
  noremap <F4> :e $VIM/config/plugin.vim <CR>

  noremap <F5> :call CocAction('diagnosticRefresh')<CR>
  noremap <F6> :CocList<CR>
  " 清理Java工作区
  nnoremap <silent> <C-F7> :CocCommand java.clean.workspace<CR>
  " 重启语言服务
  noremap <F7> :CocRestart<CR>
  noremap <F8> :NvimTreeFindFileToggle<CR>

  " 将所选内容(代码/文件)发送给Claude
  noremap <F9> :ClaudeCodeSend<CR>
  vnoremap <silent> <F9> :'<,'>ClaudeCodeSend<CR>

  noremap <C-l> :call autocmd#diagnostic_refresh()<CR>:nohl<CR><C-l>
" }

