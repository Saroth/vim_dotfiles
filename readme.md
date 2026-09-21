NeoVim配置
---

# About
## 适用环境
*   Platform: `Linux`
*   `NeoVim`: `>=0.9.0`

## 安装目录
*   `Linux`: ~/.config/nvim

# 插件管理器
使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件，首次启动自动安装。

# 已安装插件
| 插件 | 用途 |
|------|------|
| nvim-tree.lua | 文件浏览器 |
| nvim-treesitter | 语法高亮 |
| markdown-preview.nvim | Markdown 预览 |
| render-markdown.nvim | Markdown 渲染 |
| aerial.nvim | 代码大纲 |
| claudecode.nvim | Claude Code 集成 |
| opencode.nvim | OpenCode 集成 |
| sshfs.nvim | SSH 远程文件系统 |
| coc.nvim | LSP 补全引擎 |
| autopairs | 括号自动配对 |

# Install
## 系统依赖:
```shell
# coc.nvim 依赖
$ sudo npm install -g neovim eslint

# C/C++ LSP
$ sudo dnf install ccls

# Go LSP
$ sudo dnf install golang-x-tools-gopls

# Python LSP
$ sudo pip3 install pylint jedi
```

## 插件安装
启动 NeoVim 后执行:
```vimscript
:Lazy install
```

