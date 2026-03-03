local M = {}

-- ToggleTerm
M.toggleTerminal = function(number)
  return function()
    require('plugins.utils')
    local git_root = vim.fn.FugitiveWorkTree()
    local oil_dir = require('oil').get_current_dir()
    local dir = vim.fn.expand('%:p:h')
    if dir:match('^%a+://') then dir = '' end

    local term_dir = (git_root ~= '' and git_root) or (oil_dir ~= '' and oil_dir) or (dir ~= '' and dir) or vim.fn.getcwd()

    require('toggleterm.terminal').Terminal:new({
      dir = term_dir,
      count = number,
    }):toggle()
  end
end

local active_path = nil
local function getRegister()
  local char = vim.fn.getcharstr()
  if char == nil or char == '\27' then return nil end  -- ESC = cancel
  if char == '\13' or char == '' then return '"' end   -- Enter/empty = default
  return char
end


local oil_path_registers = {}
local function savePathToOilRegister()
  local reg = getRegister()
  if reg then
    local oil = require('oil')
    local path
    path = oil.get_current_dir()
    oil_path_registers[reg] = path
    vim.notify('@' .. reg .. ' ← ' .. path, vim.log.levels.INFO)
  else
    vim.notify('canceled path registry')
  end
end
M.savePathToOilRegister = savePathToOilRegister

local function toggleRegisterFloat()
  local reg = getRegister()
  if reg then
    local oil = require('oil')
    local path = oil_path_registers[reg]
    if active_path == nil then
      oil.toggle_float(path)
      active_path = path
    elseif active_path == path then
      oil.toggle_float(path)
      active_path = nil
    elseif active_path ~= path then
      oil.close()
      oil.open_float(path)
      active_path = path
    end
  else
    vim.noftify('caneled registry fetch')
  end
end
M.toggleRegisterFloat = toggleRegisterFloat

M.scoot = function(key)
  local percent = tonumber(vim.fn.input('Percentage scoot (0-100)'))
  if key == 'H' then
    local colsToScoot = math.floor(vim.o.columns * percent / 100)
    vim.cmd('vertical resize -' .. vim.o.columns)
    vim.cmd('vertical resize +' .. colsToScoot)
  elseif key == 'L' then
    local colsToScoot = math.floor(vim.o.columns * percent / 100)
    vim.cmd('vertical resize +' .. vim.o.columns)
    vim.cmd('vertical resize -' .. colsToScoot)
  elseif key == 'J' then
    local linesToScoot = math.floor(vim.o.lines * percent / 100)
    vim.cmd('resize -' .. vim.o.columns)
    vim.cmd('resize +' .. linesToScoot)
  elseif key == 'K' then
    local linesToScoot = math.floor(vim.o.lines * percent / 100)
    vim.cmd('resize +' .. vim.o.columns)
    vim.cmd('resize -' .. linesToScoot)
  end
end

M.gdifall = function()
  local pattern = vim.fn.input('Diff files matching (lua regex, empty = all): ')

  local git_root = vim.fn.FugitiveWorkTree()
  if git_root == '' then
    vim.notify('Not in a git repo', vim.log.levels.ERROR)
    return
  end

  local commitOne = vim.fn.input('Base commit (empty = HEAD): ')
  local commitTwo = ''
  if commitOne ~= '' then
    commitTwo = vim.fn.input('Target commit (empty = working tree): ')
  end

  local base = commitOne ~= '' and commitOne or 'HEAD'
  local diff_args = commitTwo ~= '' and (base .. ' ' .. commitTwo) or base

  local output = vim.fn.system('git -C ' .. vim.fn.shellescape(git_root) .. ' diff --name-only ' .. diff_args)
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to run git diff: ' .. output, vim.log.levels.ERROR)
    return
  end

  local files = vim.split(output, '\n', { trimempty = true })
  local matched = {}
  for _, file in ipairs(files) do
    if pattern == '' or file:match(pattern) then
      matched[#matched + 1] = file
    end
  end

  if #matched == 0 then
    vim.notify('No modified files matched', vim.log.levels.WARN)
    return
  end

  local tabs = {}
  for _, file in ipairs(matched) do
    if commitTwo ~= '' then
      vim.cmd('tabnew')
      vim.cmd('Gedit ' .. commitTwo .. ':' .. vim.fn.fnameescape(file))
    else
      vim.cmd('tabedit ' .. vim.fn.fnameescape(git_root .. '/' .. file))
    end
    vim.cmd('Gvdiffsplit ' .. base)
    table.insert(tabs, vim.api.nvim_get_current_tabpage())
  end
end

-- Deprecated, different approach will be taken to Git quickfixes
-- -- QuickFix Tabs
-- M.quickFixTabs = function(tabs)
--   local items = {}
--   local tabmap = {}
-- 
--   local api = vim.api
--   for i, tab in ipairs(tabs) do
--     local win = api.nvim_tabpage_get_win(tab)
--     local buf = api.nvim_win_get_buf(win)
--     local name = api.nvim_buf_get_name(buf)
--     if name == '' then name = '[No Name]' end
-- 
--     local short = vim.fn.fnamemodify(name,':~:.')
--     local modified = api.nvim_buf_get_option(buf,'modified') and '[+]' or ''
--     local text = string.format('tab %d %s %s', i, modified, short)
-- 
--     table.insert(items, {
--       filename = name,
--       lnum = 1,
--       col = 1,
--       text = text,
--     })
--     table.insert(tabmap, {
--       tabnr = i,
--       tabpage = tab,
--     })
--   end
-- 
--   return items, tabmap
-- end

return M
