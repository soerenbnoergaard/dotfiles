" Vim syntax file
" Language:     SorenWiki
" Author:       Søre Nørgaard

"if exists("b:current_syntax")
"  finish
"endif

syn clear
syn sync fromstart " change this if it gets slow.
syn sync linebreaks=1
syn case match

syn match wikiHeader /\.h.*/
syn match wikiBullet /\*\ .*/
syn match wikiEnum /#\ .*/
syn match wikiImage /.image\n.*/
syn region wikiCode start=/.code/ end=/.code/
syn match wikiComment /\/\/.*/


highlight link wikiHeader Identifier 
highlight link wikiBullet Constant
highlight link wikiEnum Constant
highlight link wikiImage Type
highlight link wikiCode Special
highlight link wikiComment Comment


" vim: wrap et sw=2 sts=2:
