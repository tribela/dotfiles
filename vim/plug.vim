if has('nvim')
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'kjwon15/vim-transparent'
autocmd ColorScheme * silent! call background#clear_background()

if !has('nvim')
  Plug 'markonm/traces.vim' " Preview substitute
endif

" Colorschemes
Plug 'hachy/eva01.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'yous/vim-open-color'

" Tools
Plug 'Chiel92/vim-autoformat' " Auto format uglified files
let g:formatterpath=[$HOME.'/.yarn/bin', $HOME.'/.local/bin']
Plug 'taku-o/vim-toggle' " + to toggle value

if !exists('g:vscode')
  Plug 'github/copilot.vim'
endif

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
Plug 'dense-analysis/ale' " Async lint engine
nmap [x <Plug>(ale_previous_wrap)
nmap ]x <Plug>(ale_next_wrap)
let g:ale_completion_enabled = 1
au FileType python let b:ale_linters = ['flake8']
Plug 'roryokane/detectindent'
Plug 'editorconfig/editorconfig-vim'
au BufRead * DetectIndent
Plug 'kshenoy/vim-signature' " SignColumn marker
Plug 'ap/vim-css-color', { 'for': ['css'] }
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'jinja', 'jinja2']} " HTML zencoding.
let g:user_emmet_leader_key='<C-y>'
Plug 'lepture/vim-jinja', {'for': ['html', 'jinja', 'jinja2']}
Plug 'kjwon15/auto-pairs'
Plug 'sheerun/vim-polyglot'  " All in one filetypes

" Filetype
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'chaimleib/vim-renpy', {'for': 'renpy'}
Plug 'vim-scripts/icalendar.vim', {'for': 'icalendar'}

"Vimdeck
Plug 'vim-scripts/SyntaxRange'
Plug 'vim-scripts/ingo-library'

" code scratchpad
Plug 'metakirby5/codi.vim'

" Snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
let g:snipMate = { 'snippet_version': 1 }
" let g:neosnippet#enable_snipmate_compatibility = 1
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
" End snipmate

" Shell script lint.
" Install shellcheck to use.
Plug 'vim-syntastic/syntastic', {'for': 'sh'}

if !exists('g:vscode')
  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
  else
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    " Plug 'davidhalter/jedi'
    " Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
    " Plug 'Shougo/deoplete-clangx', {'for': ['c', 'cpp']}
  endif

  Plug 'Shougo/deoplete.nvim'
  let g:deoplete#enable_at_startup = 1
endif

call plug#end()

" Deoplete options must be after plug#end
if exists('g:deoplete#_initialized')
  call deoplete#custom#option({
        \ 'auto_complete_delay': 200,
        \ 'smart_case': v:true,
        \ })
endif
