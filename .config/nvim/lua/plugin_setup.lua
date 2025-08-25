-- telescope
require('telescope').load_extension('fzf')
require('telescope').setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
        vertical = {
           width = 0.75, 
           height = 0.9,
           preview_height = 0.5,
           preview_cutoff = 0
        }
    },
  },
  pickers = {
    find_files = {
      theme = "ivy"
    },
    current_buffer_fuzzy_find = { sorting_strategy = 'descending' },
    buffers = {
      -- ignore_current_buffer = true,
      show_all_buffers = true,
      -- sort_lastused = true,
      sort_mru = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
            ["d"] = "delete_buffer",
        }
      }
    }
  },
  extension = {
    fzf = {}
  }
})

-- auto complete
local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({select = false}),
    ['<C-n>'] = cmp.mapping(function(fallback)
            local status_ok, luasnip = pcall(require, "luasnip")
            if status_ok and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
    ['<C-b>'] = cmp.mapping(function(fallback)
            local status_ok, luasnip = pcall(require, "luasnip")
            if status_ok and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

    -- Navigate suggestion popup window for lsp
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  },
})

-- nvim-tree
require("nvim-tree").setup({
  filters = {
    git_ignored = false,
    custom = {
      "node_modules",
      "cache",
      ".git",
      ".DS_Store"
    },
  },
})
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7c7653" })

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "luadoc", "vim", "vimdoc", "markdown", "query", "ruby", "javascript", "html", "css", "go", "elixir", "yaml" },
  sync_install = false,
  highlight = { 
    enable = true,
    disable = "help"
  },
  indent = { enable = true },
  endwise = {
      enable = true,
  },
})

