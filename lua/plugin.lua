-- XXX: 配置修改后需执行:PackerSync并重启

-- Plugins init {
local ensure_packer = function()
  -- 检查并自动安装Packer
  local f = vim.fn
  local packer_path = f.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if f.empty(f.glob(packer_path)) <= 0 then
    return false
  end
  f.system({'git', 'clone', '--depth', '1',
  'https://github.com/wbthomason/packer.nvim', packer_path})
  return true
end
local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Packer manage itself
  use 'wbthomason/packer.nvim'
  -- nvim-treesitter    基于NeoVim内置treesiter的代码高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- nvim-tree.lua      文件管理器
  use { 'nvim-tree/nvim-tree.lua',
  requires = { 'nvim-tree/nvim-web-devicons', }} -- file icons

  --- After all plugins
  if packer_bootstrap then
    -- 初次安装后自动配置
    require('packer').sync()
  end
end)
-- }
-- nvim-treesitter {
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'vim', 'help', 'java', 'javascript', 'python' }, -- A list of parser names { 'c', 'lua', 'rust' }
  sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ignore_install = { }, -- List of parsers to ignore installing (for 'all')
  highlight = {
    enable = true, -- 全局开关
    disable = { }, -- 禁用高亮的语言. NOTE: 此处填写解析器名, 而不是文件类型
    disable = function(lang, buf) -- 灵活控制. 不对大文件启用高亮
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- }
-- nvim-tree.lua {
-- 在启动时禁用NeoVim自带文件管理器插件netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true  -- 启用高亮
local ntapi = require('nvim-tree.api')
require('nvim-tree').setup({
  sort_by = 'name',  -- 排序规则
  view = {
    adaptive_size = false,  -- 自适应大小
    width = {
      min = 32,
      max = -1,
      padding = 0,
    },
    side = 'left',  -- 靠边位置: left/right. 放左边可以显示超长文件名
    preserve_window_proportions = false,  -- 文件变动时更新窗口长宽
    number = false,  -- 行号
    signcolumn = 'yes',  -- 标志列
  },
  modified = {  -- 修改状态显示
    enable = true,
    show_on_dirs = true,  -- 文件夹内有文件修改时, 文件夹显示修改状态
    show_on_open_dirs = false,  -- 已展开的文件夹不显示修改状态
  },
  renderer = {
    add_trailing = true,  -- 文件夹末尾加斜线
    group_empty = true,  -- 文件夹内只有一个文件夹时, 使用组合显示
    full_name = true,  -- 文件名长度超出窗口宽度时继续显示
    highlight_git = true,  -- 高亮显示文件git状态
    highlight_opened_files = "name",  -- 高亮显示已打开的文件
    highlight_modified = "name",  -- 高亮显示已修改的文件
    indent_width = 2,  -- 缩进宽度
    indent_markers = {  -- 缩进标志显示
      enable = true,
      inline_arrows = false,
    },
    icons = {
      show = {  -- 图标显示控制
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
        modified = true,
      },
      git_placement = 'signcolumn',  -- 将git状态标志放在标志列显示
      modified_placement = 'after',  -- 将修改状态标志放在文件末尾显示
    }
  },
  filters = {
    dotfiles = true,  -- 隐藏文件显示控制. 按'H'切换
  },
  actions = {
    file_popup = {
      open_win_config = {
        border = "rounded",  -- 浮动窗口样式. rounded:显示为圆角
      }
    }
  },
})
-- }

