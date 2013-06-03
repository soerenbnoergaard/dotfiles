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


hi Boolean         guifg=#7E51FF
hi Character       guifg=#880088
hi Number          guifg=#7E51FF
hi String          guifg=#880088
hi Conditional     guifg=#DD0000               gui=NONE
hi Constant        guifg=#7E51FF               gui=NONE
hi Cursor          guifg=#FFFFFF guibg=#000000
hi Debug           guifg=#BCA3A3               gui=NONE
hi Define          guifg=#0088AA
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#AA0000 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=NONE

hi Directory       guifg=#449900               gui=NONE
hi Error           guifg=#AA0000 guibg=#1E0010
hi ErrorMsg        guifg=#DD0000 guibg=#232526 gui=NONE
hi Exception       guifg=#449900               gui=NONE
hi Float           guifg=#7E51FF
hi FoldColumn      guifg=#465457 guibg=#CCCCCC
hi Folded          guifg=#465457 guibg=#CCCCCC
hi Function        guifg=#000000               gui=bold
hi Identifier      guifg=#000000
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#880088 guibg=#000000

hi Keyword         guifg=#DD0000               gui=NONE
hi Label           guifg=#880088               gui=none
hi Macro           guifg=#880088               gui=NONE
hi SpecialKey      guifg=#0088AA               gui=NONE

hi MatchParen      guifg=#000000 guibg=#FFFF00 gui=NONE
hi ModeMsg         guifg=#880088
hi MoreMsg         guifg=#880088
hi Operator        guifg=#DD0000

" complete menu
hi Pmenu           guifg=#0088AA guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#0088AA

hi PreCondit       guifg=#449900               gui=NONE
hi PreProc         guifg=#449900
hi Question        guifg=#0088AA
hi Repeat          guifg=#DD0000               gui=NONE
hi Search          guifg=#FFFFFF guibg=#455354
" marks column
hi SignColumn      guifg=#449900 guibg=#232526
hi SpecialChar     guifg=#DD0000               gui=NONE
hi SpecialComment  guifg=#0000DD               gui=NONE
hi Special         guifg=#0088AA guibg=bg      gui=NONE
hi SpecialKey      guifg=#888A85               gui=NONE
if has("spell")
    hi SpellBad    guisp=#550000 gui=undercurl
    hi SpellCap    guisp=#2020A0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#DD0000               gui=NONE
hi StatusLine      guifg=#222222 guibg=#FFFFFF
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#AD4700               gui=NONE
hi Structure       guifg=#0088AA
hi Tag             guifg=#DD0000               gui=NONE
hi Title           guifg=#DD0000               gui=NONE
hi Todo            guifg=#000000 guibg=bg      gui=NONE

hi Typedef         guifg=#0088AA
hi Type            guifg=#0088AA               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=NONE
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=NONE
hi WildMenu        guifg=#0088AA guibg=#000000

hi Normal          guifg=#000000 guibg=#DDDDDD
hi Comment         guifg=#8888FF
hi CursorLine                    guibg=#293739
hi CursorColumn                  guibg=#293739
hi LineNr          guifg=#BCBCBC guibg=bg
hi NonText         guifg=bg      guibg=bg

" Vim-latex
hi texSectionName  guifg=#000000               gui=bold
