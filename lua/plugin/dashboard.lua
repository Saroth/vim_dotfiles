M = {}
M.repo = {
  'nvimdev/dashboard-nvim',
  -- event = 'VimEnter',
  config = function()
    require('dashboard').setup(config)
  end,
  requires = { 'nvim-tree/nvim-web-devicons' }
}

local config = {
  theme = 'hyper', -- theme is doom and hyper default is hyper
  disable_move, --  default is false disable move keymap for hyper
  shortcut_type = 'letter', --  shorcut type 'letter' or 'number'
  change_to_vcs_root, -- default is false,for open file in hyper mru. it will change to the root of vcs
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        desc = 'Update',
        group = '@property',
        action = 'Lazy update',
        key = 'u'
      }, {
        icon = '',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      }, {
        desc = 'Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      }, {
        desc = 'dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
    },
  },
  hide = {
    statusline, -- hide statusline default is true
    tabline, -- hide the tabline
    winbar, -- hide winbar
  },
  preview = {
    command, -- preview command
    file_path, -- preview file path
    file_height, -- preview file height
    file_width, -- preview file width
  },
}

function M:setup()
  local status, db = pcall(require, "dashboard")
  if not status then
    vim.notify("No dashboard!")
    return
  end
  require('dashboard').setup(config)
end

return M

