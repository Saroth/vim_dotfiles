" let $VIM = $HOME . '/.config/vim' " 在.vimrc中定义
set runtimepath+=$VIM/vimfiles " 将vimfiles添加到rtp, 用于加载lua, colors等配置

source $VIM/vimfiles/config/basic.vim
source $VIM/vimfiles/config/keymap.vim
source $VIM/vimfiles/config/plugin.vim

lua require('entry')

