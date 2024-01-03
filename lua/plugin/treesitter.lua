M = {}
M.repo = {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
}

function M:setup()
  require('nvim-treesitter.configs').setup {
    -- A list of parser names { 'c', 'lua', 'rust' }
    ensure_installed = {
      'c', 'cpp', 'make', 'cmake',
      'go', 'gomod', 'java', 'kotlin', 'rust',
      'vue', 'html', 'javascript', 'typescript', 'css', 'scss',
      'vim', 'vimdoc', 'lua', 'python', 'sql',
      'ini', 'toml', 'json', 'properties', 'xml', 'yaml',
      'git_config', 'gitignore', 'dockerfile', 'ssh_config',
      'csv', 'markdown', 'todotxt',
    },
    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    ignore_install = { }, -- List of parsers to ignore installing (for 'all')
    highlight = {
      enable = false, -- 启用基于TreeSitter的代码高亮. XXX: 已有Coc的语法高亮，不启用
      disable = { }, -- 禁用高亮的语言. NOTE: 此处填写解析器名, 而不是文件类型
      disable = function(lang, buf) -- 灵活控制. 不对大文件启用高亮
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,  -- 启用基于TreeSitter的代码格式化。使用原生方式(=)触发格式化
    },
  }
end

return M

