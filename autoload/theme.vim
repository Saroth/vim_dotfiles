" Picking colors from guns/xterm-color-table.vim

" Colors define
let g:theme_none = ['NONE', 'NONE']

let g:theme_white = ['#ffffff', 15]
let g:theme_lightgray1 = ['#c0c0c0', 7]
let g:theme_lightgray0 = ['#a8a8a8', 248]
let g:theme_gray = ['#808080', 8]
let g:theme_darkgray0 = ['#606060', 241]
let g:theme_darkgray1 = ['#444444', 238]
let g:theme_darkgray2 = ['#303030', 236]
let g:theme_darkgray3 = ['#262626', 235]
let g:theme_darkgray4 = ['#121212', 233]
let g:theme_black = ['#000000', 0]

let g:theme_lightred1 = ['#df5f5f', 203]
let g:theme_lightred0 = ['#af5f5f', 167]
let g:theme_red = ['#ff0000', 196]
let g:theme_darkred0 = ['#df0000', 160]
let g:theme_darkred1 = ['#af0000', 124]
let g:theme_darkred2 = ['#5f0000', 52]
let g:theme_lightyellow = ['#ffff87', 228]
let g:theme_yellow = ['#ffff00', 11]
let g:theme_gold = ['#ffdf00', 220]
let g:theme_wheaten0 = ['#dfaf5f', 179]
let g:theme_wheaten1 = ['#df8700', 172]
let g:theme_wheaten2 = ['#af5f00', 130]
let g:theme_orange = ['#df5f00', 166]
let g:theme_lightgreen1 = ['#87df87', 114]
let g:theme_lightgreen0 = ['#5faf5f', 71]
let g:theme_green = ['#00ff00', 46]
let g:theme_darkgreen = ['#00af00', 34]
let g:theme_lightblue0 = ['#00afdf', 38]
let g:theme_deepblue = ['#00dfff', 45]
let g:theme_blue = ['#005fdf', 26]
let g:theme_purple = ['#df00af', 163]

let s:general_background = v:null
let s:general_emphasis = v:null

" Init before set highlights.
function! theme#init(colors_name, background)
  hi clear
  let &background = a:background
  let g:colors_name = a:colors_name
  if exists("syntax_on")
    syntax reset
  endif
  call theme#set_general()
endfunction

" Set general highlight.
"   a:1     Background. If unset, default to g:theme_none
"   a:2     Emphasis. If unset, default to 'NONE,'
function! theme#set_general(...)
  let s:general_background = g:theme_none
  let s:general_emphasis = 'NONE,'
  if a:0 > 0
    let s:general_background = a:1
  endif
  if a:0 > 1 && strlen(a:2)
    let s:general_emphasis = a:2
  endif
endfunction

" Set highlight
"   group   Highlight group.
"   fg      Foreground color.
"   a:1     Background color. If unset, default to general setting
"   a:2     Emphasis. If unset, default to general setting
function! theme#hl(group, fg, ...)
  let bg = s:general_background
  if a:0 > 0
    let bg = a:1
  endif
  let em = s:general_emphasis
  if a:0 > 1 && strlen(a:2)
    let em = a:2
  endif
  let hi_cfg = [ 'highlight', a:group,
        \'guifg=' . a:fg[0], 'ctermfg=' . a:fg[1],
        \'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \'gui=' . em, 'cterm=' . em]
  let hi_str = join(hi_cfg, ' ')
  " echo hi_str
  execute hi_str
endfunction

