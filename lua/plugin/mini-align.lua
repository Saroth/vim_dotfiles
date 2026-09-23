M = {}

-- 代码对齐 (替换 vim-easy-align):
--   ga{motion} 交互对齐, 如 gaip 对齐当前段落; 可视模式下 ga 对齐选区
--   交互中输入修饰键调整: = 对齐=   , 对齐,   | 对齐|   空格 对齐空格
--   s 自定义分隔正则    j 切换对齐侧(左/右/中)    m 用分隔符合并
--   t 去除多余空格      f 按 Lua 表达式过滤       BS 撤销上一步预处理
--   <CR> 确认执行; gA 同 ga 但带实时预览
M.spec = {
  'nvim-mini/mini.align',
  event = 'BufReadPost',
  opts = {},
}

return M
