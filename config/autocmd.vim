
" { 根据文件类型设置缩进
  function s:set_indent()
    let t = &filetype
    let shortIndentLang = ['zsh', 'sql', 'lua', 'json', 'yaml',
          \'vue', 'html', 'javascript',
          \'css', 'less', 'scss', 'sass',
          \'go', 'python'] " 使用2字符宽度缩进的语言
    if (count(shortIndentLang, t) > 0)
      set tabstop=2
      set shiftwidth=2
    else
      set tabstop=4
      set shiftwidth=4
    endif
    let tabIndentLang = ['lua', 'go', 'python'] " 强制使用tab缩进的语言
    if (count(tabIndentLang, t) > 0)
      setlocal noexpandtab
    endif
  endfunction
  autocmd BufEnter * call s:set_indent()
" }
" { 根据文件类型设置边界线和默认宽度
  function s:set_colorcolumn()
    let t = &filetype
    let fixSizeWindow = ['exproject', 'NvimTree']
    if (count(fixSizeWindow, t) > 0) " 不调整指定插件的窗口大小
      return
    endif
    let charLimit100 = ['rust', 'python'] " 每行限制100字符的语言
    if (count(charLimit100, t) > 0)
      set colorcolumn=100
    else
      set colorcolumn=80 " 边界线位置
    endif
    let &winwidth = &colorcolumn+8 " 当前窗口自动宽度
    let &textwidth = &colorcolumn " 自动换行. 输入时超出长度自动换到下一行. 0:不启用
  endfunction
  autocmd BufEnter * call s:set_colorcolumn()
" }
" { 在写入文件时进行代码诊断
  autocmd BufWritePost * call CocAction('diagnosticRefresh')
" }

