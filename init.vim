" Preset: 在.vimrc中定义: let $VIM = $HOME . '/.config/vim'
set runtimepath+=$VIM " 将路径添加到rtp, 用于加载autoload, lua, colors等配置

for $i in [
      \ 'basic',
      \ 'keymap',
      \ 'autocmd',
      \ 'plugin',
      \ ]
  source $VIM/config/$i.vim
endfor
if has('nvim') " For Neovim only: Load $VIM/lua/init.lua
    lua require('')
endif

