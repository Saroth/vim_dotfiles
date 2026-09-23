M = {}

-- 快捷递增输入: Ctrl-V 可视块选中多行首列后执行递增
--   :I :II 十进制(II 可带步长)   :IO :IIO 八进制   :IR :IIR 罗马数字   :IX 十六进制
--   :IMDY 日期  :ID 星期  :IM 月份  :IA 字母  :IPOW 幂(默认倍增)
--   加 R 前缀为递减, 如 :RI :RIR :RIX

M.spec = {
  'vim-scripts/Visincr',
  event = 'BufReadPost',
}

return M
