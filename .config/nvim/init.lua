-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- general setting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.textwidth = 100
vim.opt.colorcolumn = "+1"
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.splitright = true
vim.opt.splitbelow = true


vim.opt.background = "dark"
vim.opt.mouse = "a"

vim.cmd("set notimeout")
vim.cmd("set ttimeout")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
local plugin = {
  'cocopon/iceberg.vim',
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'RRethy/nvim-treesitter-endwise',
  'm4xshen/autoclose.nvim',

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
  'L3MON4D3/LuaSnip',

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
}

require("lazy").setup(plugin, {})

-- Theme
vim.cmd('silent! colorscheme iceberg')

-- LSP ruby setup
vim.g.lazyvim_ruby_lsp = "solargraph"
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#e7b3b3" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#5b92cb" })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#DE3163" })
vim.diagnostic.config({
  virtual_text = false,
})

-- Other Setups
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp_servers = {
  ruby_lsp = {},
}
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = lsp_servers,
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = capabilities,
        settings = lsp_servers[server_name],
        filetypes = (lsp_servers[server_name] or {}).filetypes,
      })
    end,
  },
})

local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Tab>'] = cmp.mapping.confirm({select = false}),
  },
})

require("nvim-tree").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "query", "ruby", "javascript", "html", "css", "go", "elixir", "yaml" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  endwise = {
      enable = true,
  },
})

require("autoclose").setup()

-- Key mapping
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', {silent = true})

-- Custom
-- Move lines like Sublime
vim.keymap.set('n', '<S-Up>',':m-2<CR>')
vim.keymap.set('n', '<S-Down>', ':m+<CR>')
vim.keymap.set('i', '<S-Up>', '<Esc>:m-2<CR>')
vim.keymap.set('i', '<S-Down>', '<Esc>:m+<CR>')

-- Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Switch between the last two files
vim.keymap.set('n', '<leader><leader>','<C-^>')

-- Search word
vim.keymap.set('n', '<leader>fw','bvey/<C-r>"<CR>')

-- Copy to system clipboard
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+y")

-- Preserve copy content
vim.keymap.set('x', '<leader>p', '\"_dP')

vim.keymap.set('n', 'sr','ysiw')
vim.keymap.set('n', 'n','nzz')
vim.keymap.set('n', 'N','Nzz')
vim.keymap.set('n', '<C-d>','<C-d>zz')
vim.keymap.set('n', '<C-u>','<C-u>zz')
vim.keymap.set('n', '*','*zz')
vim.keymap.set('n', '#','#zz')
vim.keymap.set('n', 'vv','<C-v>')
vim.keymap.set('n', '<CR>',':noh<C-v>')
vim.keymap.set('t', '<Esc>','<C-\\><C-n>')

