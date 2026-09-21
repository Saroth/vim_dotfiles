M = {}

local opts = {
  highlight = {
    'RainbowDelimiterViolet',
    'RainbowDelimiterBlue',
    'RainbowDelimiterCyan',
    'RainbowDelimiterGreen',
    'RainbowDelimiterYellow',
    'RainbowDelimiterOrange',
    'RainbowDelimiterRed',
  },
}

function M.setup()
  require('rainbow-delimiters.setup').setup(opts)
end

M.spec = {
  'HiPhish/rainbow-delimiters.nvim',
  event = 'BufReadPost',
}

return M
