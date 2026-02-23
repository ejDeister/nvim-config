return {
  -- autopairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  },

  -- comment
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{}
    end
  },
  { 'tpope/vim-fugitive' },

  -- hop
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup{}
    end
  },

  -- misc
  { 'tpope/vim-surround' },
  { 'mbbill/undotree' },
} 
