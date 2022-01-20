set nocompatible
set nu
set ru
set sw=4
set sts=4
set ts=8
set et
set ai
set cin
set smartindent
syntax on
set noeol
set backspace=indent,eol,start
set nobackup
set backupcopy=yes
set hlsearch
set incsearch " 순간검색
set ignorecase
set smartcase " 대문자로 검색하면 구분 함
set noea "창을 나눌 때 똑같이 만들지 않음.
set mouse=a "마우스 사용 가능
set autoread "외부에서 변경시 자동 읽기
set ve=onemore "줄 끝까지 커서 이동 가능
set modeline
set modelines=5
set autochdir
set showcmd
set wildmenu
set scrolloff=10 "Scroll before edge
set fencs=utf-8
filetype plugin indent on

" Use autocmd because just set is overwrited
autocmd! Filetype * setlocal formatoptions-=o " disable autocomment on o/O

if has('nvim')
  set inccommand=nosplit " Preview substitute
  let g:python3_host_prog=$HOME.'/.pyenv/shims/python3'
  let g:python_host_prog='/usr/bin/python2'
endif

if has('nvim')
  runtime ./plug.vim
  runtime ./maps.vim
else
  source ~/.vim/plug.vim
  source ~/.vim/maps.vim
endif

try
  if getbufvar(winbufnr(0), '&t_Co') == 256
    colo eva01
  else
    colo open-color
  endif
catch /E185/
  colo desert
endtry

set list
try
  set lcs=tab:↹\ ,trail:.,extends:>,precedes:<
catch /E474/
  set lcs=tab:\|\ ,trail:.,extends:>,precedes:<
endtry

au filetype python setlocal cc=80


" set cursor to the last worked line
set viewoptions=cursor
au BufWinLeave *.* mkview
au BufWinEnter *.* silent! loadview
" ---

if has("termguicolors") && has("nvim")     " set true colors
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  set termguicolors
endif


if has("gui_running")
    colo PaperColor
    set lines=60 columns=100
    set background=light
else
    set background=dark
endif

" for macvim
if has("gui_macvim")
  set guifont=source\ code\ pro\ semibold:h12
  set transparency=15
  set imd
endif

" for gvim
if has("gui_gtk2")
  set guifont=Source\ Code\ Pro\ Semi-Bold\ 11
endif
