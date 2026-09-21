-- -- 代理配置: treesitter 下载 parser 源码需要
-- vim.env.HTTPS_PROXY = vim.env.HTTPS_PROXY or 'http://winhost:10808'
-- vim.env.HTTP_PROXY = vim.env.HTTP_PROXY or 'http://winhost:10808'

local plugins = {
  'lazy', -- lazy.nvim 自身引导
  'nvimtree',
  'treesitter',
  'markdown',
  'render-markdown',
  'aerial',
  'claudecode',
  'opencode',
  'sshfs',
  'coc',
  'autopairs',
  'rainbow-delimiters',
  'highlight-colors',
}

-- Phase 1: 加载模块并执行 init()
local modules = {}
for i = 1, #plugins do
  modules[i] = require('plugin/' .. plugins[i])
  if modules[i].init then modules[i]:init() end
end

-- Phase 2: 收集所有插件 spec
local specs = {}
for i = 1, #modules do
  if modules[i].spec then
    specs[#specs + 1] = modules[i].spec
  end
end
modules[1]:set_specs(specs) -- lazy.lua

-- Phase 3: 统一调用各插件的 setup()
-- 懒加载插件由 lazy.nvim 的 spec.config 延迟调用, 此处跳过
for i = 1, #modules do
  if modules[i].setup then
    local spec = modules[i].spec
    if not spec or not spec.ft then
      modules[i]:setup()
    end
  end
end
