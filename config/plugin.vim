" Install: curl -fLo $VIM/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" Coc:
" { coc.nvim            语言服务插件管理
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_config_home = $VIM.'/config'
  hi Pmenu        guibg=#303030 guifg=#d0d0d0             ctermbg=236 ctermfg=252

  " 使用<tab>触发补全
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  " 使用<CR>选中补全项
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

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
  nmap <leader>cl  <Plug>(coc-codelens-action)

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
" Decorate:
" { gitgutter           显示git修改标记
  Plug 'airblade/vim-gitgutter'
  " 标记符号
  let g:gitgutter_sign_modified = '!'
  let g:gitgutter_sign_modified_removed = '!_'
  " Sign colors:
  hi GitGutterAdd     guifg=#00df00 guibg=#121212 ctermfg=40  ctermbg=233
  hi GitGutterChange  guifg=#ffaf00 guibg=#121212 ctermfg=214 ctermbg=233
  hi GitGutterDelete  guifg=#ff0000 guibg=#121212 ctermfg=196 ctermbg=233
  " Mappings
  map gn <Plug>(GitGutterNextHunk)
  map gp <Plug>(GitGutterPrevHunk)
" }
" { indent-guides       缩进指示条. <leader>ig
  Plug 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_enable_on_vim_startup = 1   " 自启动
  let g:indent_guides_auto_colors = 0 " 自动配色
  let g:indent_guides_color_change_percent = 4    " 缩进颜色改变比例
  let g:indent_guides_guide_size = 2  " 缩进指示条宽度
  let g:indent_guides_tab_guides = 1  " Tab显示缩进指示高亮
  let g:indent_guides_space_guides = 1    " 空格显示缩进指示高亮
  hi IndentGuidesOdd guifg=#3a3a3a guibg=#1c1c1c ctermfg=237 ctermbg=234
  hi IndentGuidesEven guifg=#4e4e4e guibg=#303030 ctermfg=239 ctermbg=236
" }
" OTHER:
" { xterm-color-table   终端颜色表. :XtermColorTable
  Plug 'guns/xterm-color-table.vim'
" }

" All of your Plugs must be added before the following line
call plug#end()

