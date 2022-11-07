-- Install:
--    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--        ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-- vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer manage itself
  use 'wbthomason/packer.nvim'

  -- nvim-treesitter    基于NeoVim内置treesiter的代码高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- nvim-tree.lua      文件管理器
  use { 'nvim-tree/nvim-tree.lua',
  requires = { 'nvim-tree/nvim-web-devicons', }} -- file icons
end)

-- nvim-treesitter {
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'java', 'javascript', 'python' }, -- A list of parser names { 'c', 'lua', 'rust' }
  sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ignore_install = { }, -- List of parsers to ignore installing (for 'all')

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = vim.env.VIM .. '/site', -- Remember to run vim.opt.runtimepath:append('/some/path/to/store/parsers')!
  highlight = {
    enable = true, -- `false` will disable the whole extension
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
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

