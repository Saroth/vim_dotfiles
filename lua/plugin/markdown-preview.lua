M = {}

function M.init()
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_auto_close = 1
  vim.g.mkdp_refresh_slow = 1
  vim.g.mkdp_browser = ''
  vim.g.mkdp_echo_preview_url = 1
  vim.g.mkdp_port = ''
  vim.g.mkdp_open_to_the_world = 1
  vim.g.mkdp_theme = 'light'
  vim.g.mkdp_preview_options = {
    uml = {
      server = 'http://47.93.4.73:51801',
      imageFormat = 'svg',
    },
  }
end

M.spec = {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = 'cd app && yarn install',
}

return M
