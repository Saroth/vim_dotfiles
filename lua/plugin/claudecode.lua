M = {}
M.repo = {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
}

function M:setup()
  require("claudecode").setup({
    auto_start = true,
    terminal = {
      -- none: 不在编辑器内打开窗口, 通过外部终端运行 claude,
      --       需在外部终端执行 claude --ide 或 /ide 连接编辑器.
      provider = "none",
    },
  })

  -- go: 发送到 Claude (normal=当前行, visual=选区内容)
  vim.keymap.set("n", "go", function()
    vim.cmd("normal! V")
    vim.cmd("'<,'>ClaudeCodeSend")
  end, { desc = "Claude: 发送当前行" })
  vim.keymap.set("x", "go", "<cmd>ClaudeCodeSend<CR>", { desc = "Claude: 发送选区" })

  -- Claude 修改文件后自动刷新 buffer
  vim.o.autoread = true
  -- diff 关闭时立即刷新所有 buffer
  vim.api.nvim_create_autocmd("User", {
    pattern = "ClaudeCodeDiffClosed",
    callback = function() vim.cmd("checktime") end,
  })
  -- 光标停留时检测外部文件变更 (覆盖 Claude 非 diff 直接写文件的场景)
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function() vim.cmd("checktime") end,
  })
end

return M

