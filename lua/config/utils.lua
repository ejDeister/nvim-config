local M = {}

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


return M
