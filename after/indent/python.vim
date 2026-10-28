" 修复 treesitter 高亮模式下 python 按 = 级联缩进的问题
" 原因: treesitter 启用时 &syntax 为空, synstack() 返回空,
"       python#GetIndent 的 searchpair 括号跳过逻辑失效,
"       ANSI 转义串中的裸 '['(如 "\033[1;32m" 有 [ 无 ]) 被误判为未闭合括号,
"       每行被对齐到上一行的 '[' 列, 逐行级联加深
" 方案: 关闭括号对齐分支, 其余缩进规则(冒号/pass 等)不依赖 synID, 照常工作
let g:python_indent = {'disable_parentheses_indenting': 1}
