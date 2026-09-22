M = {}

local opts = {
  filetype = { '*.md' },
  options = {
    insert = true,           -- 输入 | 时自动格式化
    insert_leave = true,     -- 退出插入模式时自动格式化
    pad_separator_line = false,
    alig_style = 'default',  -- default | left | center | right
  },
}

function M.setup()
  require('markdown-table-mode').setup(opts)
end

-- Usage:
--   输入 | 或退出插入模式时自动对齐表格
--   :Mtm  开/关 markdown table mode

M.spec = {
  'Kicamon/markdown-table-mode.nvim',
  ft = { 'markdown' },
  config = M.setup,
}

return M