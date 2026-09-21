M = {}

local opts = {
  check_ts = true, -- 使用 treesitter 检测
  ts_config = {
    lua = { 'string' },
    javascript = { 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  fast_wrap = {
    map = '<M-e>', -- Alt+e 快速包裹
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0,
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
}

function M.setup()
  local npairs = require('nvim-autopairs')
  npairs.setup(opts)

  -- 和 coc.nvim 补全集成
  local coc_ok, coc = pcall(require, 'nvim-autopairs.completion.coc')
  if coc_ok then
    npairs.add_rule(coc)
  end
end

M.spec = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = M.setup,
}

return M
