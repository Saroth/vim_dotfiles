" Description: Plugins configurations, managed by vim-plug, coc.nvim
" Install: curl -fLo $VIM/vimfiles/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/vimfiles/plugged')

" Plug 'morhetz/gruvbox'

" OTHER:
" { color-table     终端颜色表 Use for match term color and gui color
    Plug 'guns/xterm-color-table.vim'
" }

" All of your Plugs must be added before the following line
call plug#end()

