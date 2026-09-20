M = {}

function M.setup()
  require('nvim-treesitter').setup {
    ensure_installed = { 'markdown', 'markdown_inline' },
    sync_install = true,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = function(lang, buf)
        if lang ~= 'markdown' and lang ~= 'markdown_inline' then
          return true
        end
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
  }
  -- Markdown 折叠: 基于 treesitter 按标题层级折叠
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldlevel = 99 -- 默认展开所有折叠
    end,
  })

  -- 确保 markdown parser 已安装, 若未就绪则异步安装后触发 render-markdown
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      local function try_trigger_markdown()
        if pcall(vim.treesitter.language.inspect, 'markdown') then
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == 'markdown' and vim.api.nvim_buf_is_loaded(buf) then
              vim.api.nvim_exec_autocmds('FileType', { pattern = 'markdown', modeline = false })
              break
            end
          end
          return true
        end
        return false
      end
      if not try_trigger_markdown() then
        vim.cmd('TSInstall markdown markdown_inline')
        local timer = vim.uv.new_timer()
        timer:start(500, 500, vim.schedule_wrap(function()
          if try_trigger_markdown() then
            timer:stop()
            timer:close()
          end
        end))
      end
    end,
  })
end

local setup = M.setup

M.spec = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdateSync',
  lazy = false,
  priority = 1000,
  config = setup,
}

return M