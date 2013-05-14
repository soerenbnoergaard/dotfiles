" vim: fdm=marker foldenable
" --- Custom functions and Commands --------------------------------------- {{{
" word -> \begin{word} ... \end{word}
function! snlatex:WordToEnvironment()
    normal diw
    let s:curenv = @
    silent exe "normal! i" . '\begin{' . s:curenv . "}\<CR>"
    silent exe "normal! i" . '\end{' . s:curenv . "}"
    silent exe "normal k2==o"
    startinsert
endfunction

" word -> \word{}
function! snlatex:WordToCommand()
    normal diw
    let s:curcmd = @
    silent exe "normal! i" . '\' . s:curcmd . "{}"
    silent exe "normal! T{a"
    startinsert
endfunction

" Swap color theme - dark/light
let g:myTheme = 0
function! sncolor:SwapTheme()
    let g:myTheme = g:myTheme + 1
    if g:myTheme >= 5   | let g:myTheme = 0         | endif
    if g:myTheme == 0
        set background=light
        colorscheme default
    endif
    if g:myTheme == 1
        set background=dark
        colorscheme snmolokai
    endif
    if g:myTheme == 2
        set background=dark
        colorscheme zmrok
    endif
    if g:myTheme == 3
        set background=dark
        colorscheme scame
    endif
    if g:myTheme == 4
        set background=dark
        colorscheme github
    endif
endf

let g:ScrollCenter = 0
function! sn:ScrollCenter()
    let g:ScrollCenter = g:ScrollCenter + 1
    if g:ScrollCenter > 1 | let g:ScrollCenter = 0 | endif
    if g:ScrollCenter == 0
        set so=0
    endif
    if g:ScrollCenter == 1
        set so=999
    endif
endf

"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "da", "en" ]
function! MySpellLang()
    "loop through languages
    let g:myLang = g:myLang + 1
    if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
    if g:myLang == 0 | set nospell | endif
    if g:myLang == 1 | set spell spelllang=da | endif
    if g:myLang == 2 | set spell spelllang=en | endif
    echo "language:" g:myLangList[g:myLang]
endf
command! Term :!urxvtcd

" toggle comments
let g:comment_flag = 0 
function! MyComment()
    if g:comment_flag == 0 | hi Comment guifg=bg ctermfg=bg | hi SpecialComment guifg=bg ctermfg=bg | endif
    if g:comment_flag == 1 | colorscheme snmolokai | endif " Soren: Color scheme here.
    let g:comment_flag = g:comment_flag + 1
    if g:comment_flag > 1 | let g:comment_flag = 0 | endif
endf

function sn:LasseMode()
    colorscheme github
    set guifont=DejaVu\ Sans\ Mono\ 11
endf
command LasseMode :call sn:LasseMode()
" }}}
" --- Plugin settings ----------------------------------------------------- {{{
call pathogen#infect()       " activate pathogen

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Vimlatex
filetype plugin on
set ofu=syntaxcomplete#Complete
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_Folding=0
let Tex_FoldedEnvironments=''          " fold only sections
let Tex_FoldedCommands=''
let Tex_FoldedMisc='preamble'
let g:Tex_IgnoredWarnings =
            \'Underfull'."\n".
            \'Overfull'."\n".
            \'specifier changed to'."\n".
            \'You have requested'."\n".
            \'Missing number, treated as zero.'."\n".
            \'There were undefined references'."\n".
            \'LaTeX Warning:' . "\n".
            \'Citation %.%# undefined'
let g:Tex_IgnoreLevel = 8
" Nerd tree
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI  = 1

" STD_C plugin
let c_C99 = 1

" Task list plugin
let g:tlWindowPosition = 1

" }}}
" --- Keymapping ---------------------------------------------------------- {{{
let mapleader = ","
nnoremap <Leader>mk :make<CR>
nnoremap <Leader>ru :!./%<<CR>
nnoremap <Leader>fo :set guifont=*<CR>
nnoremap <F10> :NERDTreeToggle<CR>
nnoremap <Leader>bu :buffers<CR>
inoremap ½ $
cnoremap ½ ~
nnoremap <Leader>mru :MRU<CR>
nnoremap + :
noremap <Leader>/ <Esc>:let @/=""<CR>
noremap <Leader>7 <Esc>:let @/=""<CR>
nnoremap <F12> :call MySpellLang()<CR>
nnoremap <Space> @q
nnoremap <leader>md :%!markdown --html4tags<cr>
nnoremap <leader>cc :!gcc % -o %<
nnoremap <M-t> :tabnew<CR>
nnoremap <M-w> :tabclose<CR>
nnoremap <M-v> :e $MYVIMRC<CR>
nnoremap <Leader>ta :Tabularize /
vnoremap <Leader>ta :Tabularize /
nnoremap <Leader>te :Term<CR><CR>
xnoremap <space>c :!octave --silent \| cut -c8-<cr>
nnoremap <leader>td :TaskList<CR>
nnoremap <leader>pa :exec "w !vpaste ft=".&ft<CR>
vnoremap <leader>pa <ESC>:exec "'<,'>w !vpaste ft=".&ft<CR>
vnoremap <leader>go <Esc>:exec
            \ ":!chromium http://www.google.com/search?q=\""
            \ . substitute(@*,"\\W\\+\\\\|\\<\\w\\>"," ","g")
            \ . "\""<CR><CR>
