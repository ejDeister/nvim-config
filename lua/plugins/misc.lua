return {
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter').install({
        'lua',
        'javascript',
        'typescript',
        'html',
        'css',
        'json',
        'bash',
        'go',
        'python'
      })
    end,
    build = ':TSUpdate'
  },

  -- cmp
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup{
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' }
          }),
        })
      }
    end,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3M0N4D3/LuaSnip' }
  },

  -- LuaSnip
  {
    'L3MON4D3/LuaSnip',
    config = function()
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.set_config({
        history = true,
        updateevents = 'TextChanged,TextChangedI'
      })
    end
  },

  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({options = { theme = 'auto' } })
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Misc
  { 'rafamadriz/friendly-snippets' },
  { 'hrsh7th/cmp-nvim-lsp' },
}
