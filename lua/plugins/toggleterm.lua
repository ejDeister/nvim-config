return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup{
        shell = os.getenv('TERMUX_VERSION') and ('proot -b $TMPDIR:/tmp ' .. vim.o.shell) or vim.o.shell,
        size = 20,
        direction = 'float'
      }
    end
  }
}

