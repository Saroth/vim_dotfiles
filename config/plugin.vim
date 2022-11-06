" Description: Plugins configurations, managed by vim-plug, coc.nvim
" Install: curl -fLo $VIM/vimfiles/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" Plug 'morhetz/gruvbox'

" OTHER:
" { winbar          窗口栏
    " Plug 'fgheng/winbar.nvim'
" }
" { color-table     终端颜色表. :XtermColorTable
    Plug 'guns/xterm-color-table.vim'
" }

" All of your Plugs must be added before the following line
call plug#end()

