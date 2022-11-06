-- Install:
--    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--        $VIM/pack/packer/start/packer.nvim

-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins
end)
-- end,
-- config = {
--   snapshot_path = join_paths(stdpath 'cache', 'packer.nvim'),
--   package_root = util.join_paths(vim.env.VIM, 'pack'),
-- }})


