M = {}

-- coc.nvim 扩展列表
local extensions = {
  'coc-vimlsp',
  'coc-sql',
  'coc-xml',
  'coc-html',
  'coc-css',
  'coc-eslint', -- 需要eslint: sudo npm install -g eslint
  'coc-tsserver',
  'coc-clangd', -- 需要clangd
  'coc-cmake',
  'coc-java', -- 自动安装jdtls
  'coc-go', -- 需要gotags/gopls. dnf install gotags golang-x-tools-gopls
  'coc-pyright', -- 需要pylint/jedi. pip3 install pylint jedi
  'coc-sumneko-lua', -- lua语法补全, 支持nvim接口补全
  'coc-snippets',
  'coc-db', -- 基于数据库的sql补全插件, 基于vim-dadbod
  'coc-vue',
  -- 'coc-highlight', -- 已禁用: 使用 treesitter 高亮
}

function M.init()
  -- 设置 coc 配置目录
  vim.g.coc_config_home = vim.fn.expand('$VIM/config')
end

function M.setup()
  -- 高亮配置
  local t = require('util')
  t.hl('CocFloating', vim.g.theme_none, vim.g.theme_darkgray2)
  t.hl('CocFloatThumb', vim.g.theme_none, vim.g.theme_gray)
  t.hl('CocFloatSbar', vim.g.theme_none, vim.g.theme_darkgray1)
  t.hl('CocFloatDividingLine', vim.g.theme_black)
  t.hl('CocFloatActive', vim.g.theme_none, vim.g.theme_gray)
  t.hl('CocErrorFloat', vim.g.theme_red)
  t.hl('CocHintFloat', vim.g.theme_lightblue0)
  t.hl('CocSemTypeTypeParameter', vim.g.theme_blue)
  t.hl('CocSemTypeParameter', vim.g.theme_lightblue2)
  t.hl('CocSemTypeVariable', vim.g.theme_lightgray1)
  t.hl('CocSemTypeAnnotation', vim.g.theme_darkgreen, vim.g.theme_none, 'bold')
  t.hl('CocSemTypeAnnotationMember', vim.g.theme_lightblue2)
  t.hl('CocSemTypeRecord', vim.g.theme_lightgreen0)
  t.hl('CocSemTypeRecordComponent', vim.g.theme_lightgray1)

  -- 补全配置
  vim.g.coc_snippet_next = '<tab>'

  -- 使用<tab>触发补全，切换补全项，切换片段输入点
  local function check_backspace()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  end

  vim.keymap.set('i', '<tab>', function()
    if vim.fn['coc#pum#visible']() == 1 then
      return vim.fn['coc#pum#next'](1)
    elseif check_backspace() then
      return '<tab>'
    else
      return vim.fn['coc#refresh']()
    end
  end, { expr = true, silent = true })

  vim.keymap.set('i', '<S-TAB>', function()
    if vim.fn['coc#pum#visible']() == 1 then
      return vim.fn['coc#pum#prev'](1)
    else
      return '<C-h>'
    end
  end, { expr = true, silent = true })

  -- 使用<CR>选中补全项
  vim.keymap.set('i', '<CR>', function()
    if vim.fn['coc#pum#visible']() == 1 then
      return vim.fn['coc#pum#confirm']()
    else
      return '<C-g>u<CR><c-r>=coc#on_enter()<CR>'
    end
  end, { expr = true, silent = true })

  -- 代码诊断跳转
  vim.keymap.set('n', 'g[', '<Plug>(coc-diagnostic-prev)', { silent = true })
  vim.keymap.set('n', 'g]', '<Plug>(coc-diagnostic-next)', { silent = true })

  -- 代码导航
  vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
  vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
  vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
  vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

  -- 显示文档
  -- hasProvider 返回 JSON boolean, Lua 中 true == 1 恒为 false, 不能用 == 1 判断;
  -- coc 未就绪时会抛错, pcall 后回退默认 K
  vim.keymap.set('n', 'K', function()
    local ok, has = pcall(vim.fn.CocHasProvider, 'hover')
    if ok and (has == true or has == 1) then
      vim.fn.CocActionAsync('doHover')
    else
      vim.fn.feedkeys('K', 'in')
    end
  end, { silent = true })

  -- 光标停留时高亮符号 (已禁用: 使用 treesitter 高亮)
  -- vim.api.nvim_create_autocmd('CursorHold', {
  --   callback = function()
  --     if vim.fn.exists('*CocActionAsync') == 1 then
  --       vim.fn.CocActionAsync('highlight')
  --     end
  --   end,
  -- })

  -- 符号重命名
  vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })

  -- 代码格式化
  vim.keymap.set('x', '<leader>f', '<Plug>(coc-format-selected)', { silent = true })
  vim.keymap.set('n', '<leader>f', '<Plug>(coc-format-selected)', { silent = true })

  -- 自动命令组
  local augroup = vim.api.nvim_create_augroup('coc-settings', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = { 'typescript', 'json' },
    callback = function()
      vim.bo.formatexpr = "CocAction('formatSelected')"
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'CocJumpPlaceholder',
    callback = function()
      vim.fn.CocActionAsync('showSignatureHelp')
    end,
  })

  -- 代码操作
  vim.keymap.set('x', '<leader>a', '<Plug>(coc-codeaction-selected)', { silent = true })
  vim.keymap.set('n', '<leader>a', '<Plug>(coc-codeaction-selected)', { silent = true })
  vim.keymap.set('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)', { silent = true })
  vim.keymap.set('n', '<leader>as', '<Plug>(coc-codeaction-source)', { silent = true })
  vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)', { silent = true })

  -- 重构
  vim.keymap.set('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
  vim.keymap.set('x', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
  vim.keymap.set('n', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })

  -- 函数和类文本对象
  vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-i)', { silent = true })
  vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-i)', { silent = true })
  vim.keymap.set('x', 'af', '<Plug>(coc-funcobj-a)', { silent = true })
  vim.keymap.set('o', 'af', '<Plug>(coc-funcobj-a)', { silent = true })
  vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-i)', { silent = true })
  vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-i)', { silent = true })
  vim.keymap.set('x', 'ac', '<Plug>(coc-classobj-a)', { silent = true })
  vim.keymap.set('o', 'ac', '<Plug>(coc-classobj-a)', { silent = true })

  -- 滚动弹窗
  vim.keymap.set('n', '<C-f>', function()
    if vim.fn['coc#float#has_scroll']() == 1 then
      return vim.fn['coc#float#scroll'](1)
    else
      return '<C-f>'
    end
  end, { expr = true, silent = true, nowait = true })

  vim.keymap.set('n', '<C-b>', function()
    if vim.fn['coc#float#has_scroll']() == 1 then
      return vim.fn['coc#float#scroll'](0)
    else
      return '<C-b>'
    end
  end, { expr = true, silent = true, nowait = true })

  vim.keymap.set('i', '<C-f>', function()
    if vim.fn['coc#float#has_scroll']() == 1 then
      return '<c-r>=coc#float#scroll(1)<cr>'
    else
      return '<Right>'
    end
  end, { expr = true, silent = true, nowait = true })

  vim.keymap.set('i', '<C-b>', function()
    if vim.fn['coc#float#has_scroll']() == 1 then
      return '<c-r>=coc#float#scroll(0)<cr>'
    else
      return '<Left>'
    end
  end, { expr = true, silent = true, nowait = true })

  vim.keymap.set('v', '<C-f>', function()
    if vim.fn['coc#float#has_scroll']() == 1 then
      return vim.fn['coc#float#scroll'](1)
    else
      return '<C-f>'
    end
  end, { expr = true, silent = true, nowait = true })

  vim.keymap.set('v', '<C-b>', function()
    if vim.fn['coc#float#has_scroll']() == 1 then
      return vim.fn['coc#float#scroll'](0)
    else
      return '<C-b>'
    end
  end, { expr = true, silent = true, nowait = true })

  -- 选择范围
  vim.keymap.set('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
  vim.keymap.set('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

  -- 命令
  vim.api.nvim_create_user_command('Format', function()
    vim.fn.CocActionAsync('format')
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('Fold', function(args)
    vim.fn.CocAction('fold', args.args)
  end, { nargs = '?' })

  vim.api.nvim_create_user_command('OR', function()
    vim.fn.CocActionAsync('runCommand', 'editor.action.organizeImport')
  end, { nargs = 0 })

  -- CocList 映射
  vim.keymap.set('n', '<space>a', ':<C-u>CocList diagnostics<cr>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>e', ':<C-u>CocList extensions<cr>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>c', ':<C-u>CocList commands<cr>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>o', ':<C-u>CocList outline<cr>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>s', ':<C-u>CocList -I symbols<cr>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>j', ':<C-u>CocNext<CR>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>k', ':<C-u>CocPrev<CR>', { silent = true, nowait = true })
  vim.keymap.set('n', '<space>p', ':<C-u>CocListResume<CR>', { silent = true, nowait = true })
end

-- 安装扩展的函数
function M.install_extensions()
  local coc = require('coc')
  for _, ext in ipairs(extensions) do
    if not coc.is_installed(ext) then
      coc.install(ext)
    end
  end
end

M.spec = {
  'neoclide/coc.nvim',
  branch = 'release',
  lazy = false, -- coc.nvim 需要在启动时加载
  config = M.setup,
}

return M
