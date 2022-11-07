" Description: Plugins configurations, managed by vim-plug, coc.nvim
" Install: curl -fLo $VIM/vimfiles/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" Plug 'morhetz/gruvbox'
" MANAGER:
" {
" }

" OTHER:
" { winbar              窗口栏
    " Plug 'fgheng/winbar.nvim'
" }
" { indent-guides       缩进指示条. <leader>ig
    Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1   " 自启动
    let g:indent_guides_auto_colors = 0 " 自动配色
    let g:indent_guides_color_change_percent = 4    " 缩进颜色改变比例
    let g:indent_guides_guide_size = 1  " 缩进指示条宽度
    let g:indent_guides_tab_guides = 1  " Tab显示缩进指示高亮
    let g:indent_guides_space_guides = 1    " 空格显示缩进指示高亮
    hi IndentGuidesOdd guifg=#3a3a3a guibg=#1c1c1c ctermfg=237 ctermbg=234
    hi IndentGuidesEven guifg=#4e4e4e guibg=#303030 ctermfg=239 ctermbg=236
" }
" { color-table         终端颜色表. :XtermColorTable
    Plug 'guns/xterm-color-table.vim'
" }

" All of your Plugs must be added before the following line
call plug#end()

