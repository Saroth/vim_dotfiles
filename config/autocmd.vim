
" { 根据文件类型设置缩进
  " 使用2字符宽度缩进的语言
  let s:shortIndentLang = [
        \ 'sh', 'zsh', 'sql', 'lua', 'json', 'yaml',
        \ 'vue', 'html', 'javascript',
        \ 'css', 'less', 'scss', 'sass',
        \ 'go', 'python', 'vim'
        \ ]
  " 强制使用tab缩进的语言
  let s:tabIndentLang = ['go', 'python']
  " 基于缩进折叠的语言
  let s:foldByIndentLang = ['python']
  function s:set_indent()
    let t = &filetype
    if (count(s:shortIndentLang, t) > 0)
      set tabstop=2
      set shiftwidth=2
    else
      set tabstop=4
      set shiftwidth=4
    endif
    if (count(s:tabIndentLang, t) > 0)
      setlocal noexpandtab
    endif
    if (count(s:foldByIndentLang, t) > 0)
      set foldmethod=indent
    endif
  endfunction
  autocmd BufEnter * call s:set_indent()
" }
" { 根据文件类型设置边界线和默认宽度
  " 指定窗口宽度的文件类型. <0:不调整
  let s:specialWidth = {
        \ 'exproject': -1,
        \ 'NvimTree': -1,
        \ 'rust': 100,
        \ 'python': 100,
        \ 'dbui': 32,
        \ }
  function s:set_colorcolumn()
    let t = &filetype
    let s:size = get(s:specialWidth, t)
    if (s:size < 0)
      return
    elseif (s:size == 0)
      let s:size = 80
    endif
    let &colorcolumn=s:size " 边界线位置
    let &textwidth = s:size " 自动换行. 输入时超出长度自动换到下一行. 0:不启用
    let &winwidth = s:size + 8 " 当前窗口自动宽度
  endfunction
  autocmd BufEnter * call s:set_colorcolumn()
" }
" { 在写文件时进行代码诊断
  function! autocmd#diagnostic_refresh()
    if (g:coc_service_initialized > 0)
      if exists('*CocAction')
        call CocAction('diagnosticRefresh')
      endif
    endif
  endfunction
  autocmd BufWritePost * call autocmd#diagnostic_refresh()
" }

