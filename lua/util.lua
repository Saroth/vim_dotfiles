M = {}

function M.hl(group, fg, ...)
  vim.call('theme#hl', group, fg, ...)
end

return M

