color desert
colo slate
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
set nobackup
set hlsearch
set incsearch " 순간검색
set ignorecase
set smartcase " 대문자로 검색하면 구분 함
set noea "창을 나눌 때 똑같이 만들지 않음.
"set mouse=a "마우스 사용 가능
set autoread "외부에서 변경시 자동 읽기
set ve=onemore "줄 끝까지 커서 이동 가능
set modeline
set modelines=5

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'toggle'
filetype plugin indent on



set list
set lcs=tab:↹\ ,trail:.,extends:>,precedes:<

au filetype python set cc=80
au filetype javascript set sw=2 sts=2

"Spell check
au filetype gitcommit setlocal spell
autocmd BufRead,BufNewFile *.md,*.rst setlocal spell

"Scroll before edge
set scrolloff=10

set fencs=utf-8,cp949,euc-kr


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

"Jump to start and end of line
noremap H ^
noremap L $

"Shortcut esc
inoremap lkj <esc>

"Force saving root permimssion file
cmap w!! %!sudo tee > /dev/null %

"Clear search highlights
noremap <silent><leader>/ :nohls<cr>

"insert one charactor
nmap <space> i_<esc>r
"indent all of files
nmap <leader>g mzgg=G'z

inoremap (<cr> (<cr>);<C-o>O
inoremap {<cr> {<cr>}<C-o>O
inoremap [<cr> [<cr>]<C-o>O
inoremap ({<cr> ({<cr>})<C-o>O

if filereadable('Makefile')
  au Filetype c set makeprg=make
else
  au FileType c set makeprg=gcc\ -o\ %<\ %
endif
au FileType python set makeprg=python\ -i\ %
au FileType html set sw=2


" set cursor to the last worked line
set viewoptions=cursor
au BufWinLeave *.c,*.cc,*.h,*.html,*.php,Makefile,*.py,*.sh mkview
au BufWinEnter *.c,*.cc,*.h,*.html,*.php,Makefile,*.py,*.sh loadview
" ---

if has("gui_running")
  set lines=60 columns=100
endif

" for macvim
if has("gui_macvim")
  set guifont=source\ code\ pro\ semibold:h12
  set transparency=15
  set imd
endif

" for gvim
if has("gui_gnome")
  set guifont=Source\ Code\ Pro\ Semi-Bold:h12
endif

function! SuperTab()
  if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction
inoremap <Tab> <C-r>=SuperTab()<cr>
