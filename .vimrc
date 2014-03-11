" vim: fdm=marker foldenable
" --- Custom functions and Commands --------------------------------------- {{{
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
        colorscheme molokai
    endif
    if g:myTheme == 2
        set background=dark
        colorscheme snmolokai
    endif
    if g:myTheme == 3
        set background=light
        colorscheme snlight
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
    if g:myLang == 0 | setlocal nospell | endif
    if g:myLang == 1 | setlocal spell spelllang=da | endif
    if g:myLang == 2 | setlocal spell spelllang=en | endif
    echo "language:" g:myLangList[g:myLang]
endf

"   Compile LaTeX for the current file only
function! LatexCurrent()
    let a:localLatexCommand = 'echo '
    let a:localLatexCommand .= '\\input{set/preamble}'
    let a:localLatexCommand .= '\\input{set/listings}'
    let a:localLatexCommand .= '\\input{set/macros}'
    let a:localLatexCommand .= '\\\\begin{document}\\input{'
    let a:curfile = expand('%:p')
    let a:localLatexCommand .= a:curfile
    let a:localLatexCommand .= '}\\\\end{document}'
    let a:localLatexCommand .= '> /home/soren/svn/project6/rep/masterlocal.tex'
    echom system(a:localLatexCommand)
    execute "!cd /home/soren/svn/project6/rep/ && pdflatex masterlocal.tex"
endf

command! Term :!terminator </dev/null &>/dev/null &
command! Fileman :!pcmanfm </dev/null &>/dev/null &

function! C2Doxygen()
    "   Copy line, save return type
    normal yyP
    execute("normal f(bi\<CR>")
    normal k
    let rettype=getline('.')
    normal dd
    
    "   Save function name
    execute("normal f(i\<CR>")

    normal k
    let function=getline('.')
    normal dd

    "   Delete ( and )
    normal xf)
    normal D

    "   Split up parameters
    let params = []
    let line=getline('.')
    if (!empty(line))
        "   If multiple parameters
        while !empty(matchstr(line, ','))
            execute("normal 0f,xi\<CR>")
            normal k$Bd0
            call add(params,getline('.'))
            normal dd
            let line=getline('.')
        endwhile
        if 0 < len(params)
            normal $Bd0
            call add(params,getline('.'))
            normal dd
        endif

        "   If 1 parameter only
        if 0 == len(params)
            normal $Bd0         
            call add(params,getline('.'))
            normal dd
        endif
    else
        normal dd
    endif

    "   Print header
    normal O/* 
    put =function
    normal kJo 
    normal 0DI *
    normal o 
    normal 0D
    normal i * @brief 
    normal o
    normal 0D
    for i in params
        normal I * @param 
        put =i
        normal kJA 
        normal o
        normal 0D
    endfor
    if empty(matchstr(rettype, "void"))
        normal I * @retval 
        normal o
    endif
    normal 0Di */
    execute("normal ?brief\<CR>A")
endf
command! C2Doxygen :call C2Doxygen()

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
let g:Tex_Folding=1
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
            \'LaTeX Font Warning:' . "\n".
            \'Citation %.%# undefined'
let g:tex_indent_items = 1
let g:Tex_IgnoreLevel = 8
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode -file-line-error-style $*'

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
nnoremap <Leader>mru :MRU<CR>
nnoremap + :
vnoremap + :
noremap <Leader>/ <Esc>:let @/=""<CR>
noremap <Leader>7 <Esc>:let @/=""<CR>
nnoremap j gj
nnoremap k gk
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
nnoremap <Leader>fm :Fileman<CR><CR>
xnoremap <Leader>ca :!octave --silent \| cut -c8-<cr>
nnoremap <leader>td :TaskList<CR>
nnoremap <leader>pa :exec "w !vpaste ft=".&ft<CR>
vnoremap <leader>pa <ESC>:exec "'<,'>w !vpaste ft=".&ft<CR>
nnoremap <leader>so :call sn:ScrollCenter()<CR>
nnoremap <C-d> <C-d>M
nnoremap <C-u> <C-u>M
nnoremap <C-f> <C-f>M
nnoremap <C-b> <C-b>M
nnoremap <Leader>co :call MyComment()<CR>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
vnoremap <leader>lc :normal 0i// <esc>$
nnoremap <leader>lc :normal 0i// <esc>$
nnoremap <leader>ou :TToC<cr>
cnoremap w!! w !sudo tee % >/dev/null
" }}}
" --- Added functionality ------------------------------------------------- {{{
autocmd BufEnter * silent! lcd %:p:h " Change directory to buffer's
autocmd QuickFixCmdPost [^l]* nested cwindow " Open/close quickfix window
autocmd QuickFixCmdPost    l* nested lwindow

