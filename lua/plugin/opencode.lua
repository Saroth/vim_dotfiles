M = {}

-- 自动发现 server 端口
-- 优先级：环境变量 > 工程路径匹配 > 默认端口
local function discover_server(callback)
  local env_port = vim.env.OPENCODE_PORT
  if env_port then
    callback("http://localhost:" .. env_port)
    return
  end

  local nvim_cwd = vim.fn.getcwd()
  local handle = io.popen("lsof -iTCP -sTCP:LISTEN -P -n 2>/dev/null | grep '.mimocode.*LISTEN'")
  if handle then
    local output = handle:read("*a")
    handle:close()

    for line in output:gmatch("[^\n]+") do
      local pid = line:match("^%S+%s+(%d+)")
      local port = line:match(":(%d+) %(LISTEN%)")
      if pid and port then
        local cwd_link = vim.fn.resolve("/proc/" .. pid .. "/cwd")
        if cwd_link and cwd_link ~= "" then
          if nvim_cwd:find(cwd_link, 1, true) or cwd_link:find(nvim_cwd, 1, true) then
            callback("http://localhost:" .. port)
            return
          end
        end
      end
    end
  end

  callback("http://localhost:4096")
end

function M.setup()
  vim.g.opencode_opts = {
    server = {
      url = discover_server,
      start = false,
    },
  }

  vim.o.autoread = true

  -- gO: 发送到 OpenCode (normal=当前行, visual=选区)
  vim.keymap.set({ "n", "x" }, "gO", function()
    local op = require("opencode").operator("@this ")
    if vim.fn.mode() == "n" then
      return op .. "_"
    else
      return op
    end
  end, { desc = "Send to OpenCode", expr = true })

  -- Handle OpenCode events
  vim.api.nvim_create_autocmd("User", {
    pattern = "OpencodeEvent:*",
    callback = function(args)
      local event = args.data.event
      if event.type == "server.heartbeat" then
        return
      end
      if event.type == "session.status" then
        vim.notify("OpenCode status: " .. event.properties.status.type)
      elseif event.type == "file.edited" then
        vim.notify("OpenCode edited a file")
      elseif event.type == "permission.asked" then
        vim.notify("OpenCode requests permission: " .. event.properties.permission)
      end
    end,
  })
end

local setup = M.setup

M.spec = {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  config = setup,
}

return M