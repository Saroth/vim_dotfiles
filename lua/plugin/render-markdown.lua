M = {}

local rm_opts = {
  sign = { enabled = false }, -- 关闭Sign列标记, Consolas字体无对应图标
  heading = { -- 标题
    atx = true, -- 开启 / 关闭 atx 风格标题的渲染（即 `#` ~ `######`）
    setext = true, -- 开启 / 关闭 setext 风格标题的渲染（即下划线形式 `--` 与 `==`）
    -- 替换 atx_h._marker 中的 `#+`
    icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
    -- 标题背景的宽度：
    --   block：标题文字的宽度
    --   full ：窗口的完整宽度
    -- 也可以是一个上述取值的数组，此时 level 会以 clamp 方式作为数组索引
    width = 'block',
    -- width 为 'block' 时，标题右侧填充的空格数
    right_pad = 4,
    -- width 为 'block' 时，标题使用的最小宽度
    min_width = 80,
    -- 是否在标题的上下方添加边框
    border = true,
  },
  code = { -- 代码块
    -- 决定代码块与行内代码的渲染程度：
    --   none   ：关闭所有渲染
    --   normal  ：给代码块与行内代码加上高亮组，并给代码块加内边距
    --   language：若 sign 列开启，则在 sign 列添加语言图标；
    --             并在代码块上方添加图标 + 语言名称
    --   full    ：normal + language
    style = 'full',
    -- 语言标识的渲染位置：
    --   right ：代码块的右侧
    --   left  ：代码块的左侧
    --   center：代码块水平居中
    position = 'right',
    -- 是否显示语言图标
    language_icon = false,
    -- 语言标识两侧的留白大小
    language_pad = 2,
    -- 一个语言名称数组：这些语言会禁用背景高亮，
    -- 通常是因为它们自身就带有背景高亮（如 diff）
    disable_background = { 'diff' },
    -- 代码块背景的宽度：
    --   block ：代码块文字的宽度
    --   full  ：窗口的完整宽度
    --   也可以是上述取值的数组，此时按级别以 clamp 方式索引
    width = 'block',
    -- 代码块左侧的额外缩进量
    left_margin = 1,
    -- 代码块左侧填充的空格数
    left_pad = 1,
    -- width 为 'block' 时，代码块右侧填充的空格数
    right_pad = 4,
    -- width 为 'block' 时，代码块使用的最小宽度
    min_width = 40,
    -- 代码块顶部 / 底部边框的渲染方式：
    --   thick ：使用与代码主体相同的高亮
    --   thin  ：空行处叠加 above / below 图标
    --   hide  ：隐藏分隔符
    border = 'thin',
  },
  dash = { -- 分割线
    -- 替换 thematic_break 节点里的 '---' | '***' | '___' | '* * *'
    -- 该图标会沿窗口宽度重复铺满整行
    icon = '╍',
  },
  bullet = { -- 列表符号
    -- 替换 list_item 中的 '-' | '+' | '*'
    -- 列表嵌套的深度决定「级别（level）」
    -- level 会以 cycle 方式作为数组索引
    -- 取值类型：function 时写作 `value(context)`；string[] 时写作 `cycle(value, context.level)`
    icons = { '●', '○', '◆', '◇' },
  },
  checkbox = { -- 复选框
    -- 复选框左侧添加的填充量
    left_pad = 1,
    checked = { -- 已勾选
      icon = '[x]',
      highlight = 'RenderMarkdownChecked',
      scope_highlight = '@markup.strikethrough',
    },
    unchecked = { -- 未勾选
      icon = '[ ]',
      highlight = 'RenderMarkdownUnchecked',
      scope_highlight = 'RenderMarkdownUnchecked',
    },
    custom = {
      todo = {
        raw = '[-]',
        rendered = '[-]',
        highlight = 'RenderMarkdownTodo',
        scope_highlight = 'Todo',
      },
      important = {
        raw = '[~]',
        rendered = '[~]',
        highlight = 'RenderMarkdownTodo',
        scope_highlight = 'WarningMsg',
      },
      blocked = {
        raw = '[!]',
        rendered = '[!]',
        highlight = 'RenderMarkdownTodo',
        scope_highlight = 'ErrorMsg',
      },
      unknown = {
        raw = '[?]',
        rendered = '[?]',
        highlight = 'RenderMarkdownTodo',
        scope_highlight = 'MoreMsg',
      },
    },
    quote = { -- 引用块
    },
    pipe_table = { -- 表格
      -- 预置的边框方案，主要用于省去手动设置 border 的麻烦：
      --   heavy  ：使用更粗的边框字符
      --   double ：使用双线边框字符
      --   round  ：使用圆角边框
      --   none   ：不做任何处理
      preset = 'round',
      -- 决定整张表格的渲染方式：
      --   none   ：关闭所有渲染
      --   normal ：对表格的每一行应用 'cell' 样式渲染
      --   full   ：normal + 在长度匹配时补齐上下边框线
      style = 'full',
    },
  },
}

function M.setup()
  if pcall(vim.treesitter.language.inspect, 'markdown') then
    require('render-markdown').setup(rm_opts)
  else
    -- parser 尚未就绪, 延迟到 VimEnter 后执行
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function() require('render-markdown').setup(rm_opts) end,
    })
  end
end

local setup = M.setup

M.spec = {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = 'markdown',
  config = setup,
}

return M
