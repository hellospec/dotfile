" ----- initialize
" filetype off
" filetype plugin indent on
syntax on
syntax enable
set nocompatible
set encoding=utf-8
set fileformat=unix

" ----- plugins
call plug#begin('~/.config/nvim/data/plugins')
  " Plug 'neovim/nvim-lspconfig'
  " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'chun-yang/auto-pairs'

  Plug 'mattn/emmet-vim'
  Plug 'vim-ruby/vim-ruby'
  Plug 'pangloss/vim-javascript'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
  Plug 'vimwiki/vimwiki'                           
  Plug 'https://github.com/alok/notational-fzf-vim'

  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-fugitive'
  Plug 'rbong/vim-flog'

  Plug 'cocopon/iceberg.vim'
call plug#end()

let mapleader = " "
let g:mapleader = " "

" ----- general setting
set ruler
set incsearch
set expandtab
set autoindent
set smartindent
set wrap
set backspace=2
set colorcolumn=+1
set history=90
set nobackup
set nowritebackup
set noswapfile
set notimeout
set ttimeout
set number
set numberwidth=5
set shiftwidth=2
set shiftround
set splitright
set splitbelow
set tabstop=2
set textwidth=120
set mouse=a
set t_Co=256
set background=dark
set termguicolors

" ----- mapping
inoremap <! <!-- --><Esc>gEa
noremap {/* {/*--- ---*/}<Esc>gEa}

" Move lines like Sublime
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>
nnoremap <C-n> :NERDTreeToggle<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" feavour Tim pope using vim surround
nmap sr ysiw
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap vv <C-v>

nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>fg :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>fw bvey/<C-r>"<CR>"
let g:fzf_preview_window = ''

tnoremap <Esc> <C-\><C-n>


" ----- color and highlight
hi clear LineNr
hi clear SignColumn
hi LineNr cterm=NONE ctermfg=darkgrey
hi VertSplit cterm=NONE ctermfg=darkgray
hi Comment ctermfg=darkgray ctermbg=0 cterm=NONE
hi Normal ctermbg=234 ctermfg=252 guibg=#161821 guifg=#c6c8d1
hi jsComment cterm=NONE
hi jsImport cterm=NONE
hi jsFrom cterm=NONE

let &t_8f="\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b="\<Esc>[48:2:%lu:%lu:%lum"
colorscheme iceberg


" ----- Import plugin configs
source ~/.config/nvim/plugin_config/vim_go.vim
source ~/.config/nvim/plugin_config/coc.vim
source ~/.config/nvim/plugin_config/others.vim


lua << EOF

-- require('hello')
-- require('treesitter')
-- require('lsp')

EOF
