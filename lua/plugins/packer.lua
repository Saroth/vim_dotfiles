M = {}
M.repo = 'wbthomason/packer.nvim'
M.init_res = false

function M:init()
  -- 检查并自动安装Packer
  local f = vim.fn
  local packer_path = f.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if f.empty(f.glob(packer_path)) <= 0 then return end
  f.system({'git', 'clone', '--depth', '1',
  'https://github.com/wbthomason/packer.nvim', packer_path})
  self.init_res = true
end

function M:postload()
  if self.init_res then
    -- 初次安装后自动配置
    require('packer').sync()
  end
end

return M

