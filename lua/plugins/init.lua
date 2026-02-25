local plugins = {}
vim.list_extend(plugins, require('plugins.bufferline'))
vim.list_extend(plugins, require('plugins.colorscheme'))
vim.list_extend(plugins, require('plugins.lsp'))
vim.list_extend(plugins, require('plugins.misc'))
vim.list_extend(plugins, require('plugins.oil'))
vim.list_extend(plugins, require('plugins.telescope'))
vim.list_extend(plugins, require('plugins.toggleterm'))
vim.list_extend(plugins, require('plugins.utils'))



vim.list_extend(plugins, {
  -- Essentials
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },

})

return plugins
