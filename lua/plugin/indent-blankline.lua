M = {}

local highlight = {
  "IndentBgLight",
  "IndentBgDark",
}

local opts = {
  indent = {
    highlight = highlight,
    char = "",
  },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
}

function M.setup()
  local hooks = require 'ibl.hooks'
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'IndentBgLight', { bg = '#262626' })
    vim.api.nvim_set_hl(0, 'IndentBgDark',  { bg = '#303030' })
  end)
  require('ibl').setup(opts)
end

M.spec = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufReadPost',
  config = M.setup,
}

return M
