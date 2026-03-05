local opts = require('config.maphelpers')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts.opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function map(mode, lhs, rhs, desc)
  desc = desc or 'Description not provided.'
  vim.keymap.set(mode,lhs,rhs, {
    noremap = true,
    silent = true,
    desc = desc,
  })
end

-- vim
local reloadKeymaps = function()
  package.loaded['config.keymaps'] = nil
  require('config.keymaps')
  print('Keymaps reloaded!')
end
map('n', '<leader>kmr', reloadKeymaps, opts.kmr)

local restoreSession = function()
  vim.cmd('tabonly')
  vim.cmd('%bd!')
  vim.cmd('silent! source ~/.local/state/nvim/sessions/default-session.vim')
end
map('n', '<leader>sess', restoreSession, opts.sess)
map('n', '<leader>tlf', '<cmd>normal zMzv999[zzRzt<cr>', opts.tlf)


-- telescope
map('n', '<leader>tsff', '<cmd>Telescope find_files<cr>', opts.tsff)
map('n', '<leader>tsb', '<cmd>Telescope buffers<cr>', opts.tsb)
map('n', '<leader>tsws', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts.tsws)
map('n', '<leader>tslg', '<cmd>Telescope live_grep<cr>', opts.tslg)
map('n', '<leader>tskm', '<cmd>Telescope keymaps<cr>', opts.tskm)

-- ui
local toggleTerm = require('config.utils').toggleTerminal
map('n', '<C-\\>a', toggleTerm(1), opts.toggleTerm)
map('t', '<C-\\>a', toggleTerm(1), opts.toggleTerm)
map('n', '<C-\\>b', toggleTerm(2), opts.toggleTerm)
map('t', '<C-\\>b', toggleTerm(2), opts.toggleTerm)
map('n', '<C-\\>c', toggleTerm(3), opts.toggleTerm)
map('t', '<C-\\>c', toggleTerm(3), opts.toggleTerm)

map('n', '<leader>w', '<C-w>', opts.ctrlw)
map('n', '<leader>x', '<cmd>bd<cr>', opts.x)
map('n', '<leader>bd', '<cmd>bp | bd #<cr>', opts.bd)
map('n', '<leader>bD', '<cmd>bn | bd #<cr>', opts.bD)
map('n', '<leader>tabc', '<cmd>tabc<cr>', opts.tabc)
map('n', '<leader>tabe', '<cmd>tabe %<cr>', opts.tabe)
map('n', '<leader>tabo', '<cmd>tabonly<cr>', opts.tabo)
map('n', '<leader>bufo', '<cmd>%bd|e#|bd#<cr>', opts.bufo)


-- bufferline
map('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', opts.tab)
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', opts.stab)
map('n', '<leader>blt', '<cmd>BufferlineTabs<cr>', opts.blt)
map('n', '<leader>blb', '<cmd>BufferlineBuffers<cr>', opts.blb)
map('n', '<leader>blp', '<cmd>BufferLinePick<cr>', opts.blp)
map('n', '<leader>blP', '<cmd>BufferLinePickClose<cr>', opts.blP)


-- lsp
local buf = vim.lsp.buf

map('n', 'gd', buf.definition, opts.gd)
map('n', 'gD', buf.declaration, opts.gD)
map('n', 'gt', buf.type_definition, opts.gt)
map('n', 'gr', buf.references, opts.gr)

map('n', '<leader>lshov', buf.hover, opts.lshov)
map('n', '<leader>lssig', buf.signature_help, opts.lssig)
map('n', '<leader>lsrn', buf.rename, opts.lsrn)
map('n', '<leader>lsca', buf.code_action, opts.lsca)

map('n', '<leader>dx', '<cmd>normal <C-w>d<cr>', opts.dx)


-- oil
map('n', '<leader>fet', function() require('oil').toggle_float() end, opts.fet)
map('n', '<leader>fes', function() require('config.utils').savePathToOilRegister() end, opts.fes)
map('n', '<leader>fer', function() require('config.utils').toggleRegisterFloat() end, opts.fer)

-- hop
map('n', '<leader>hw', '<cmd>HopWord<cr>', opts.hw)
map('n', '<leader>hl', '<cmd>HopLine<cr>', opts.hl)


-- git
map('n', '<leader>gdif', '<cmd>Gdiffsplit HEAD<cr>', opts.gdif)
map('n', '<leader>gvdif', '<cmd>Gvdiffsplit HEAD<cr>', opts.gvdif)
map('n', '<leader>gcoms', '<cmd>Telescope git_commits<cr>', opts.gcoms)
map('n', '<leader>gbcoms', '<cmd>Telescope git_bcommits<cr>', opts.gbcoms)

map('n', '<leader>gdifall', function()
  local pattern = vim.fn.input('Diff files matching (lua regex): ')
  if pattern == '' then return end

  local git_root = vim.fn.FugitiveWorkTree()
  if git_root == '' then
    vim.notify('Not in a git repo', vim.log.levels.ERROR)
    return
  end

  local output = vim.fn.system('git -C ' .. vim.fn.shellescape(git_root) .. ' diff --name-only HEAD')
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to run git diff: ' .. output, vim.log.levels.ERROR)
    return
  end
  local files = vim.split(output, '\n', { trimempty = true })

  local matched = {}
  for _, file in ipairs(files) do
    if file:match(pattern) then
      matched[#matched + 1] = file
    end
  end

  if #matched == 0 then
    vim.notify('No modified files matched: ' .. pattern, vim.log.levels.WARN)
    return
  end

  for _, file in ipairs(matched) do
    vim.cmd('tabedit ' .. vim.fn.fnameescape(git_root .. '/' .. file))
    vim.cmd('Gvdiffsplit HEAD')
  end
end, vim.tbl_extend('force', opts, { desc = 'Gvdiffsplit HEAD for modified files matching regex' }))
