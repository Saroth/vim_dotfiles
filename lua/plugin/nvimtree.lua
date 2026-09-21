M = {}

local function my_on_attach(nr)
  -- 自定义映射配置
  local api = require('nvim-tree.api')
  local function att(d)
    return { desc = 'nvim-tree: ' .. d, buffer = nr, noremap = true, silent = true, nowait = true, }
  end
  -- Edit
  vim.keymap.set('n', '<CR>', api.node.open.edit, att('[Edit] Open'))
  vim.keymap.set('n', ';', api.node.run.cmd, att('[Edit] Run Command'))
  vim.keymap.set('n', 'K', api.node.show_info_popup, att('[Edit] Info'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, att('[Edit] Copy Absolute Path'))
  -- Jump
  vim.keymap.set('n', '<C-h>', api.node.navigate.parent_close, att('[Jump] Close Directory'))
  vim.keymap.set('n', '<C-h>', api.node.navigate.parent, att('[Jump] Parent Directory'))
  vim.keymap.set('n', '<C-n>', api.node.navigate.opened.next, att('[Jump] Next Sibling'))
  vim.keymap.set('n', '<C-p>', api.node.navigate.opened.prev, att('[Jump] Previous Sibling'))
  vim.keymap.set('n', 'gn', api.node.navigate.git.next, att('[Jump] Next Git'))
  vim.keymap.set('n', 'gp', api.node.navigate.git.prev, att('[Jump] Prev Git'))
  -- Tree
  vim.keymap.set('n', 'zm', function() api.tree.collapse_all(true) end, att('[Tree] Collapse: keep buffers'))
  vim.keymap.set('n', 'zM', api.tree.collapse_all, att('[Tree] Collapse'))
  vim.keymap.set('n', 'zr', api.tree.expand_all, att('[Tree] Expand'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, att('[Tree] Help'))
  vim.keymap.set('n', '?', api.tree.toggle_help, att('[Tree] Help'))
  vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, att('[Tree] Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'gi', api.tree.toggle_gitignore_filter, att('[Tree] Toggle Filter: Git Ignore'))
  vim.keymap.set('n', '<C-r>', api.tree.reload, att('[Tree] Refresh'))
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, att('[Tree] CD'))
  -- File control
  vim.keymap.set('n', 'o', api.fs.create, att('[File] Create File Or Directory'))
  vim.keymap.set('n', 'r', api.fs.rename_full, att('[File] Rename: Full Path'))
  vim.keymap.set('n', 'x', api.fs.cut, att('[File] Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.node, att('[File] Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, att('[File] Paste'))
  vim.keymap.set('n', 'd', api.fs.remove, att('[File] Delete'))
  -- gO: 发送文件路径到 OpenCode
  vim.keymap.set('n', 'gO', function()
    local node = api.tree.get_node_under_cursor()
    if node and node.absolute_path then
      local path = vim.fn.fnamemodify(node.absolute_path, ":.")
      require("opencode").prompt(path .. " ")
    end
  end, att('[OpenCode] Send file'))
  -- go: 发送文件到 Claude
  vim.keymap.set('n', 'go', '<cmd>ClaudeCodeTreeAdd<CR>', att('[Claude] Send file'))
end

local opts = {
  sort_by = 'name',  -- 文件排序方式
  sync_root_with_cwd = true,  -- 树根目录同步当前工作目录
  modified = {
    enable = true,  -- 显示未保存修改状态
    show_on_dirs = true,  -- 父目录显示子文件修改标记
    show_on_open_dirs = false,  -- 展开目录不显示子文件修改标记
  },
  on_attach = my_on_attach,  -- 自定义按键映射
  view = {
    width = 32,  -- 侧边栏宽度
    side = 'left',  -- 树显示在左侧
    preserve_window_proportions = true,  -- 打开文件时保持窗口比例
    signcolumn = 'yes',  -- 始终显示标记列
  },
  renderer = {
    add_trailing = true,  -- 文件夹名末尾加斜杠
    group_empty = true,  -- 单文件夹压缩为一个节点
    full_name = true,  -- 浮动窗口显示完整文件名
    highlight_git = false,  -- 不高亮 git 状态
    highlight_opened_files = 'name',  -- 已打开文件高亮文件名
    highlight_modified = 'name',  -- 已修改文件高亮文件名
    indent_width = 2,  -- 每级缩进空格数
    indent_markers = { enable = true },  -- 显示缩进连接线
    icons = {
      show = {
        file = false,  -- 不显示文件图标
        folder = false,  -- 不显示文件夹图标
        folder_arrow = false,  -- 不显示文件夹箭头
        git = true,  -- 显示 git 状态图标
        modified = true,  -- 显示修改标记图标
      },
      symlink_arrow = ' ∞ ',  -- 符号链接箭头符号
      glyphs = { symlink = '' },  -- 符号链接图标
      git_placement = 'signcolumn',  -- git 图标放在标记列
      modified_placement = 'after',  -- 修改标记放在文件名后
    },
    special_files = {  -- 特殊文件高亮显示
      'Cargo.toml', 'Makefile', 'README.md', 'readme.md',
    },
    symlink_destination = true,  -- 显示符号链接目标路径
  },
  filters = {
    git_ignored = true,  -- 隐藏 .gitignore 忽略的文件
    dotfiles = true,  -- 隐藏点文件
  },
  actions = {
    file_popup = {
      open_win_config = { border = 'rounded' }, -- 文件信息弹窗圆角边框
    },
    open_file = {
      window_picker = { enable = true },  -- 多窗口时弹出窗口选择器
    },
    change_dir = {
      enable = true,  -- 导航时切换工作目录
      global = true,  -- 使用 :cd 而非 :lcd
    },
  },
  help = { sort_by = 'desc' },  -- 帮助按描述排序
}

function M.setup()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  require('nvim-tree').setup(opts)
  vim.keymap.set('n', '<leader>fc', '<cmd>NvimTreeFindFile<CR>')
  -- NvimTree相关自动命令
  local nvim_tree_augroup = vim.api.nvim_create_augroup('nvim-tree settings', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave' }, {
    group = nvim_tree_augroup,
    callback = function(_)
      if vim.bo.filetype == 'NvimTree' then
        vim.api.nvim_win_set_width(0, opts.view.width)
      end
    end,
  })
  -- 高亮配置
  local t = require('util')
  t.hl('NvimTreeNormal', vim.g.theme_lightgray1, vim.g.theme_darkgray3)
  t.hl('NvimTreeWindowPicker', vim.g.theme_white, vim.g.theme_darkgreen, 'bold')
  t.hl('NvimTreeSpecialFile', vim.g.theme_lightyellow, vim.g.theme_none)
  t.hl('NvimTreeFolderName', vim.g.theme_lightblue3, vim.g.theme_none, 'bold')
  t.hl('NvimTreeOpenedFolderName', vim.g.theme_lightblue3, vim.g.theme_none, 'bold,underline')
  t.hl('NvimTreeOpenedHL', vim.g.theme_wheaten1, vim.g.theme_none)
  t.hl('NvimTreeModifiedFileHL', vim.g.theme_red, vim.g.theme_none)
  t.hl('NvimTreeEmptyFolderName', vim.g.theme_gray, vim.g.theme_none, 'bold')
  t.hl('NvimTreeSymlink', vim.g.theme_lightblue2)
  t.hl('NvimTreeSymlinkFolderName', vim.g.theme_lightblue2, vim.g.theme_none, 'bold')
end

M.spec = {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  tag = vim.fn.has('nvim-0.10') == 0 and 'compat-nvim-0.9' or nil,
  config = M.setup,
}

return M
