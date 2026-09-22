M = {}

M.spec = {
  'numToStr/Comment.nvim',
  event = 'BufReadPost',
  -- 默认键位: gcc/gc 行注释, gbc/gb 块注释, gcO/gcA 前后补行
  opts = {},
}

return M
