set nocompatible
se nu
se ru
se sw=4
se sts=4
se ts=8
se et
se ai
se cin
set smartindent
syntax on
set noeol
set backspace=indent,eol,start
set nobackup
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
filetype plugin indent on

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'kjwon15/vim-transparent'
autocmd ColorScheme * silent! call background#clear_background()

" Tools
Plug 'Chiel92/vim-autoformat' " Auto format uglified files

" Colorschemes
Plug 'hachy/eva01.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'yous/vim-open-color'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'  " gcc to comment
autocmd FileType crontab setlocal commentstring=#\ %s
autocmd FileType ia64 setlocal commentstring=;\ %s
autocmd FileType nginx setlocal commentstring=#\ %s
Plug 'tpope/vim-surround'
Plug 'toggle'
Plug 'rking/ag.vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale' " Async lint engine
nmap [x <Plug>(ale_previous_wrap)
nmap ]x <Plug>(ale_next_wrap)
Plug 'ciaranm/detectindent'
au BufRead * DetectIndent
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'jinja']} " HTML zencoding.
let g:user_emmet_leader_key='<C-z>'
Plug 'lepture/vim-jinja', {'for': ['html', 'jinja']}
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'nvie/vim-flake8', {'for': 'python'}

" Snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" End snipmate

" Shell script lint.
" Install shellcheck to use.
Plug 'vim-syntastic/syntastic', {'for': 'sh'}

Plug 'nathanalderson/yang.vim', {'for': 'yang'}

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  Plug 'zchee/deoplete-jedi', {'for': 'python'}
else
  Plug 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1
  Plug 'davidhalter/jedi-vim', {'for': 'python'}
endif

call plug#end()



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
au filetype javascript setlocal sw=2 sts=2

"Spell check
au filetype gitcommit setlocal spell textwidth=72 | nnoremap <C-]> 1z=``
autocmd BufRead,BufNewFile *.md,*.rst setlocal spell | nnoremap <C-]> 1z=``


"Scroll before edge
set scrolloff=10

set fencs=utf-8,utf-16le,cp437,cp949,euc-kr


map <C-S> :w<cr>
imap <C-s> <esc>:w<cr>i

map <C-J> <C-W>-
map <C-K> <C-W>+
map <C-H> <C-W><
map <C-L> <C-W>>
imap <C-J> <esc><C-W>-i
imap <C-K> <esc><C-W>+i
imap <C-H> <esc><C-W><i
imap <C-L> <esc><C-W>>i

"Up and Down for wrapped lines
nnoremap j gj
nnoremap k gk

"Up and Down key for scroll
nnoremap <up> <C-y>
nnoremap <down> <C-e>

"Jump to start and end of line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

"Force saving root permimssion file
cnoremap w!! %!sudo tee > /dev/null %

"Regex search
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>magic/

" Insert timestamp
inoremap <C-e> <C-r>=strftime("%Y-%m-%d %H:%M:%S %z")<cr>

map <space> <leader>
"Clear search highlights
nnoremap <silent><leader>/ :nohls<cr>
"When syntax highlight malfunctioning
nnoremap <silent><leader>' :syntax sync fromstart<cr>

"insert one charactor
nnoremap <leader><space> i_<esc>r
"indent all of files
nmap <leader>g gg=G``:%s/\s\+$//<cr>``
" Insert one line
function! s:MapNewlineInsert()
  if getbufvar(winbufnr(0), '&modifiable') && maparg('<CR>', 'n') == ''
    nnoremap <buffer> <CR> o<esc>
  endif
endfunction
autocmd BufNewFile,BufRead * call s:MapNewlineInsert()

if filereadable('Makefile')
  au Filetype c setlocal makeprg=make
else
  au FileType c setlocal makeprg=gcc\ -o\ %<\ %
    au FileType python setlocal makeprg=python\ -i\ %
endif
au FileType html setlocal sw=2


" set cursor to the last worked line
set viewoptions=cursor
au BufWinLeave *.c,*.cc,*.h,*.html,*.php,Makefile,*.py,*.sh mkview
au BufWinEnter *.c,*.cc,*.h,*.html,*.php,Makefile,*.py,*.sh loadview
" ---

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
