return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup{
        shell = 'proot -b $TMPDIR:/tmp ' .. vim.o.shell,
        size = 20,
        direction = 'float'
      }
    end
  }
}

