local M = {}

-- ToggleTerm
local function toggleTerminal(number)
  return function()
    require('plugins.utils')
    local git_root = vim.fn.FugitiveWorkTree()
    local dir = vim.fn.expand('%:p:h')
    local term_dir = (git_root ~= '' and git_root) or (dir ~= '' and dir) or nil

    require('toggleterm.terminal').Terminal:new({
      dir = term_dir,
      count = number,
    }):toggle()
  end
end
M.toggleTerminal = toggleTerminal

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

local function openRegisterFloat()
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
M.openRegisterFloat = openRegisterFloat

-- QuickFix Tabs
local function quickFixTabs(tabs)
  local items = {}
  local tabmap = {}

  local api = vim.api
  for i, tab in ipairs(tabs) do
    local win = api.nvim_tabpage_get_win(tab)
    local buf = api.nvim_win_get_buf(win)
    local name = api.nvim_buf_get_name(buf)
    if name == '' then name = '[No Name]' end

    local short = vim.fn.fnamemodify(name,':~:.')
    local modified = api.nvim_buf_get_option(buf,'modified') and '[+]' or ''
    local text = string.format('tab %d %s %s', i, modified, short)

    table.insert(items, {
      filename = name,
      lnum = 1,
      col = 1,
      text = text,
    })
    table.insert(tabmap, {
      tabnr = i,
      tabpage = tab,
    })
  end

  return items, tabmap
end

return M
