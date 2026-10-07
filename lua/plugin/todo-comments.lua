M = {}

M.spec = {
  'folke/todo-comments.nvim',
  event = 'BufReadPost',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- lazy 推断不出 main, 显式调用 setup
  config = function(_, opts)
    require('todo-comments').setup(opts)
  end,
  opts = {
    colors = {
      -- 关键词配色: todo 类用主题黄, warn 类用主题橙 (WarningMsg)
      todo = { '#ffff00' }, -- 同 theme_yellow
      warning = { 'WarningMsg', '#df5f00' }, -- 同 theme_orange
    },
    keywords = {
      -- FIXME 是 FIX 的 alt, XXX/WARNING 是 WARN 的 alt, 随主项配色
      TODO = { color = 'todo' },
      FIX = { color = 'todo' },
      HACK = { color = 'todo' },
      WARN = { color = 'warning' },
    },
    highlight = {
      -- 默认要求关键词后带冒号, 放宽为任意单词边界 (\v 模式下 > 是词后界)
      pattern = [[.*<(KEYWORDS)>]],
    },
  },
}

return M
