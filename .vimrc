filetype off
filetype plugin indent on
set nocompatible
set encoding=utf-8
set fileformat=unix
syntax on
syntax enable

" call plug#begin('~/.vim/plugged')
call plug#begin()
Plug 'chun-yang/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elmcast/elm-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'                           
Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'relastle/bluewery.vim'
Plug 'haishanh/night-owl.vim'
Plug 'cocopon/iceberg.vim'
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
inoremap <! <!-- --><Esc>gEa
noremap {/* {/*--- ---*/}<Esc>gEa}


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

" able to switch to background vim when hit <Tab>
nnoremap <C-i> <C-z>
nnoremap <silent> <silent> <Leader><Tab> :fg<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-k> :bp<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

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

nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>fg :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>fw bvey/<C-r>"<CR>"
let g:fzf_preview_window = ''
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1

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

let g:vimwiki_list = [{ 'path': '~/Documents/notes/', 'syntax':'markdown', 'ext': '.md' }]                  
let g:nv_search_paths = ['~/Documents/notes/']  


" for night-owl color-scheme
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set t_Co=256
set background=dark
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
let g:lightline = { 'colorscheme': 'iceberg' }

" This setting is specifically for NightOwl theme
" highlight Normal guifg=#d6deeb ctermfg=253 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
highlight Comment cterm=NONE

set mouse=a
