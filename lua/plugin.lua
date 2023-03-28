-- XXX: 配置修改后需执行:PackerSync并重启

-- Plugins init {
local ensure_packer = function()
  -- 检查并自动安装Packer
  local f = vim.fn
  local packer_path = f.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if f.empty(f.glob(packer_path)) <= 0 then
    return false
  end
  f.system({'git', 'clone', '--depth', '1',
  'https://github.com/wbthomason/packer.nvim', packer_path})
  return true
end
local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Packer manage itself
  use 'wbthomason/packer.nvim'
  -- nvim-treesitter    基于NeoVim内置treesiter的代码高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- nvim-tree.lua      文件管理器
  use { 'nvim-tree/nvim-tree.lua',
  requires = { 'nvim-tree/nvim-web-devicons', }} -- file icons

  --- After all plugins
  if packer_bootstrap then
    -- 初次安装后自动配置
    require('packer').sync()
  end
end)
-- }
-- nvim-treesitter配置 {
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'vim', 'help', 'java', 'javascript', 'python' }, -- A list of parser names { 'c', 'lua', 'rust' }
  sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ignore_install = { }, -- List of parsers to ignore installing (for 'all')
  highlight = {
    enable = true, -- 全局开关
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
}
-- }
-- nvim-tree.lua {
-- disable netrw at the every start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  view = {
    adaptive_size = false,  -- 自适应大小
    width = 32,  -- 固定宽度
    side = 'right',  -- 靠右
    preserve_window_proportions = true,
    number = false,
    signcolumn = 'no',
    mappings = {
      list = {
        { key = 'u', action = 'dir_up' },
      },
    },
  },
  renderer = {
    group_empty = true,
    add_trailing = false,
  },
  filters = {
    dotfiles = true,
  },
})
-- }

