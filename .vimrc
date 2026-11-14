" Tab settings
set expandtab
set autoindent
set formatoptions=coql
set cinoptions=:0,l1,t0,g0,(0   " C-Indent options: K&R style
set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set tabstop=4
set shiftwidth=4
au FileType go set tabstop=8 shiftwidth=8 noexpandtab
au FileType make set tabstop=8 shiftwidth=8 noexpandtab

" Linebreak settings
set nowrap
set linebreak

" Search and macro settings
set incsearch
set hlsearch
set lazyredraw
set ignorecase

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
set number
set wildmenu
set showtabline=2
set linespace=3

" GUI settings
if has("gui_running")
    "set guifont=DejaVu\ Sans\ Mono:h10
    "set guifont=Comic\ Mono:h12
    set guioptions=egitrm
    "colorscheme gruvbox
    colorscheme peachpuff

    if &diff
        au GUIEnter * simalt ~x
    else
        set columns=90 lines=40
    endif
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
"autocmd BufEnter * silent! lcd %:p:h 

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
nnoremap <Space> :call ToggleComment()<CR>
vnoremap <Space> :call ToggleComment()<CR>
nnoremap ,, :nohl<CR>
noremap ½ $

augroup keymapforfiletypes
    au FileType python nnoremap <buffer> <F5> :!/home/sbn/venv/bin/python %<CR>
augroup end

" CTags
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    nmap ,b :!cscope -bR<CR>
    nmap ,s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap ,g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap ,c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap ,t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap ,e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap ,f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap ,i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap ,d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap ,a :cs find a <C-R>=expand("<cword>")<CR><CR>

    nmap ;s :cs find s 
    nmap ;g :cs find g 
    nmap ;c :cs find c 
    nmap ;t :cs find t 
    nmap ;e :cs find e 
    nmap ;f :cs find f 
    nmap ;i :cs find i 
    nmap ;d :cs find d 
    nmap ;a :cs find a 
endif
