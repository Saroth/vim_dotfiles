M = {}

local function my_on_attach(nr)
  -- 自定义映射配置
  local api = require('nvim-tree.api')
  local function opts(d)
    return { desc = 'nvim-tree: ' .. d, buffer = nr, noremap = true, silent = true, nowait = true, }
  end
  -- Edit
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('[Edit] Open'))
  vim.keymap.set('n', ';', api.node.run.cmd, opts('[Edit] Run Command'))
  vim.keymap.set('n', 'K', api.node.show_info_popup, opts('[Edit] Info'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('[Edit] Copy Absolute Path'))
  -- Jump
  vim.keymap.set('n', '<C-h>', api.node.navigate.parent_close, opts('[Jump] Close Directory'))
  vim.keymap.set('n', '<C-h>', api.node.navigate.parent, opts('[Jump] Parent Directory'))
  vim.keymap.set('n', '<C-n>', api.node.navigate.opened.next, opts('[Jump] Next Sibling'))
  vim.keymap.set('n', '<C-p>', api.node.navigate.opened.prev, opts('[Jump] Previous Sibling'))
  vim.keymap.set('n', 'gn', api.node.navigate.git.next, opts('[Jump] Next Git'))
  vim.keymap.set('n', 'gp', api.node.navigate.git.prev, opts('[Jump] Prev Git'))
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
  -- gO: 发送文件路径到 OpenCode
  vim.keymap.set('n', 'gO', function()
    local node = api.tree.get_node_under_cursor()
    if node and node.absolute_path then
      local path = vim.fn.fnamemodify(node.absolute_path, ":.")
      require("opencode").prompt(path .. " ")
    end
  end, opts('[OpenCode] Send file'))
  -- go: 发送文件到 Claude
  vim.keymap.set('n', 'go', '<cmd>ClaudeCodeTreeAdd<CR>', opts('[Claude] Send file'))
end

local nvim_tree_opts = {
  sort_by = 'name',
  sync_root_with_cwd = true,
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  on_attach = my_on_attach,
  view = {
    width = 32,
    side = 'left',
    preserve_window_proportions = true,
    signcolumn = 'yes',
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    full_name = true,
    highlight_git = false,
    highlight_opened_files = 'name',
    highlight_modified = 'name',
    indent_width = 2,
    indent_markers = { enable = true },
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
        modified = true,
      },
      symlink_arrow = ' ∞ ',
      glyphs = { symlink = '' },
      git_placement = 'signcolumn',
      modified_placement = 'after',
    },
    special_files = {
      'Cargo.toml', 'Makefile', 'README.md', 'readme.md',
    },
    symlink_destination = true,
  },
  filters = {
    git_ignored = true,
    dotfiles = true,
  },
  actions = {
    file_popup = {
      open_win_config = { border = 'rounded' },
    },
    open_file = {
      window_picker = { enable = true },
    },
    change_dir = {
      enable = true,
      global = true,
    },
  },
  help = { sort_by = 'desc' },
}

function M.setup()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  require('nvim-tree').setup(nvim_tree_opts)
  vim.keymap.set('n', '<leader>fc', '<cmd>NvimTreeFindFile<CR>')
  -- NvimTree相关自动命令
  local nvim_tree_augroup = vim.api.nvim_create_augroup('nvim-tree settings', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave' }, {
    group = nvim_tree_augroup,
    callback = function(_)
      if vim.bo.filetype == 'NvimTree' then
        vim.api.nvim_win_set_width(0, nvim_tree_opts.view.width)
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

local setup = M.setup

M.spec = {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  tag = vim.fn.has('nvim-0.10') == 0 and 'compat-nvim-0.9' or nil,
  config = setup,
}

return M