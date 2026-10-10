M = {}

-- 引导安装 lazy.nvim
function M:init()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git', 'clone', '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', lazypath,
    })
    self.init_res = true
  end
  vim.opt.rtp:prepend(lazypath)
end

-- lazy.nvim 配置选项
local opts = {
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = false }, -- 不自动检查更新
  change_detection = { enabled = false }, -- 不自动检测配置变更
  performance = {
    rtp = {
      -- 不重置 runtimepath, 保留 vim-plug 管理的插件路径
      reset = false,
    },
  },
}

-- 设置插件 spec 列表
function M:set_specs(specs)
  self.specs = specs
end

-- 启动 lazy.nvim
function M:setup()
  require('lazy').setup(self.specs, opts)
  -- lazy 会把插件路径排到用户配置之前, 使 queries/ 下的用户查询被插件默认版遮蔽
  -- (rtp 中第一个不带 ; extends 的文件为生效查询, 其余丢弃), 置顶恢复标准覆盖顺序
  vim.opt.rtp:prepend(vim.fn.stdpath('config'))
end

return M
