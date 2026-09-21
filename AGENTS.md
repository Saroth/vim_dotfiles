# AGENTS.md

本文件为 AI 编程助手在本仓库中工作时提供指导。

## 项目概览

NeoVim 配置文件仓库。安装目录：`~/.config/nvim`。平台：Linux。最低版本要求：NeoVim >= 0.9.0。

## 测试配置

`test/` 目录下的测试脚本使用临时 vimrc 启动 neovim（无需安装到 `~/.config/nvim`）：

```bash
bash test/test_nvim.sh   # 使用 neovim 测试
```

## 架构

### AI 编程助手集成

**claudecode.nvim** (`lua/plugin/claudecode.lua`):
- `go`: 发送当前行/选区到 Claude Code
- `gO` (nvimtree): 发送文件到 Claude Code
- `diff_opts.open_in_new_tab = true`: diff 视图在新 tab 打开
- `auto_start = true`: 自动启动
- `terminal.provider = "none"`: 通过外部终端运行 claude，需执行 `claude --ide` 或 `/ide` 连接编辑器

**opencode.nvim** (`lua/plugin/opencode.lua`):
- `gO`: 发送当前行/选区到 OpenCode
- `go` (nvimtree): 发送文件路径到 OpenCode

### 插件管理器

**lazy.nvim**（自动引导安装）— 所有插件通过 `lua/plugin/*.lua` 模块声明，由 `lua/plugin/init.lua` 统一编排。

### 配置层级

**VimScript 层**（基础配置）：`init.vim` 按顺序加载 `config/basic.vim` → `config/keymap.vim` → `config/autocmd.vim`。

**Lua 层**（插件配置）：`lua/init.lua` → `lua/plugin/init.lua` 编排 lazy.nvim。每个 Lua 插件模块（`lua/plugin/*.lua`）导出表 `M`，包含：
- `spec`: lazy.nvim 插件规范（必需）
- `init()`: 初始化函数（可选，在 lazy.nvim 加载前执行）
- `setup()`: 配置函数（可选，在插件加载后执行）

### 自定义主题系统

`autoload/theme.vim` 定义了 40 多个颜色变量（`g:theme_white`、`g:theme_darkgray3` 等）以及 `theme#hl()` / `theme#init()` 函数。`colors/clearblack.vim` 是自定义深色配色方案。Lua 代码通过 `lua/util.lua` 封装调用 `theme#hl()`。

### LSP：coc.nvim

所有 coc.nvim 集成（扩展、快捷键、配置）位于 `lua/plugin/coc.lua`。LSP 服务器设置位于 `config/coc-settings.json`。诊断在保存时运行（非实时）。支持的服务器：Go (gopls)、Java、Lua、XML。

## 添加新插件

创建 `lua/plugin/newplugin.lua`，导出表 `M`，包含 `spec`（lazy.nvim 规范）以及可选的 `init()`、`setup()`。将模块名添加到 `lua/plugin/init.lua` 的 `plugins` 列表中。

## 代码风格

- 注释使用中文，标识符使用英文
- 默认缩进：4 空格；Web/脚本语言（html、css、js、vue、json、yaml）：2 空格（在 `config/autocmd.vim` 中定义）
- 折叠方式：标记（`{`、`}`）
- Leader 键：`\`（默认值，未显式设置）
