# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 在本仓库中工作时提供指导。

## 项目概览

Vim/NeoVim 配置文件仓库。安装目录：`~/.config/nvim`。平台：Linux。最低版本要求：Vim > 5.0，NeoVim > 0.8.0。

## 测试配置

`test/` 目录下的测试脚本使用临时 vimrc 启动 vim/vi/nvim（无需安装到 `~/.config/nvim`）：

```bash
bash test/test_nvim.sh   # 使用 neovim 测试
bash test/test_vim.sh    # 使用 vim 测试
bash test/test_vi.sh     # 使用 vi 测试
```

## 架构

### 双插件管理器

- **vim-plug**（`autoload/plug.vim`，已内置）— VimScript 插件在 `config/plugin.vim` 中声明
- **packer.nvim**（自动引导安装）— Lua 插件位于 `lua/plugin/`

### 配置层级

**VimScript 层**（Vim + NeoVim 通用）：`init.vim` 按顺序加载 `config/basic.vim` → `config/keymap.vim` → `config/autocmd.vim` → `config/plugin.vim`。

**Lua 层**（仅 NeoVim）：`lua/init.lua` → `lua/plugin/init.lua` 编排 packer。每个 Lua 插件模块（`lua/plugin/*.lua`）导出表 `M`，包含可选的生命周期方法：`repo`、`init()`、`postload()`、`setup()`。

### 自定义主题系统

`autoload/theme.vim` 定义了 40 多个颜色变量（`g:theme_white`、`g:theme_darkgray3` 等）以及 `theme#hl()` / `theme#init()` 函数。`colors/clearblack.vim` 是自定义深色配色方案。Lua 代码通过 `lua/util.lua` 封装调用 `theme#hl()`。

### LSP：coc.nvim

所有 coc.nvim 集成（扩展、快捷键、配置）位于 `config/plugin.vim`。LSP 服务器设置位于 `config/coc-settings.json`。诊断在保存时运行（非实时）。支持的服务器：Go (gopls)、Java、Lua、XML。

## 添加新插件

**VimScript 插件**：在 `config/plugin.vim` 的 `plug#begin()` 和 `plug#end()` 之间添加 `Plug 'repo/name'`，配置写在下方。

**Lua 插件**：创建 `lua/plugin/newplugin.lua`，导出表 `M`，包含 `repo`（GitHub 路径）以及可选的 `init()`、`postload()`、`setup()`。将模块名添加到 `lua/plugin/init.lua` 的模块列表中。

## 代码风格

- 注释使用中文，标识符使用英文
- 默认缩进：4 空格；Web/脚本语言（html、css、js、vue、json、yaml）：2 空格（在 `config/autocmd.vim` 中定义）
- 折叠方式：标记（`{`、`}`）
- Leader 键：`\`（默认值，未显式设置）
