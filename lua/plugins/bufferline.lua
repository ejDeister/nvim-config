return {
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup{
        options = {
          mode = 'tabs',
        }
      }

      -- Switch between tabpages vs. buffers
      vim.cmd([[command! BufferlineBuffers lua require('bufferline').setup({ options = { mode = 'buffers' } }]])
      vim.cmd([[command! BufferlineTabs lua require('bufferline').setup({ options = { mode = 'tabs' } }]])
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
}
