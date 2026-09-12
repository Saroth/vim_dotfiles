M = {}
M.repo = {
  "nickjvandyke/opencode.nvim",
  version = "*",
  requires = {
    "nvim-lua/plenary.nvim",   -- 依赖
    "folke/snacks.nvim",       -- snacks.nvim 可选但推荐（浮动终端/通知）
  },
}

function M:setup()
  -- 自动发现 server 端口
  -- 优先级：环境变量 > 工程路径匹配 > 默认端口
  local function discover_server(callback)
    -- 1. 优先使用环境变量
    local env_port = vim.env.OPENCODE_PORT
    if env_port then
      callback("http://localhost:" .. env_port)
      return
    end

    -- 2. 发现所有服务，匹配当前工程路径
    local nvim_cwd = vim.fn.getcwd()
    local handle = io.popen("lsof -iTCP -sTCP:LISTEN -P -n 2>/dev/null | grep '.mimocode.*LISTEN'")
    if handle then
      local output = handle:read("*a")
      handle:close()

      for line in output:gmatch("[^\n]+") do
        local pid = line:match("^%S+%s+(%d+)")
        local port = line:match(":(%d+) %(LISTEN%)")
        if pid and port then
          -- 获取进程的工作目录
          local cwd_link = vim.fn.resolve("/proc/" .. pid .. "/cwd")
          if cwd_link and cwd_link ~= "" then
            -- 检查是否匹配当前工程路径
            if nvim_cwd:find(cwd_link, 1, true) or cwd_link:find(nvim_cwd, 1, true) then
              callback("http://localhost:" .. port)
              return
            end
          end
        end
      end
    end

    -- 3. 如果没有匹配的，使用默认端口
    callback("http://localhost:4096")
  end

  vim.g.opencode_opts = {
    server = {
      url = discover_server,  -- 动态发现 server
      start = false,  -- 禁用自动启动，手动管理 server
    },
  }

  vim.o.autoread = true -- Required for vim.g.opencode_opts.events.reload

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
      ---@type opencode.server.Event
      local event = args.data.event

      if event.type == "server.heartbeat" then
        return -- 忽略 heartbeat 事件，避免频繁弹出通知
      end
      -- 处理其他有用的事件
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


return M
