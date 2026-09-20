M = {}

function M.setup()
  local peek = require('peek')
  peek.setup({
    auto_load = false,
    close_on_bdelete = true,
    syntax = true,
    theme = 'dark',
    update_on_change = true,
    app = 'browser',
  })
  vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
  vim.api.nvim_create_user_command('PeekClose', peek.close, {})
end

local setup = M.setup

M.spec = {
  'toppair/peek.nvim',
  build = vim.fn.executable('deno') == 1 and 'deno task --quiet build:fast' or nil,
  ft = 'markdown',
  config = setup,
}

return M