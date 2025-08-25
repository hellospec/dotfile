require("base")
require("plugin_register")
require("plugin_setup")
require("theme")
require("keymap")
require("go")

-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})

local lspconfig = require('lspconfig')
lspconfig.ruby_lsp.setup({
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
})

-- LSP Go
require("lspconfig").gopls.setup({
  cmd = {"gopls"},
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true
    }
  }
})

-- LSP Emmet
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/cssls.lua
lspconfig.cssls.setup {
  capabilities = capabilities,
}
lspconfig.emmet_language_server.setup({})

-- lspconfig.emmet_ls.setup({
-- 	-- on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = {
-- 		"css",
-- 		"html",
-- 		"javascript",
-- 		"javascriptreact",
-- 		"less",
-- 		"sass",
-- 		"typescript",
-- 		"scss",
-- 		"svelte",
-- 		"pug",
-- 		"typescriptreact",
-- 		"vue",
-- 	},
-- 	init_options = {
-- 		html = {
-- 			options = {
-- 				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
-- 				["bem.enabled"] = true,
-- 			},
-- 		},
-- 	},
-- })

lspconfig.shopify_theme_ls.setup{}
lspconfig.theme_check.setup{}

