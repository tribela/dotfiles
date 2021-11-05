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
