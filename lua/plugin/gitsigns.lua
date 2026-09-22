M = {}

local opts = {
  signs = {
    add          = { text = '+' },
    change       = { text = '!' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  signs_staged_enable = false,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = function(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', 'gn', gs.next_hunk)
    map('n', 'gp', gs.prev_hunk)
  end,
}

function M.setup()
  require('gitsigns').setup(opts)
  -- gitsigns-blame窗口设置固定宽度
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave' }, {
    callback = function()
      if vim.bo.filetype == 'gitsigns-blame'
        or vim.bo.filetype == 'gitsigns-diff' then
        vim.api.nvim_win_set_width(0, 40)
      end
    end,
  })
end

M.spec = {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  config = M.setup,
}

return M
