M = {}

M.setup = function()
  require('markdown').setup({})
end

local setup = M.setup

M.spec = {
  'tadmccorkle/markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = setup,
}

return M