-- XXX: 配置修改后需执行:PackerSync并重启

plugins = {
  'packer', -- Packer manage itself
  'nvimtree',
  'treesitter',
}

modules = {}
for i = 1, #plugins do
  modules[i] = require('plugins/'..plugins[i])
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

