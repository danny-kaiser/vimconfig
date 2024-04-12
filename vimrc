let mapleader = ","
syntax on
set number
" autocommands to toggle number system for instert mode and loss of buffer
" focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" change refresh rate for latex-live-preview
autocmd Filetype tex setl updatetime=1

set noswapfile
set hlsearch
set ignorecase
set incsearch
set history=1000
set nocompatible
set list
set scrolloff=5

let g:user_emmet_leader_key=','

" set indent guides/lines
set listchars+=tab:┊\ 

" set end of line character to whitespace
set listchars+=eol:\ 

" send vim-slime to ipython in tmux
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_python_ipython = 1

" netrw settings
let g:netrw_altv = 1
let g:netrw_dirhistmax = 0

" More natural split defaults
set splitbelow
set splitright

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" fzf compatibility
set rtp+=/usr/local/opt/fzf

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Set shift width to 4 spaces.
set shiftwidth=2

" Set tab width to 4 columns.
set tabstop=2

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Gruvbox color palette.
let g:gruvbox_termcolors = '256'

" Gruvbox dark mode.
set bg=dark

" Gruvbox contrast.
let g:gruvbox_contrast_dark = 'medium'

" Linter config for Ale.
let g:ale_linters = {
\   'python': ['pylint'],
\   'javascript': ['eslint'],
\   'html': ['eslint'],
\   'css': ['eslint']
\}
let g:ale_fixers = {
\   'python': ['black'],
\   'javascript': ['eslint'],
\   'html': ['eslint'],
\   'css': ['eslint']
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_linters_explicit = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin()

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'morhetz/gruvbox'
autocmd vimenter * ++nested colorscheme gruvbox
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'prettier/vim-prettier'
Plug 'junegunn/vim-slash'
Plug 'rhysd/clever-f.vim'
Plug 'jpalardy/vim-slime'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'

call plug#end()

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

inoremap jk <ESC>
nnoremap <leader>t :stop<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz
nmap :LLP<cr> :LLPStartPreview<cr>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

"past toggle set to <leader>p
function! TogglePaste()
    if(&paste == 0)
        set paste
        echo "Paste Mode Enabled"
    else
        set nopaste
        echo "Paste Mode Disabled"
    endif
endfunction

map <leader>p :call TogglePaste()<cr>

func! WordProcessor()
  " movement changes
  map j gj
  map k gk
  " formatting text
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  " spelling and thesaurus
  setlocal spell spelllang=en_us
  set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
  " complete+=s makes autocompletion search the thesaurus
  set complete+=s
endfu
com! WP call WordProcessor()

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
