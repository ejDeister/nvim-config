return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup{}
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'pyright', 'ts_ls', 'gopls', 'lua_ls' },
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp') and require('cmp_nvim_lsp') or nil
      local capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        (cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities() or {})
      )
      vim.lsp.config('*', { on_attach = on_attach, capabilities = capabilities })
    end
  },
}

