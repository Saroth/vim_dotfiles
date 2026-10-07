M = {}

M.spec = {
  'folke/todo-comments.nvim',
  event = 'BufReadPost',
  dependencies = { 'nvim-lua/plenary.nvim' },
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
      WARN = { color = 'warning' },
    },
    highlight = {
      -- 默认要求关键词后带冒号, 放宽为任意单词边界 (\v 模式下 > 是词后界)
      pattern = [[.*<(KEYWORDS)>]],
      -- 默认 "wide" 在关键词位于行尾时 end_col=finish+1 越界 (上游 1.5.0 未修), 改用 bg
      keyword = 'bg',
    },
  },
}

return M
