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
  -- A list of parser names { 'c', 'lua', 'rust' }
  ensure_installed = {
    'c', 'cpp', 'make', 'cmake',
    'go', 'gomod', 'java', 'kotlin', 'rust',
    'vue', 'html', 'javascript', 'typescript', 'css', 'scss',
    'vim', 'vimdoc', 'lua', 'python', 'sql',
    'ini', 'toml', 'json', 'properties', 'xml', 'yaml',
    'git_config', 'gitignore', 'dockerfile', 'ssh_config',
    'csv', 'markdown', 'todotxt',
  },
  sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ignore_install = { }, -- List of parsers to ignore installing (for 'all')
  highlight = { -- 基于TreeSitter的代码高亮。
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
  indent = {  -- 基于TreeSitter的代码格式化。使用原生方式(=)触发格式化
    enable = true,
  },
}
-- }
-- nvim-tree.lua {
-- 在启动时禁用NeoVim自带文件管理器插件netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local nvim_tree_setup = {
  sort_by = 'name',  -- 排序规则
  sync_root_with_cwd = true,  -- 切换全局工作目录时, NvimTree同步切换
  modified = {  -- 文件修改状态图标
    enable = true,  -- 启用
    show_on_dirs = true,  -- 文件夹内有文件改动时, 在文件夹上显示图标
    show_on_open_dirs = false,  -- 在已展开的文件夹显示图标
  },
  on_attach = function(nr)  -- 自定义映射配置
    local api = require('nvim-tree.api')
    local function opts(d)
      return { desc = 'nvim-tree: ' .. d, buffer = nr, noremap = true, silent = true, nowait = true, }
    end
    -- api.config.mappings.default_on_attach(nr)  -- 载入默认映射
    -- Edit
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('[Edit] Open'))
    vim.keymap.set('n', ';', api.node.run.cmd, opts('[Edit] Run Command'))
    vim.keymap.set('n', 'i', api.node.show_info_popup, opts('[Edit] Info'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('[Edit] Copy Absolute Path'))
    -- Jump
    vim.keymap.set('n', '<C-h>', api.node.navigate.parent_close, opts('[Jump] Close Directory'))
    vim.keymap.set('n', '<C-h>', api.node.navigate.parent, opts('[Jump] Parent Directory'))
    vim.keymap.set('n', '<C-n>', api.node.navigate.opened.next, opts('[Jump] Next Sibling'))
    vim.keymap.set('n', '<C-p>', api.node.navigate.opened.prev, opts('[Jump] Previous Sibling'))
    vim.keymap.set('n', '<F9>', api.node.navigate.git.next, opts('[Jump] Next Git'))
    vim.keymap.set('n', '<F10>', api.node.navigate.git.prev, opts('[Jump] Prev Git'))
    -- Tree
    vim.keymap.set('n', 'zm', function() api.tree.collapse_all(true) end, opts('[Tree] Collapse: keep buffers'))
    vim.keymap.set('n', 'zM', api.tree.collapse_all, opts('[Tree] Collapse'))
    vim.keymap.set('n', 'zr', api.tree.expand_all, opts('[Tree] Expand'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('[Tree] Help'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('[Tree] Help'))
    vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('[Tree] Toggle Filter: Dotfiles'))
    vim.keymap.set('n', 'gi', api.tree.toggle_gitignore_filter, opts('[Tree] Toggle Filter: Git Ignore'))
    vim.keymap.set('n', '<C-r>', api.tree.reload, opts('[Tree] Refresh'))
    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('[Tree] CD'))
    -- File control
    vim.keymap.set('n', 'o', api.fs.create, opts('[File] Create File Or Directory'))
    vim.keymap.set('n', 'r', api.fs.rename_full, opts('[File] Rename: Full Path'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('[File] Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('[File] Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('[File] Paste'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('[File] Delete'))
  end,
  view = {  -- 窗口/缓存配置
    width = 32,  -- 窗口宽度
    side = 'left',  -- 靠边位置: left/right. 放左边可以显示超长文件名
    preserve_window_proportions = true,  -- 打开文件时保留窗口比例
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
    git_ignored = true, -- 不显示gitignore的文件. 切换接口: toggle_gitignore_filter
    dotfiles = true,  -- 不显示隐藏文件. 切换接口: toggle_hidden_filter
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
    change_dir = {
      enable = true,  -- 允许切换工作目录
      global = true,  -- NvimTree切换工作目录时, 同时切换全局目录
    },
  },
  help = {
    sort_by = 'desc',
  },
}
require('nvim-tree').setup(nvim_tree_setup)
vim.keymap.set('n', '<leader>ff', function()  -- 在NvimTree中定位当前文件
  vim.cmd('NvimTreeFindFile')
end)
-- NvimTree相关自动命令
local nvim_tree_augroup = vim.api.nvim_create_augroup('nvim-tree settings', { clear = true })
vim.api.nvim_create_autocmd({'BufEnter', 'BufLeave'}, {
  group = nvim_tree_augroup,
  callback = function(ev) -- 进入和退出NvimTree时自动调整宽度
    if vim.bo.filetype == 'NvimTree' then
      vim.api.nvim_win_set_width(0, nvim_tree_setup.view.width)
    end
  end
})
-- }

