vim.opt.sessionoptions = {
  'curdir',
  'folds',
  'help',
  'tabpages',
  'winsize',
  'terminal',
  'buffers'
}

local newAutoCmd = vim.api.nvim_create_autocmd

local sessFile = vim.fn.stdpath('state') .. '/sesions/default-session.vim'
newAutoCmd('VimLeavePre', {
  group = vim.api.nvim_create_augroup('SessGroup', { clear = true }),
  callback = function()
    vim.cmd('mksession!' .. vim.fn.fnameescape(sessFile))
  end,
})
