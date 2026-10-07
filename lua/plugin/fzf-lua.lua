M = {}

local opts = {
  winopts = {
    preview = { layout = 'vertical' },
  },
  files = {
    file_icons = false,
  },
  grep = {
    file_icons = false,
    -- 半页翻页, 避免误触默认的 git hunks 动作(会直接退出 fzf);
    -- ctrl-u 保留默认的 unix-line-discard, ctrl-f/b 默认已有翻页
    keymap = {
      fzf = {
        ['ctrl-d'] = 'half-page-down',
      },
    },
  },
}

function M.setup()
  local fzf = require('fzf-lua')
  -- git 日志：ctrl-h/l 进入下一级/返回；翻页同 vim（f/b 整页，d/u 半页）
  local gd = require('fzf-lua.config').defaults.git
  local page = {
    ['ctrl-f'] = 'page-down',
    ['ctrl-b'] = 'page-up',
    ['ctrl-d'] = 'half-page-down',
    ['ctrl-u'] = 'half-page-up',
  }
  opts.git = {
    commits = {
      actions = {
        ['ctrl-l'] = gd.commits.actions['ctrl-d'],
        -- 顶层没有可返回的目标，同默认 ctrl-q：退出 picker
        ['ctrl-h'] = require('fzf-lua.actions').dummy_abort,
        ['ctrl-d'] = false,
      },
      keymap = { fzf = vim.tbl_extend('force', {}, page) },
    },
    diff = {
      actions = {
        ['ctrl-l'] = gd.diff.actions['ctrl-d'],
        ['ctrl-h'] = gd.diff.actions['ctrl-q'],
        ['ctrl-d'] = false,
      },
      keymap = { fzf = vim.tbl_extend('force', {}, page) },
    },
    hunks = {
      actions = {
        ['ctrl-h'] = gd.hunks.actions['ctrl-q'],
      },
      keymap = { fzf = vim.tbl_extend('force', {}, page) },
    },
  }
  fzf.setup(opts)
  -- 文件搜索
  vim.keymap.set('n', '<leader>ff', fzf.files)
  -- 搜索光标下的单词
  vim.keymap.set('n', '<leader>fG', fzf.grep)
  vim.keymap.set('n', '<leader>fg', fzf.grep_cword)
  vim.keymap.set('v', '<leader>fg', fzf.grep_visual)
  -- 恢复上次搜索
  vim.keymap.set('n', '<leader>fr', fzf.resume)
  -- 切换 fzf 窗口
  vim.keymap.set('n', '<leader>fb', fzf.builtin)
end

M.spec = {
  'ibhagwan/fzf-lua',
  event = 'BufReadPost',
  config = M.setup,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

return M
