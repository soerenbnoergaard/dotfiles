" Tab settings
set expandtab
set autoindent
set formatoptions=coql
set cinoptions=:0,l1,t0,g0,(0   " C-Indent options: K&R style
set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set tabstop=4
set softtabstop=4
set shiftwidth=4
au FileType go setlocal tabstop=8 shiftwidth=8 noexpandtab
au FileType make setlocal tabstop=8 shiftwidth=8 noexpandtab
au BufRead,BufNewFile *.puml setlocal filetype=plantuml
au BufRead,BufNewFile *.pu setlocal filetype=plantuml

" Machine-specific settings
if hostname() ==# 'sbn-0540-u'
    au FileType c setlocal tabstop=3 shiftwidth=3 softtabstop=3 expandtab
    au FileType cpp setlocal tabstop=3 shiftwidth=3 softtabstop=3 expandtab
endif

" Linebreak settings
set nowrap
set linebreak

" Search and macro settings
set incsearch
set hlsearch
set lazyredraw
set ignorecase
set grepprg=git\ --no-pager\ grep\ --no-color\ -n\ $*
set grepformat=%f:%l:%m,%m\ %f\ match%ts,%f

" Combatibility settings
set hidden
set noswapfile
set encoding=utf-8
set fileformat=unix
set shortmess+=I
set shellslash
set mouse=a

" Windows/Linux settings
if has('win16') || has('win32') || has('win64') || has('win95') || has('win32unix')
    set clipboard+=unnamed
    set backspace=2
else
    set clipboard=unnamedplus
endif

" Layout settings
set nofoldenable
set foldmethod=syntax
set foldnestmax=2
set foldlevel=0
set laststatus=2
set nonumber
set wildmenu
set showtabline=2
set linespace=3
set list!
set listchars=tab:\|_,trail:$

" GUI settings
if has("gui_running")
    set background=dark
    "set guifont=DejaVu\ Sans\ Mono:h10
    "set guifont=Comic\ Mono:h12
    set guifont=Jetbrains\ Mono\ Medium\ 10
    "colorscheme desert
    "colorscheme peachpuff
    colorscheme retrobox

    if &diff
        if has('win16') || has('win32') || has('win64') || has('win95') || has('win32unix')
            au GUIEnter * simalt ~x
        else
            au GUIEnter * set columns=999 lines=999
        endif
    else
        "set columns=90 lines=40
    endif
else
    "colorscheme default
   colorscheme desert
endif


" Statusline
set statusline=
set statusline+=[%n]\                          " buffer number
set statusline+=%f\                            " file name
set statusline+=%h%m%r%w                       " flags
set statusline+=%=                             " right align
set statusline+=%(%l,%c%)\                     " line and column
set statusline+=[%{strlen(&ft)?&ft:'none'},    " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},   " encoding
set statusline+=%{&fileformat}]\               " file format
set statusline+=%<%P\                          " percent

" Change directory to buffer's (like autochdir)
" autocmd BufEnter * silent! lcd %:p:h 

" Enable syntax highlighting
syntax on

" Functions
function! ToggleComment()
    execute "normal ^"
    let commentstr=get({
        \'vim': '"',
        \'c': '//',
        \'cpp': '//',
        \'vhdl': '--',
        \'dts': '//',
        \'go': '//',
    \}, &filetype, '#')
    let L=len(commentstr)
    let linestart=strcharpart(getline('.')[col('.') - 1:], 0, L)
    if linestart == commentstr
        " Remove existing comment
        execute 'normal ' . L . 'x'
    else
        " Add comment
        execute 'normal i' . commentstr
    endif
endfunction

function! Timestamp()
    execute "normal a" . strftime("%Y-%m-%d %H%M")
endfunction

" Key mapping

let mapleader = ","
nnoremap <Space> :call ToggleComment()<CR>
vnoremap <Space> :call ToggleComment()<CR>
nnoremap <Leader><Leader> :nohl<CR>
noremap ½ $

augroup keymapforfiletypes
    au FileType python nnoremap <buffer> <F5> :!/home/sbn/venv/bin/python %<CR>
    au FileType plantuml nnoremap <buffer> <F5> :!plantuml -gui % &<CR>
augroup end

" cscope
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb

    function LoadCscope()
        if filereadable("cscope.out")
            cs add cscope.out
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
    endfunction
    au DirChanged * :call LoadCscope()

    set csverb

    nmap <Leader>b :!cscope -bRv<CR>

    nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader><S-f> :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>a :cs find a <C-R>=expand("<cword>")<CR><CR>

    nmap <Leader><S-s> :cs find s 
    nmap <Leader><S-g> :cs find g 
    nmap <Leader><S-c> :cs find c 
    nmap <Leader><S-t> :cs find t 
    nmap <Leader><S-e> :cs find e 
    nmap <Leader>f :cs find f 
    nmap <Leader><S-i> :cs find i 
    nmap <Leader><S-d> :cs find d 
    nmap <Leader><S-a> :cs find a 
endif
