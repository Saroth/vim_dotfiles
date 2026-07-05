local plugins = {
  'packer', -- Packer manage itself
  'nvimtree',
  -- 'treesitter',
  -- 'claudecode',
  'opencode',
  -- 'minuet', -- 依赖nvim-cmp作为补全前端, nvim-cmp与coc同时使用存在冲突
  'sshfs',
}

local modules = {}
for i = 1, #plugins do
  modules[i] = require('plugin/'..plugins[i])
  if modules[i].init then modules[i]:init() end
end
require('packer').startup(function(use)
  for i = 1, #modules do
    if modules[i].repo then use(modules[i].repo) end
  end
  for i = 1, #modules do
    if modules[i].postload then modules[i]:postload() end
  end
end)
for i = 1, #modules do
  if modules[i].setup then modules[i]:setup() end
end

