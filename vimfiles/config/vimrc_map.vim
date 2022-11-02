" Description: Neovim mappings

" { 快捷编辑
    " 快捷保存
        " 输入容错设置
        noremap :W :w
    " 快捷移动
        " 原功能    N/I:跳转到下一行
        noremap <C-j> 8<C-d>
        " 原功能    N:~ I:特殊字符组合输入
        noremap <C-k> 8<C-u>
    " 快捷选中
        " 反向选中一个词
        noremap vv viwO
        " 正向选中一个词
        noremap vV viw
    " 缩进调整后保持选中状态
    vnoremap < <gv
    vnoremap > >gv
    " 退出输入状态
    inoremap qq <Esc>
" }
" { 快捷功能
    " 支持使用<M-Space>打开GUI窗口菜单
    map <M-Space> :simalt ~<CR>
    " " 显示缓冲区列表
    " map <C-b> :buffers<CR>:echo '>>> Select a buffer:'<CR>:e #
    " 关闭非当前窗口的缓冲区
    command! BcloseOthers call <SID>BufCloseOthers()
    " " 命令快捷键
    " map <leader>bdo :BcloseOthers<cr>
    function! <SID>BufCloseOthers()
        let l:currentBufNum   = bufnr("%")
        let l:alternateBufNum = bufnr("#")
        for i in range(1,bufnr("$"))
            if buflisted(i)
                if i!=l:currentBufNum
                    execute("bdelete ".i)
                endif
            endif
        endfor
    endfunction
" }
" { function key
    "  F2
        " edit base configuration
        map <F2>    :e $VIM/vimfiles/vimrc_cfg.vim <CR>
        " Base Setting: edit entry file
        map <C-F2>  :e $VIM/.vimrc <CR>
    "  F3
        " Mappings: edit map setting
        map <F3>    :e $VIM/vimfiles/vimrc_map.vim <CR>
        " Colors: edit colors
        map <C-F3>  :e $VIM/vimfiles/colors/clearblack.vim <CR>
    "  F4
        " Plugins: edit plugin configuration
        map <F4>    :e $VIM/vimfiles/vimrc_plg.vim <CR>
        " After Colors: edit after colors
        map <C-F4>  :e $VIM/vimfiles/after/colors/clearblack.vim <CR>

    "  F5
        " Update all files
        map <F5>    :Update<CR>
        " update highlight, required plugin: TagHighlight
        map <C-F5>  :UpdateTypesFile <CR>
    "  F6
        " NERDTree: open/close
        map <F6>    :NERDTreeToggle<CR>
    "  F7
        " Tagbar: open/close
        map <F7>    :TagbarToggle<CR>
    "  F8
        " EXProject: open/close
        map <F8>    :EXProjectToggle<CR>

    "  F9
        " GitGutter: next hunk
        map <F9>    <Plug>(GitGutterNextHunk)
    "  F10
        " GitGutter: previous hunk
        map <F10>  <Plug>(GitGutterPrevHunk)
    "  F11
        " 打开或关闭菜单栏和工具栏
        map <silent> <F11> :if &guioptions=~# "T" <Bar>
        \       set guioptions-=T <Bar>
        \       set guioptions-=m <bar>
        \       else <Bar>
        \       set guioptions+=T <Bar>
        \       set guioptions+=m <Bar>
        \       endif <CR>
    "  F12
" }

