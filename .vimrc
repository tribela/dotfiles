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
filetype plugin indent on

" Use autocmd because just set is overwrited
autocmd! Filetype * setlocal formatoptions-=o " disable autocomment on o/O

if has('nvim')
  set inccommand=nosplit " Preview substitute
endif

if has('nvim')
  let g:python3_host_prog=$HOME.'/.pyenv/shims/python3'
  let g:python_host_prog='/usr/bin/python2'
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'kjwon15/vim-transparent'
autocmd ColorScheme * silent! call background#clear_background()

" Tools
Plug 'Chiel92/vim-autoformat' " Auto format uglified files
let g:formatterpath=[$HOME.'/.yarn/bin', $HOME.'/.local/bin']
Plug 'taku-o/vim-toggle' " + to toggle value

" Colorschemes
Plug 'hachy/eva01.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'yous/vim-open-color'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'  " gcc to comment
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType crontab setlocal commentstring=#\ %s
autocmd FileType ia64 setlocal commentstring=;\ %s
autocmd FileType nginx setlocal commentstring=#\ %s
autocmd FileType debsources setlocal commentstring=#\ %s
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'rking/ag.vim'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_async = 0
Plug 'w0rp/ale' " Async lint engine
nmap [x <Plug>(ale_previous_wrap)
nmap ]x <Plug>(ale_next_wrap)
au FileType python let b:ale_linters = ['flake8']
Plug 'roryokane/detectindent'
au BufRead * DetectIndent
Plug 'markonm/traces.vim' " Preview substitute
Plug 'kshenoy/vim-signature' " SignColumn marker
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'jinja', 'jinja2']} " HTML zencoding.
let g:user_emmet_leader_key='<C-z>'
Plug 'lepture/vim-jinja', {'for': ['html', 'jinja', 'jinja2']}
Plug 'kjwon15/auto-pairs'
Plug 'sheerun/vim-polyglot'  " All in one filetypes
" Filetype
autocmd filetype javascript setlocal cino=:0
autocmd filetype ruby setlocal sw=2 sts=2
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'chaimleib/vim-renpy', {'for': 'renpy'}
Plug 'vim-scripts/icalendar.vim', {'for': 'icalendar'}
autocmd! BufRead,BufNewFile *.ics,*.ical setfiletype icalendar

"Vimdeck
Plug 'vim-scripts/SyntaxRange'
Plug 'vim-scripts/ingo-library'

" Snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#enable_snipmate_compatibility = 1
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" End snipmate

" Shell script lint.
" Install shellcheck to use.
Plug 'vim-syntastic/syntastic', {'for': 'sh'}

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'davidhalter/jedi'
Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
Plug 'Shougo/deoplete-clangx', {'for': ['c', 'cpp']}

call plug#end()

" Deoplete options must be after plug#end
if exists('g:deoplete#_initialized')
  call deoplete#custom#option({
        \ 'auto_complete_delay': 200,
        \ 'smart_case': v:true,
        \ })
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

"Spell check
au filetype gitcommit setlocal spell textwidth=72 | nnoremap <C-]> 1z=``
autocmd BufRead,BufNewFile *.md,*.rst setlocal spell | nnoremap <C-]> 1z=``
set spelllang+=cjk


"Scroll before edge
set scrolloff=10

set fencs=utf-8


map <C-S> :w<cr>
imap <C-s> <esc>:w<cr>i

if !exists('g:vscode')
  map <C-J> <C-W>-
  map <C-K> <C-W>+
  map <C-H> <C-W><
  map <C-L> <C-W>>
endif

"Up and Down for wrapped lines
nnoremap j gj
nnoremap k gk
if exists('g:vscode')
  map k gk
  map j gj
endif

"Up and Down key for scroll
nnoremap <up> <C-y>
nnoremap <down> <C-e>

"Jump to start and end of line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

"Force saving root permimssion file
if !exists('g:vscode')
  cnoremap w!! %!sudo tee > /dev/null %
endif

" Insert timestamp
inoremap <C-e> <C-r>=strftime("%Y-%m-%d %H:%M:%S %z")<cr>

map <space> <leader>
let mapleader=' '
"Clear search highlights
nnoremap <leader>/ :nohls<cr>
"When syntax highlight malfunctioning
nnoremap <leader>' :syntax sync fromstart<cr>

" System clipboard
nnoremap <leader>y gg"+yG``
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

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
au FileType html setlocal sw=2 sts=2


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
