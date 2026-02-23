return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = 'dark'

      require('catppuccin').setup({
        flavour = 'mocha',
        transparent_background = false,
        term_colors = true,
        disable_nvimtree_bg = true,
      })
      vim.cmd.colorscheme = 'catppuccin'
    end,
  },
}
