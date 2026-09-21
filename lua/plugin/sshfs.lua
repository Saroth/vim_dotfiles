M = {}

local opts = {
  connections = {
    ssh_configs = {
      "~/.ssh/config",
      "/etc/ssh/ssh_config",
    },
    sshfs_options = {
      reconnect = true,
      ConnectTimeout = 5,
      compression = "yes",
      ServerAliveInterval = 15,
      ServerAliveCountMax = 3,
      dir_cache = "yes",
      dcache_timeout = 300,
      dcache_max_size = 10000,
    },
    control_persist = "10m",
    socket_dir = vim.fn.expand("$HOME/.ssh/sockets"),
  },
  mounts = {
    base_dir = vim.fn.expand("$HOME") .. "/mnt",
  },
  global_paths = {},
  host_paths = {},
  hooks = {
    on_exit = {
      auto_unmount = true,
      clean_mount_folders = true,
    },
    on_mount = {
      auto_change_to_dir = false,
      auto_run = "find",
    },
  },
  ui = {
    local_picker = {
      preferred_picker = "auto",
      fallback_to_netrw = true,
      netrw_command = "Explore",
    },
    remote_picker = {
      preferred_picker = "auto",
    },
  },
  lead_prefix = "<leader>m",
  keymaps = {
    mount = "<leader>mm",
    unmount = "<leader>mu",
    unmount_all = "<leader>mU",
    explore = "<leader>me",
    change_dir = "<leader>md",
    command = "<leader>mo",
    config = "<leader>mc",
    reload = "<leader>mr",
    files = "<leader>mf",
    grep = "<leader>mg",
    terminal = "<leader>mt",
  },
}

function M.setup()
  require("sshfs").setup(opts)
end

M.spec = {
  "uhs-robert/sshfs.nvim",
  config = M.setup,
}

return M