" Completion by ctrl-n ctrl-p not including tags.

" Use alt key in terminal
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
" }}}
" --- Editor settings ----------------------------------------------------- {{{
" Tab settings
set tabstop=4                     " tab width
set shiftwidth=4                  " indention
set softtabstop=4                 " backspace deletes indents
set expandtab                     " use spaces
set autoindent                    " autoindent

" Line break settings
set wrap                          " soft wrap
set linebreak                     " wrap words

" Search and macro settings
set incsearch                     " search as you type
set ignorecase                    " case sensitive on search
set nohlsearch                    " highlight search results
set lazyredraw                    " when executing macros, don't redraw
" set complete=.,w,b,u,i

" Compatiliy settings
set nocompatible                  " it's 2012 - don't be compatible
set mouse=a                       " use mouse
set winaltkeys=no                 " no alt key gui-menu shortcuts
set encoding=utf-8                " use utf8 encoding
set clipboard=unnamedplus         " use system clipboard, unix
set ofu=syntaxcomplete#Complete   " omnicompletion on
set autoread                      " auto read if file changes outside

" Layout settings
set nofoldenable                  " don't fold
set foldmethod=syntax             " fold based on indent
set foldnestmax=2                 " deepest fold
set foldlevel=0                   " folded or not?
set laststatus=1                  " status bar 1=not shown in single, 2=always
set number                        " line numbering
set guicursor=a:blinkon0          " blinking cursor.

syntax enable
" }}}
" --- Filetypes ----------------------------------------------------------- {{{
augroup filetypedetect
    au! BufNewFile,BufRead *.wiki   setf     wiki
    au! BufNewFile,BufRead *.ino    setlocal ft=cpp
    au! BufNewFile,BufRead *.md     setlocal ft=markdown
    au! BufNewFile,BufRead *.vala   setlocal ft=vala
    au! BufNewFile,BufRead *.jemdoc setlocal ft=jemdoc
    au! BufNewFile,BufRead *.tex    setlocal ft=tex
    au! BufNewFile,BufRead *.psm    setlocal ft=asm
    au! BufRead,BufNewFile *.ucf    setlocal ft=conf
    au! BufNewFile,BufRead *.org    call org#SetOrgFileType()
augroup END

augroup settingsforfiletypes
    au! FileType asm setlocal autoindent noexpandtab tabstop=8 shiftwidth=8
    au! FileType python setlocal autoindent tabstop=4 shiftwidth=4
    au! FileType perl setlocal nowrap
    au! FileType c setlocal nowrap
    au! FileType cpp setlocal nowrap
    au! FileType tex syntax spell toplevel | setlocal spell
    au! BufRead /home/soren/svn/*.tex setlocal spelllang=en_us
    au! FileType make setlocal autoindent noexpandtab tabstop=8 shiftwidth=8
augroup END

augroup keymapforfiletypes
    au! BufNewFile,BufRead *.m  nnoremap <buffer> <leader>ll :!octave --silent --eval "run %"<cr>
    au! FileType c nnoremap <buffer> <leader>ll :!gcc -lm % -o %< <cr>
    au! FileType cpp nnoremap <buffer> <leader>ll :!g++  % -o %< <cr>
    au! FileType tex nnoremap <buffer> <leader>lo :call LatexCurrent() <cr><cr>
    au FileType tex nnoremap <buffer> <leader>lp :!evince "/home/soren/svn/project6/rep/masterlocal.pdf" </dev/null &>/dev/null & <cr><cr>
    au! Filetype c nnoremap <buffer> <leader>cc :C2Doxygen<cr>
augroup END

" C options
set cinoptions=:0,l1,t0,g0,(0   " C-Indent options: K&R style
set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
" set indentkeys=!<Tab>,o,O
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
    set guifont=Source\ Code\ Pro\ 11
    " set guioptions=aegit
    set guioptions=aegit
    call sncolor:SwapTheme()
    nnoremap <f2> :call sncolor:SwapTheme()<CR>
else
    set t_Co=265
    colorscheme molokai
endif

if has('win16') || has('win32') || has('win64') || has('win95')
    if has ("gui_running")
        set guifont=Bitstream_Vera_Sans_Mono:h10
    endif
    set clipboard+=unnamed
else
endif
" }}}
