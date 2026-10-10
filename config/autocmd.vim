
" 根据文件类型设置缩进
" 使用2字符宽度缩进的语言
let s:shortIndentLang = [
      \ 'sh', 'zsh', 'sql', 'lua', 'json', 'yaml',
      \ 'vue', 'html', 'javascript',
      \ 'ts', 'tsx', 'typescriptreact',
      \ 'css', 'less', 'scss', 'sass',
      \ 'go', 'python', 'vim'
      \ ]
" 强制使用tab缩进的语言
let s:tabIndentLang = ['go', 'python']
" 基于缩进折叠的语言
let s:foldByIndentLang = ['python']
" FileType 时登记本 buffer 的 foldmethod 意图: marker 默认, 例外见 s:foldByIndentLang
" 外部归属方(如 treesitter/markdown)在自己的 FileType 里覆盖登记值即可
function s:set_fold_wanted()
  let b:foldw = count(s:foldByIndentLang, &filetype) > 0 ? 'indent' : 'marker'
endfunction
" 按登记复位 foldmethod(窗口级). 未登记(无 ft)、diff、外部登记值 一律不碰
function s:set_fold()
  if &diff || !exists('b:foldw') | return | endif
  if &l:foldmethod !=# b:foldw | let &l:foldmethod = b:foldw | endif
endfunction
function s:set_indent()
  let l:t = &filetype
  if count(s:shortIndentLang, l:t) > 0
    setlocal tabstop=2 shiftwidth=2
  else
    setlocal tabstop=4 shiftwidth=4
  endif
  if count(s:tabIndentLang, l:t) > 0
    setlocal noexpandtab
  endif
endfunction

" 根据文件类型设置边界线和默认宽度
" 指定窗口宽度的文件类型. <0:不调整. 未指定: 80
let s:specialWidth = {
      \ 'exproject': -1,
      \ 'NvimTree': -1,
      \ 'rust': 100,
      \ 'python': 100,
      \ 'dbui': 32,
      \ }
function s:set_colorcolumn()
  let l:size = get(s:specialWidth, &filetype, 0)
  if l:size < 0
    return
  elseif l:size == 0
    let l:size = 80
  endif
  let &l:colorcolumn = l:size " 边界线位置
  let &l:textwidth = l:size " 自动换行. 输入时超出长度自动换到下一行. 0:不启用
  let &l:winwidth = l:size + 8 " 当前窗口自动宽度
endfunction

" 在写文件时进行代码诊断
" 被 keymap.vim 的 <C-l> 调用, 不能用 s:
function! autocmd#diagnostic_refresh()
  if exists('g:coc_service_initialized') &&
        \ (g:coc_service_initialized > 0) && exists('*CocAction')
    call CocAction('diagnosticRefresh')
  endif
endfunction

augroup custom_autocmds
  autocmd!
  " BufEnter 而非 FileType: colorcolumn/winwidth 是窗口级, 换窗口时需重新应用
  " foldmethod 复位需在 FileType 登记之后, 加载顺序上 FileType 先于 BufEnter
  autocmd FileType * call s:set_fold_wanted()
  autocmd BufEnter * call s:set_fold() | call s:set_indent() | call s:set_colorcolumn()
  autocmd BufWritePost * call autocmd#diagnostic_refresh()
augroup END

