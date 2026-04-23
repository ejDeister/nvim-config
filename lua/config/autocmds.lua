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

newAutoCmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.treesitter.start()
  end,
})

newAutoCmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'python', 'json', 'lua' },
  callback = function()
    vim.treesitter.start()
  end,
})
