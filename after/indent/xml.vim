" 修复 treesitter 高亮模式下 XML 缩进失效的问题
" 原因: treesitter 启用时 &syntax 为空, synID() 返回 0,
"       导致内置 XmlIndentGet 的语法检查分支错误返回 pind
" 方案: 跳过语法检查, 直接使用纯 tag 匹配的缩进逻辑
setlocal indentexpr=XmlIndentGet(v:lnum,0)