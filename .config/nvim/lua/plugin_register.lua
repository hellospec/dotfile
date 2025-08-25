-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
local plugin = {
  'cocopon/iceberg.vim',
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'tpope/vim-rails',
  'tpope/vim-surround',
  'tpope/vim-ragtag',
  -- 'RRethy/nvim-treesitter-endwise',
  -- 'm4xshen/autoclose.nvim',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-vsnip',
  'L3MON4D3/LuaSnip',
    dependencies = { "rafamadriz/friendly-snippets" },

  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  {
    "nelstrom/vim-textobj-rubyblock",
    dependencies = { "kana/vim-textobj-user" },
  }
}

require("lazy").setup(plugin, {})


