M = {}

function M.setup()
  require("claudecode").setup({
    auto_start = true,
    terminal = {
      provider = "none",
    },
    diff_opts = {
      open_in_new_tab = true,
    },
  })

  -- 键位映射配置
  vim.keymap.set("n", "go", function()
    vim.cmd("normal! V")
    vim.cmd("'<,'>ClaudeCodeSend")
  end, { desc = "Claude: 发送当前行" })
  vim.keymap.set("x", "go", "<cmd>ClaudeCodeSend<CR>", { desc = "Claude: 发送选区" })

  -- Claude 修改文件后自动刷新 buffer
  vim.o.autoread = true
  vim.api.nvim_create_autocmd("User", {
    pattern = "ClaudeCodeDiffClosed",
    callback = function() vim.cmd("checktime") end,
  })
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function() vim.cmd("checktime") end,
  })
end

local setup = M.setup

M.spec = {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = setup,
}

return M