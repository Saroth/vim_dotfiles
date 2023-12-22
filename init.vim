" let $VIM = $HOME . '/.config/vim' " 在.vimrc中定义
set runtimepath+=$VIM " 将路径添加到rtp, 用于加载autoload, lua, colors等配置

let $CFG_PATH=$VIM . '/config'
source $CFG_PATH/basic.vim
source $CFG_PATH/keymap.vim
source $CFG_PATH/autocmd.vim
source $CFG_PATH/plugin.vim

if has('nvim') " For Neovim only: Load $VIM/lua/init.lua
    lua require('')
endif

