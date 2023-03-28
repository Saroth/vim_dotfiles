" let $VIM = $HOME . '/.config/vim' " 在.vimrc中定义
set runtimepath+=$VIM " 将路径添加到rtp, 用于加载lua, colors等配置

source $VIM/config/basic.vim
source $VIM/config/keymap.vim
source $VIM/config/plugin.vim

if has('nvim') " For Neovim only: Load $VIM/lua/init.lua
    lua require('init')
endif

