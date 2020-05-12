set nocompatible
set encoding=utf-8
" Setup for vundle {{{
filetype off

set rtp +=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-ragtag'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-liquid'
Plugin 'mxw/vim-jsx'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'junegunn/fzf.vim'

Plugin 'ap/vim-css-color'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'haishanh/night-owl.vim'
call vundle#end()

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

call plug#end()

filetype plugin indent on
"source ~/.vim/plugged/coc.vim
" }}} 

" Leader {{{
let mapleader = " "
let g:mapleader = " "

" https://stackoverflow.com/questions/14737429/how-to-disable-the-timeout-on-the-vim-leader-key
set notimeout
set ttimeout
set timeoutlen=100
" }}}


set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoindent
set smartindent
set wrap

syntax on
syntax enable

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
"set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
"if executable('ag')
"  " Use Ag over Grep
"  set grepprg=ag\ --nogroup\ --nocolor
"
"  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
"
"  " ag is fast enough that CtrlP doesn't need to cache
"  let g:ctrlp_use_caching = 0
"
"  if !exists(":Ag")
"    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"    nnoremap \ :Ag<SPACE>
"  endif
"endif

" Make it obvious where 80 characters is
set textwidth=120
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Setup for Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_settings = {
\  'html': {
\     'comment_type': 'lastonly'
\   }  
\}

let g:emmet_html5 = 0
let g:user_emmet_leader_key = ','
" Also goog to setup a way to add html comment at cloing tag sepaerately
inoremap <! <!-- --><Esc>gEa

"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Move lines like Sublime
nnoremap <C-S-Up> :m-2<CR>
nnoremap <C-S-Down> :m+<CR>
inoremap <C-S-Up> <Esc>:m-2<CR>
inoremap <C-S-Down> <Esc>:m+<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quick Save file
nnoremap <C-s> :w<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" open the terminal and how to close it
nnoremap <silent> <leader>t :term<CR>
tnoremap kj <C-\><C-n>:q!<CR>
tnoremap kn <C-\><C-n>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell


" Config Plugin {{{
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#bufferline#enabled = 0
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline_theme='luna'
"let g:airline_solarized_bg='dark'

let g:ragtag_global_maps = 1

if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif

set wildignore+=*\\tmp\\*,*\\vendor\\*,*\\node_modules\\*,*.swp,*.zip,*.exe
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:vim_markdown_folding_disabled = 1


" ALE setup
" Set specific linters
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0
"let g:ale_sign_column_always = 1

" Integrate lightline with ALE
let g:lightline = {}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

"}}}

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


"set fileformats=unix
" for night-owl color-scheme
if (has("termguicolors"))
 set termguicolors
endif

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors


if !has('gui_running')
  set t_Co=256
endif

"colorscheme night-owl
"colorscheme zenburn
"colorscheme nord

highlight clear LineNr
highlight clear SignColumn
highlight LineNr cterm=NONE ctermfg=darkgrey
highlight VertSplit cterm=NONE ctermfg=darkgray
highlight Comment ctermfg=darkgray


let g:lightline = { 'colorscheme': 'wombat' }
"let g:lightline = { 'colorscheme': 'nightowl'  }
"set background=dark

"set clipboard=unnamed
"set clipboard=unnamedplus

"set ttymouse=sgr
"set mouse=a
