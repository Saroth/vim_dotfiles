" Install: curl -fLo $VIM/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin($VIM.'/plugged')

" { vim-startify    启动页
  Plug 'mhinz/vim-startify'
  let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'
  let g:startify_bookmarks = [
        \ { 'h': '~' },
        \ { 'v': '~/.config/nvim' },
        \ { 'c': getcwd() },
        \ ]
  let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
" }
" { Visincr         快捷递增输入. Block selected and type :I, :II, :IO, :IIO, :IR, :IIR, IX
  Plug 'vim-scripts/Visincr'
" }
" { vim-easy-align  代码对齐. selected and type :EasyAlign
  Plug 'junegunn/vim-easy-align'
" }

" All of your Plugs must be added before the following line
call plug#end()

