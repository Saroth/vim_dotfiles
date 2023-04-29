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
local function my_on_attach(nr)  -- 映射配置
  local i = require('nvim-tree.api')
  local function o(d)
    return { desc = 'nvim-tree: ' .. d, buffer = nr, noremap = true, silent = true, nowait = true, }
  end
  i.config.mappings.default_on_attach(nr)  -- 载入默认映射
  ---- 以下为自定义映射
  -- 调换J/K和</>
  vim.keymap.set('n', 'J', i.node.navigate.sibling.next, o('Next Sibling'))
  vim.keymap.set('n', 'K', i.node.navigate.sibling.prev, o('Previous Sibling'))
  vim.keymap.set('n', '>', i.node.navigate.sibling.last, o('Last Sibling'))
  vim.keymap.set('n', '<', i.node.navigate.sibling.first, o('First Sibling'))
  -- Git
  vim.keymap.set('n', '<F9>', i.node.navigate.git.next, o('Next Git'))
  vim.keymap.set('n', '<F10>', i.node.navigate.git.prev, o('Prev Git'))
  -- 文件夹折叠/展开
  vim.keymap.set('n', 'zr', i.tree.expand_all, o('Expand'))
  local function collapse_all_keep_buffers()
    i.tree.collapse_all(true)
  end
  vim.keymap.set('n', 'zm', collapse_all_keep_buffers, o('Collapse: keep buffers'))
  vim.keymap.set('n', 'zM', i.tree.collapse_all, o('Collapse'))
end
require('nvim-tree').setup({
  sort_by = 'name',  -- 排序规则
  modified = {  -- 文件修改状态图标
    enable = true,  -- 启用
    show_on_dirs = true,  -- 文件夹内有文件改动时, 在文件夹上显示图标
    show_on_open_dirs = false,  -- 在已展开的文件夹显示图标
  },
  on_attach = my_on_attach,  -- 映射配置
  view = {  -- 窗口/缓存配置
    width = 32,  -- 窗口宽度
    side = 'left',  -- 靠边位置: left/right. 放左边可以显示超长文件名
    preserve_window_proportions = false,  -- 文件变动时更新窗口长宽
    signcolumn = 'yes',  -- 标志列
  },
  renderer = {  -- UI渲染配置
    add_trailing = true,  -- 文件夹末尾加斜线
    group_empty = true,  -- 文件夹内只有一个文件夹时合并展示
    full_name = true,  -- 文件名长度超出窗口宽度时继续显示
    highlight_git = false,  -- 高亮显示文件git状态
    highlight_opened_files = 'name',  -- 高亮显示已打开的文件
    highlight_modified = 'name',  -- 高亮显示已修改的文件
    indent_width = 2,  -- 缩进宽度
    indent_markers = {  -- 缩进标志显示
      enable = true,  -- 启用
    },
    icons = {  -- 图标配置
      show = {  -- 显示的图标类型配置
        file = false,  -- 文件
        folder = false,  -- 文件夹
        folder_arrow = false,  -- 文件夹节点显示箭头
        git = true,  -- Git状态
        modified = true,  -- 文件修改状态
      },
      symlink_arrow = ' ∞ ',  -- 软链接指向图标
      glyphs = {
        symlink = '',  -- 软链接图标
      },
      git_placement = 'signcolumn',  -- 将git状态标志放在标志列显示
      modified_placement = 'after',  -- 将修改状态标志放在文件末尾显示
    },
    special_files = {  -- 需要高亮的特殊文件, 使用高亮方案: NvimTreeSpecialFile
      'Cargo.toml', 'Makefile', 'README.md', 'readme.md',
    },
    symlink_destination = true,  -- 显示软链接目标
  },
  filters = {  -- 过滤器配置
    dotfiles = true,  -- 不显示隐藏文件. 按'H'切换
  },
  actions = {  -- 各种处理配置
    file_popup = {  -- 文件弹窗
      open_win_config = {  -- 浮动窗口
        border = 'rounded',  -- 边框样式. rounded:圆角
      },
    },
    open_file = {  -- 打开文件
      window_picker = {  -- 窗口选择器
        enable = true,  -- 启用
      },
    },
  },
})
-- }