nnoremap <leader>so :call sn:ScrollCenter()<CR>
nnoremap <C-d> <C-d>M
nnoremap <C-u> <C-u>M
nnoremap <C-f> <C-f>M
nnoremap <C-b> <C-b>M
nnoremap <Leader>co :call MyComment()<CR>
" }}}
" --- Added functionality ------------------------------------------------- {{{
autocmd BufEnter * silent! lcd %:p:h " Change directory to buffer's
autocmd QuickFixCmdPost [^l]* nested cwindow " Open/close quickfix window
autocmd QuickFixCmdPost    l* nested lwindow

" Completion by ctrl-n ctrl-p not including tags.
set complete=.,w,b,u,i

" Use alt key in terminal
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" Easymotion on <leader>w
let g:EasyMotion_leader_key = '<Leader>'
" }}}
" --- Filetypes ----------------------------------------------------------- {{{
augroup filetypedetect
    au! BufNewFile,BufRead *.wiki   setf     wiki
    au! BufNewFile,BufRead *.ino    setlocal ft=cpp
    au! BufNewFile,BufRead *.md     setlocal ft=markdown
    au! BufNewFile,BufRead *.vala   setlocal ft=vala
    au! BufNewFile,BufRead *.jemdoc setlocal ft=jemdoc spell spelllang=da
    au! BufNewFile,BufRead *.tex    setlocal spell spelllang=da ft=tex
    au! BufNewFile,BufRead *.psm    setlocal ft=asm
    au! BufRead,BufNewFile *.ucf    setlocal ft=conf
    au! BufNewFile,BufRead *.org    call org#SetOrgFileType()
augroup END

augroup settingsforfiletypes
    au! FileType asm setlocal autoindent noexpandtab tabstop=8 shiftwidth=8
    au! FileType python setlocal autoindent tabstop=4 shiftwidth=4
    au! FileType perl setlocal ft=perl6
    au! FileType cpp setlocal ft=c
augroup END

augroup keymapforfiletypes
    au! BufNewFile,BufRead *.m               nnoremap <buffer> <leader>ll :!octave --silent --eval "run %"<cr>
augroup END

" C options
set cinoptions=:0,l1,t0,g0,(0   " C-Indent options: K&R style
set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set indentkeys=!<Tab>,o,O
" }}}
" --- Editor settings ----------------------------------------------------- {{{
" Tab settings
set tabstop=4                     " tab width
set shiftwidth=4                  " indention
set expandtab                     " use spaces
set autoindent                    " autoindent

" Line break settings
set wrap                          " soft wrap
set linebreak                     " wrap words

" Search settings
set incsearch                     " search as you type
set ignorecase                    " case sensitive on search
set hlsearch                      " highlight search results

" Compatiliy settings
set nocompatible                  " it's 2012 - don't be compatible
set backspace=2                   " use regular backspace
set mouse=a                       " use mouse
set winaltkeys=no                 " no alt key gui-menu shortcuts
set encoding=utf-8                " use utf8 encoding
set clipboard=unnamedplus         " use system clipboard, unix
set ofu=syntaxcomplete#Complete   " omnicompletion on

" Layout settings
set nofoldenable                  " don't fold
set foldmethod=syntax             " fold based on indent
set foldnestmax=2                 " deepest fold
set foldlevel=0                   " folded or not?
set laststatus=2                  " always show status bar
set nonumber                      " line numbering

syntax enable
" }}}
" --- Statusline setup ---------------------------------------------------- {{{
function! SyntaxItem()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

if has ('statusline')
    set statusline=%f                          " file name
    set statusline+=%=                         " right adjust
    set statusline+=\                          " offset
    set statusline+=[%{SyntaxItem()}]\         " syntax group
    set statusline+=%{strlen(&ft)?&ft:'none'}, " file type
    set statusline+=%-7.(%l,%c%V%)\ %<%P       " cursor position/offset
endif
" }}}
" --- GUI/nongui settings ------------------------------------------------- {{{
if has("gui_running")
    set columns=80 lines=24
    set guifont=Dina\ 12
    call sncolor:SwapTheme()
    nnoremap <f2> :call sncolor:SwapTheme()<CR>
else
    colorscheme default
    set bg=light
endif

if has('win16') || has('win32') || has('win64') || has('win95')
    if has ("gui_running")
        set guifont=Bitstream_Vera_Sans_Mono:h10
    endif
    set clipboard+=unnamed
else
endif
" }}}