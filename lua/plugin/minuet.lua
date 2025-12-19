M = {}
M.repo = {
  'milanglacier/minuet-ai.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = true
}

function M:setup()
  require('minuet').setup({
    provider='claude',
    provider_options = {
      claude = {
        max_tokens = 256,
        stream = true,
        end_point = 'https://api.xiaomimimo.com/anthropic',
        api_key = 'ANTHROPIC_API_KEY',
        model = 'mimo-v2-flash',
      }
    }
  })
end

return M

