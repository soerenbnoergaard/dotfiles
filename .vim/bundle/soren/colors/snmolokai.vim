" Vim color file
"
" Author: Søren Nørgaard <soerenbnoergaard@gmail.com>
"
" Note: Based on Thomas Restrepos molokai
" theme, Based on the monokai theme for 
" textmate by Wimer Hazenberg and itsdarker 
" variant by Hamish Stuart Macpherson
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="snmolokai"


hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#DD0000               gui=NONE
hi Constant        guifg=#AE81FF               gui=NONE
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=NONE
hi Define          guifg=#44B7CD
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#AA0000 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=NONE

hi Directory       guifg=#73C936               gui=NONE
hi Error           guifg=#AA0000 guibg=#1E0010
hi ErrorMsg        guifg=#DD0000 guibg=#232526 gui=NONE
hi Exception       guifg=#73C936               gui=NONE
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#73C936
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#DD0000               gui=NONE
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=NONE
hi SpecialKey      guifg=#44B7CD               gui=NONE

hi MatchParen      guifg=#000000 guibg=#FD971F gui=NONE
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#DD0000

" complete menu
hi Pmenu           guifg=#44B7CD guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#44B7CD

hi PreCondit       guifg=#73C936               gui=NONE
hi PreProc         guifg=#73C936
hi Question        guifg=#44B7CD
hi Repeat          guifg=#DD0000               gui=NONE
hi Search          guifg=#FFFFFF guibg=#455354
" marks column
hi SignColumn      guifg=#73C936 guibg=#232526
hi SpecialChar     guifg=#DD0000               gui=NONE
hi SpecialComment  guifg=#869497               gui=NONE
hi Special         guifg=#44B7CD guibg=bg      gui=NONE
hi SpecialKey      guifg=#888A85               gui=NONE
if has("spell")
    hi SpellBad    guisp=#550000 gui=undercurl
    hi SpellCap    guisp=#2020A0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#DD0000               gui=NONE
hi StatusLine      guifg=#222222 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#DD770F               gui=NONE
hi Structure       guifg=#44B7CD
hi Tag             guifg=#DD0000               gui=NONE
hi Title           guifg=#DD0000               gui=NONE
hi Todo            guifg=#FFFFFF guibg=bg      gui=NONE

hi Typedef         guifg=#44B7CD
hi Type            guifg=#44B7CD               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=NONE
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=NONE
hi WildMenu        guifg=#44B7CD guibg=#000000

hi Normal          guifg=#D8D8D2 guibg=#111111
hi Comment         guifg=#465457
hi CursorLine                    guibg=#293739
hi CursorColumn                  guibg=#293739
hi LineNr          guifg=#BCBCBC guibg=bg
hi NonText         guifg=bg      guibg=bg

" Vim-latex
hi texSectionName  guifg=#D8D8D2               gui=bold
