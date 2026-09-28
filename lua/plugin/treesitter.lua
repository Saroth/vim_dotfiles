M = {}

local opts = {
  ensure_installed = {
    'c', 'cpp', 'make', 'cmake', 'bash',
    'go', 'gomod', 'java', 'kotlin', 'rust',
    'vue', 'html', 'javascript', 'typescript', 'css', 'scss',
    'vim', 'vimdoc', 'lua', 'python', 'sql',
    'ini', 'toml', 'json', 'properties', 'xml', 'yaml',
    'git_config', 'gitignore', 'dockerfile', 'ssh_config',
    'csv', 'markdown', 'markdown_inline', 'todotxt',
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = function(lang, buf)
      -- 只对超大文件禁用高亮, 不再按语言过滤
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

function M.setup()
  -- lockfile 里的 sql revision 过旧, 缺 create_policy 等节点,
  -- 导致 aerial.scm 报 Invalid node type; 锁定到 gh-pages 最新提交
  local sql = require('nvim-treesitter.parsers').list.sql
  sql.install_info.revision = '39fdb006403747241244326e8af3b3e96b85381c'

  require('nvim-treesitter').setup(opts)

  -- v0.10.0 移除了旧模块系统, 需手动启动 treesitter 高亮
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and pcall(vim.treesitter.language.inspect, lang) then
        vim.treesitter.start(args.buf)
      end
    end,
  })
  -- Markdown 折叠: 基于 treesitter 按标题层级折叠
  -- XXX: 使用 @queries/markdown/folds.scm 优化折叠效果，去除遗留空行
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

M.spec = {
  'nvim-treesitter/nvim-treesitter',
  tag = 'v0.10.0', -- 兼容 nvim 0.11
  build = ':TSUpdateSync',
  lazy = false,
  priority = 1000,
  config = M.setup,
}

return M
