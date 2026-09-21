M = {}

M.setup = function()
  require('markdown').setup({})
end

M.spec = {
  'tadmccorkle/markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = M.setup,
}

return M
