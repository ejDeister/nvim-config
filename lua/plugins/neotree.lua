return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('neo-tree').setup{
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = 'open_default',
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = { width = 30 },
      }
    end
  }
}
