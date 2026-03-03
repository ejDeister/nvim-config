local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local utils = require('config.utils')

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode,lhs,rhs, {
    noremap = true,
    silent = true,
  })
end

-- vim
local reloadKeymaps = function()
  package.loaded['config.keymaps'] = nil
  require('config.keymaps')
  print('Keymaps reloaded!')
end
map('n', '<leader>kmr', reloadKeymaps, opts)

local restoreSession = function()
  vim.cmd('tabonly')
  vim.cmd('%bd!')
  vim.cmd('silent! source ~/.local/state/nvim/sessions/default-session.vim')
end
map('n', '<leader>sess', restoreSession, opts)
map('n', '<leader>tlf', '<cmd>normal zMzv999[zzRzt<cr>', opts)


-- telescope
map('n', '<leader>tsff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>tsb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>tsws', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)
map('n', '<leader>tslg', '<cmd>Telescope live_grep<cr>', opts)


-- ui
local toggleTerm = utils.toggleTerminal
map('n', '<C-\\>a', toggleTerm(1), opts)
map('t', '<C-\\>a', toggleTerm(1), opts)
map('n', '<C-\\>b', toggleTerm(2), opts)
map('t', '<C-\\>b', toggleTerm(2), opts)
map('n', '<C-\\>c', toggleTerm(3), opts)
map('t', '<C-\\>c', toggleTerm(3), opts)

map('n', '<leader>w', '<C-w>', opts)
map('n', '<leader>x', '<cmd>bd<cr>', opts)
map('n', '<leader>bd', '<cmd>bp | bd #<cr>', opts)
map('n', '<leader>bD', '<cmd>bn | bd #<cr>', opts)
map('n', '<leader>tabc', '<cmd>tabc<cr>', opts)
map('n', '<leader>tabe', '<cmd>tabe %<cr>', opts)
map('n', '<leader>tabo', '<cmd>tabonly<cr>', opts)
map('n', '<leader>bufo', '<cmd>%bd|e#|bd#<cr>', opts)

map('n', '<leader>H', function() utils.scoot('H') end, opts)
map('n', '<leader>J', function() utils.scoot('J') end, opts)
map('n', '<leader>K', function() utils.scoot('K') end, opts)
map('n', '<leader>L', function() utils.scoot('L') end, opts)

-- bufferline
map('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', opts)
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', opts)
map('n', '<leader>blt', '<cmd>BufferlineTabs<cr>', opts)
map('n', '<leader>blb', '<cmd>BufferlineBuffers<cr>', opts)
map('n', '<leader>blp', '<cmd>BufferLinePick<cr>', opts)
map('n', '<leader>blP', '<cmd>BufferLinePickClose<cr>', opts)


-- lsp
local buf = vim.lsp.buf

map('n', 'gd', buf.definition, opts) 
map('n', 'gD', buf.declaration, opts) 
map('n', 'gt', buf.type_definition, opts) 
map('n', 'gr', buf.references, opts) 

map('n', '<leader>lshov', buf.hover, opts)
map('n', '<leader>lssig', buf.signature_help, opts)
map('n', '<leader>lsrn', buf.rename, opts)
map('n', '<leader>lsca', buf.code_action, opts)

map('n', '<leader>dx', '<cmd>normal <C-w>d<cr>', opts)


-- oil
map('n', '<leader>fet', function() require('oil').toggle_float() end, opts)
map('n', '<leader>fes', function() utils.savePathToOilRegister() end, opts)
map('n', '<leader>fer', function() utils.toggleRegisterFloat() end, opts)

-- hop
map('n', '<leader>hw', '<cmd>HopWord<cr>', opts)
map('n', '<leader>hl', '<cmd>HopLine<cr>', opts)


-- git
map('n', '<leader>gdif', '<cmd>Gdiffsplit HEAD<cr>', opts)
map('n', '<leader>gvdif', '<cmd>Gvdiffsplit HEAD<cr>', opts)
map('n', '<leader>gcoms', '<cmd>Telescope git_commits<cr>', opts)
map('n', '<leader>gbcoms', '<cmd>Telescope git_bcommits<cr>', opts)

map('n', '<leader>gdifall', function() utils.gdifall() end, vim.tbl_extend('force', opts, { desc = 'Gvdiffsplit HEAD for modified files matching regex' }))
