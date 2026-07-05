M = {}
M.repo = {
  "nickjvandyke/opencode.nvim",
  version = "*",
}

function M:setup()
  require("opencode").setup({
    -- MiMoCode 二进制名，确保在 $PATH 中或写绝对路径
    -- cmd = "/usr/local/bin/mimo",
    cmd = "mimo",
    width = 0.38, -- 侧边栏宽度比例 (0~1)
    -- 是否在打开时自动聚焦 Agent 面板
    auto_focus = true,
    send_context = { -- 向 Agent 发送上下文时的行为
      include_buffer = true,   -- :OpenCodeAdd 加入当前 buffer
      include_selection = true, -- visual mode 发送选区
    },
    -- diff 快捷键前缀（Accept / Deny 由 opencode TUI 处理）
    -- keymaps = {
    --   toggle = "<leader>ac",      -- 开关侧边栏
    --   focus  = "<leader>af",      -- 聚焦侧边栏
    --   add_buf = "<leader>ab",     -- 添加当前文件到对话
    --   send_sel = "<leader>as",    -- [v]模式发送选区
    --   accept_diff = "<leader>aa", -- Accept diff（需 TUI 内操作或通过 snacks）
    --   deny_diff  = "<leader>ad",  -- Deny diff
    -- },
  }),
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    pattern = "*",
    command = "checktime",
  })
end


return M
