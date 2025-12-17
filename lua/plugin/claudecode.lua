M = {}
M.repo = {
  'coder/claudecode.nvim',
  dependencies = { "folke/snacks.nvim" },
}

function M:setup()
  require("claudecode").setup({
    -- 可选配置项
    auto_start = true, -- 自动启动
    terminal = {
      -- auto:  (默认) 自动打开命令行窗口. 退出TERMINAL模式: <c-\><c-n>
      -- none:  不打开窗口, 需要手动在其他控制台中执行: claude --ide,
      --        或者在Claude中执行/ide选择连接的编辑器.
      provider = "none",
    },
  })
  vim.keymap.set("n", "<leader>xc", "<cmd>ClaudeCodeToggle<CR>")
  vim.keymap.set("n", "<leader>xa", "<cmd>ClaudeCodeAsk<CR>")
end

return M

