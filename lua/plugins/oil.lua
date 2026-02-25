return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('oil').setup({
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(_, _)
            return false
          end,
        },
        float = {
          max_width = 80,
          max_height = 40,
        },
      })
    end
  }
}
