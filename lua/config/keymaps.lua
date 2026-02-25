vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set
local opts = { noremap = true, silent = true }


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
map('n', '<leader>tlb', '<cmd>normal zMzv999[zzRzt<cr>', opts)


-- telescope
map('n', '<leader>tsff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>tsb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>tsws', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)
map('n', '<leader>tslg', '<cmd>Telescope live_grep<cr>', opts)


-- ui
map('n', '<C-\\>', function() require('toggleterm').toggle() end, opts)
map('t', '<C-\\>', function() require('toggleterm').toggle() end, opts)

map('n', '<leader>w', '<C-w>', opts)
map('n', '<leader>x', '<cmd>bd<cr>', opts)
map('n', '<leader>bd', '<cmd>bp | bd #<cr>', opts)
map('n', '<leader>bD', '<cmd>bn | bd #<cr>', opts)
map('n', '<leader>tabc', '<cmd>tabc<cr>', opts)
map('n', '<leader>tabe', '<cmd>tabe %<cr>', opts)
map('n', '<leader>tabo', '<cmd>tabonly<cr>', opts)
map('n', '<leader>bufo', '<cmd>%bd|e#|bd#<cr>', opts)


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


-- neotree
map('n', '<leader>fet', '<cmd>Neotree toggle<cr>', opts)
map('n', '<leader>fef', '<cmd>Neotree action=focus<cr>', opts)


-- hop
map('n', '<leader>hw', '<cmd>HopWord<cr>', opts)
map('n', '<leader>hl', '<cmd>HopLine<cr>', opts)


-- git
map('n', '<leader>gdif', '<cmd>Gdiffsplit HEAD<cr>', opts)
map('n', '<leader>gvdif', '<cmd>Gvdiffsplit HEAD<cr>', opts)
map('n', '<leader>gcoms', '<cmd>Telescope git_commits<cr>', opts)
map('n', '<leader>gbcoms', '<cmd>Telescope git_bcommits<cr>', opts)

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
