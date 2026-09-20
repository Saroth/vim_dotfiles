M = {}

local aerial_opts = {
  backends = { 'treesitter' },
  filter_kind = false,
  layout = {
    min_width = 32,
    max_width = 32,
  },
  highlight_on_jump = 800,
  nerd_font = false,
  show_guides = true, -- 用制表符/画线字符显示树的层级结构
}

function M.setup()
  require('aerial').setup(aerial_opts)
  -- 进入和退出 Aerial 窗口时自动调整宽度
  local aerial_augroup = vim.api.nvim_create_augroup('aerial settings', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave' }, {
    group = aerial_augroup,
    callback = function()
      if vim.bo.filetype == 'aerial' then
        vim.api.nvim_win_set_width(0, aerial_opts.layout.max_width)
      end
    end,
  })
end

local setup = M.setup

M.spec = {
  'stevearc/aerial.nvim',
  branch = 'nvim-0.11',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = setup,
}

return M
