M = {}

local opts = {
  render = 'background',
  enable_hex = true, ---Highlight hex colors, e.g. '#FFFFFF'
  enable_short_hex = true, ---Highlight short hex colors e.g. '#fff'
  enable_rgb = true, ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
  enable_hsl = true, ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
  enable_ansi = true, ---Highlight ansi colors, e.g '\033[0;34m'
  enable_xterm256 = true, ---Highlight xterm 256 (8bit) colors, e.g '\033[38;5;118m'
  enable_xtermTrueColor = true, ---Highlight xterm True Color (24bit) colors, e.g '\033[38;2;118;64;90m'
  enable_named_colors = true, ---Highlight named colors, e.g. 'green'
  enable_tailwind = true, ---Highlight tailwind colors, e.g. 'bg-blue-500'
}

function M.setup()
  require('nvim-highlight-colors').setup(opts)
end

M.spec = {
  'brenoprata10/nvim-highlight-colors',
  event = 'BufReadPost',
  config = M.setup,
}

return M
