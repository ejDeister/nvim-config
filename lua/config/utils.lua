local M = {}

local function toggleTerminal(number)
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
M.toggleTerminal = toggleTerminal

local path_registers = {}
local active_path = nil
local function getRegister()
  local char = vim.fn.getcharstr()
  if char == nil or char == '\27' then return nil end  -- ESC = cancel
  if char == '\13' or char == '' then return '"' end   -- Enter/empty = default
  return char
end

local function savePathToRegister()
  local reg = getRegister()
  if reg then
    local oil = require('oil')
    local path
    path = oil.get_current_dir()
    path_registers[reg] = path
    vim.notify('@' .. reg .. ' ← ' .. path, vim.log.levels.INFO)
  else
    vim.notify('canceled path registry')
  end
end
M.savePathToRegister = savePathToRegister

local function toggleRegisterFloat()
  local reg = getRegister()
  if reg then
    local oil = require('oil')
    local path = path_registers[reg]
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

local function scoot(key)
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
M.scoot = scoot

return M
