NeoVim配置
---

# About
## 适用环境
*   Platform: `Linux`
*   `Vim`: `>5.0`
*   `NeoVim`: `>0.8.0`

## 安装目录
*   `Linux`: ~/.config/nvim

# Install
## 系统软件:
```shell
## coc-vimlsp依赖
$ sudo npm install -g eslint

## coc-ccls依赖
$ sudo dnf install ccls

## coc-go依赖
$ sudo dnf install gotags golang-x-tools-gopls

## coc-pyright
$ sudo pip3 install pylint jedi

## LeaderF
$ sudo pip3 install pynvim
```

## Vim插件
```vimscript
" plug.vim插件管理器批量安装
:PlugInstall

" packer插件管理器批量安装
:PackerInstall
```

