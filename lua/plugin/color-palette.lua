-- xterm 256 调色板，参考 guns/xterm-color-table.vim 的纯 Lua 实现
M = {}

local name = '__XtermColorPalette__'
local cell_w = 12 -- ' %3d %7s'

-- 0-15 系统色，16-231 6x6x6 色立方，232-255 灰阶
local sys = {
  '#000000', '#800000', '#008000', '#808080', '#000080', '#800080', '#008080', '#c0c0c0',
  '#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff',
}
local levels = { 0, 95, 135, 175, 215, 255 }

local function hex(n)
  if n < 16 then
    return sys[n + 1]
  elseif n < 232 then
    local i = n - 16
    return string.format('#%02x%02x%02x',
      levels[math.floor(i / 36) + 1],
      levels[math.floor(i / 6) % 6 + 1],
      levels[i % 6 + 1])
  else
    local v = 8 + (n - 232) * 10
    return string.format('#%02x%02x%02x', v, v, v)
  end
end

local ns = vim.api.nvim_create_namespace(name)

local function fill(bufnr)
  vim.bo[bufnr].modifiable = true
  vim.bo[bufnr].readonly = false
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local lines, spans = {}, {}

  -- 生成一行色块; 序号段开头的空格不高亮
  local function add_row(nums)
    local lnum = #lines
    local cells = {}
    for c, n in ipairs(nums) do
      local h = hex(n)
      cells[#cells + 1] = string.format(' %3d %7s', n, h)
      -- 亮色用黑字，暗色用白字
      local sum = tonumber(h:sub(2, 3), 16) + tonumber(h:sub(4, 5), 16) + tonumber(h:sub(6, 7), 16)
      spans[#spans + 1] = { lnum, (c - 1) * cell_w + 1, c * cell_w, n, h, sum > 0xff * 1.5 }
    end
    lines[#lines + 1] = table.concat(cells)
  end

  -- [start, last] 每行 cols_per 个色号
  local function add_rows(start, last, cols_per)
    for first = start, last, cols_per do
      local nums = {}
      for n = first, math.min(first + cols_per - 1, last) do
        nums[#nums + 1] = n
      end
      add_row(nums)
    end
  end

  add_rows(0, 15, 8)
  lines[#lines + 1] = ''
  add_rows(16, 231, 6)
  lines[#lines + 1] = ''
  add_rows(232, 255, 6)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  for _, s in ipairs(spans) do
    -- s = { row, start, end, n, hex, bright }
    local hl = ('XtermPalette%d'):format(s[4])
    vim.api.nvim_set_hl(0, hl, { bg = s[5], fg = s[6] and '#000000' or '#ffffff' })
    vim.api.nvim_buf_add_highlight(bufnr, ns, hl, s[1], s[2], s[3])
  end
  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].readonly = true
end

function M.setup()
  vim.api.nvim_create_user_command('XtermColorPalette', function()
    vim.cmd('split') -- 水平分割
    local bufnr = vim.fn.bufnr(name)
    -- :bd 只卸载不清名，残留的未加载 buffer 彻底删掉重建
    if bufnr ~= -1 and not vim.api.nvim_buf_is_loaded(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
      bufnr = -1
    end
    if bufnr == -1 then
      bufnr = vim.api.nvim_create_buf(true, true)
      vim.api.nvim_buf_set_name(bufnr, name)
      vim.bo[bufnr].bufhidden = 'hide'
      fill(bufnr)
    elseif vim.api.nvim_buf_line_count(bufnr) <= 1 then
      fill(bufnr) -- 被 :e 清空后重建
    end
    vim.api.nvim_set_current_buf(bufnr)
  end, { desc = '水平分割打开 xterm 256 调色板' })

  -- nofile buffer 上 :e 触发的是 BufReadCmd（BufNewFile 不会），清空后在此重建
  vim.api.nvim_create_autocmd('BufReadCmd', {
    pattern = name,
    callback = function(args)
      fill(args.buf)
    end,
  })
end

return M
