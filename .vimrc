filetype off
filetype plugin indent on
set nocompatible
set encoding=utf-8
syntax on
syntax enable

set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
" Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-ragtag'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-liquid'
Plugin 'mxw/vim-jsx'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'ap/vim-css-color'
call vundle#end()

call plug#begin()
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'haishanh/night-owl.vim'
Plug 'cocopon/iceberg.vim'
Plug 'relastle/bluewery.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'elmcast/elm-vim'
call plug#end()

let mapleader = " "
let g:mapleader = " "

set autowrite         " Automatically :write before running commands
set autoindent
set backspace=2
set backupcopy=yes    " make Hot Module Reload (HRM) in Parcel to work
set colorcolumn=+1
set expandtab
set history=80
set incsearch         " do incremental searching
set laststatus=2      " Always display the status line
set nobackup
set nojoinspaces
set noswapfile        " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set notimeout
set nowritebackup
set number
set numberwidth=5
set ruler             " show the cursor position all the time
set shiftwidth=2
set shiftround
set splitbelow        " Open new split panes to right and bottom
set splitright
set tabstop=2
set textwidth=120
set ttimeout
set showcmd           " display incomplete commands
set smartindent
set wrap


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
"let g:user_emmet_expandabbr_key = '<Tab>'
let g:user_emmet_leader_key = ','
" Also goog to setup a way to add html comment at cloing tag sepaerately
inoremap <! <!-- --><Esc>gEa


" Move lines like Sublime
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

inoremap <S-Tab> <c-n>                 " inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
nnoremap <leader><leader> <c-^>        " Switch between the last two files
nnoremap <C-s> :w<CR>                  " Quick Save file
nnoremap <C-n> :NERDTreeToggle<CR>     " NERDTree

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

" open the terminal and how to close it
nnoremap <silent> <leader>t :term<CR>
tnoremap kj <C-\><C-n>:q!<CR>
tnoremap kn <C-\><C-n>

nnoremap <C-i> <C-z>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Quicker window movement
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" feavour Tim pope using vim surround
nmap sr ysiw

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" correct the identation for yml file
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
let g:fzf_preview_window = ''

" let g:ragtag_global_maps = 1
" if exists("g:ctrlp_user_command")
"   unlet g:ctrlp_user_command
" endif
" 
" set wildignore+=*\\tmp\\*,*\\vendor\\*,*\\node_modules\\*,*\\dist\\*,*\\public\\*,*.swp,*.zip,*.exe
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

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
" let g:lightline = { 'colorscheme': 'nighowl' }
"}}}


" Coc.nvim setup
set updatetime=300
inoremap <silent><expr> <c-space> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Elm format
let g:elm_format_autosave = 1

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


" if (has("termguicolors"))
"  set termguicolors
" endif
" 
" for night-owl color-scheme
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

if !has('gui_running')
  set t_Co=256
endif

syntax enable
set t_Co=256
set background=dark
" colorscheme night-owl
" colorscheme bluewery
colorscheme iceberg

highlight clear LineNr
highlight clear SignColumn
highlight LineNr cterm=NONE ctermfg=darkgrey
highlight VertSplit cterm=NONE ctermfg=darkgray
highlight Comment ctermfg=darkgray
highlight Comment ctermbg=0
hi jsComment cterm=NONE
hi jsImport cterm=NONE
hi jsFrom cterm=NONE
" let g:lightline = { 'colorscheme': 'wombat' }
let g:lightline = { 'colorscheme': 'iceberg' }

" This setting is specifically for NightOwl theme
" highlight Normal guifg=#d6deeb ctermfg=253 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
highlight Comment cterm=NONE

set mouse=a
