local M = {}

M.opts = { noremap = true, silent = true }

-- General
M.default = 'No description provided.'
M.kmr = 'Key Map Reload - Refresh keymaps without reloading neovim.'
M.sess = 'Session - Restore session from previous neovim instance.'
M.tlf = 'Top Level Fold - Jump cursor top level of indentation.'
M.dx = 'Diagnostics - Display warnings and/or errors.'

-- Telescope
M.tsff = 'TeleScope Find Files'
M.tsb = 'TeleScope Buffers'
M.tsws = 'TeleScope WorkSpace'
M.tslg = 'TeleScope Live Grep'

-- UI
M.toggleTerm = 'ToggleTerm [register]'

M.ctrlw = 'Ctrl + w'
M.x = 'close buffer'
M.bd = 'Buffer Delete (goto previous)'
M.bD = 'Buffer Deleter (goto next)'

M.tabc = 'Tab Close'
M.tabe = 'Tab Edit (current buffer)'
M.tabo = 'Tab Only (close all except current)'
M.bufo = 'Buffer Only (close all except current)'

-- BufferLine
M.tab = ':BufferLineCycleNext'
M.stab = ':BufferLineCyclePrev'
M.blt = 'BufferLineTabs'
M.blb = 'BufferLineBuffers'
M.blp = 'BufferLinePick (and open)'
M.blP = 'BufferLInePick (and close)'

-- LSP
M.gd = 'Goto Definition of symbol'
M.gD = 'Goto Declaration of symbol'
M.gt = 'Goto Type-definition of symbol'
M.gr = 'Goto References of symbol'

M.lshov = 'LSP Hover - Show LSP hover popup'
M.lssig = 'LSP Signature - Show LSP signature hint'
M.lsrn = 'LSP ReName - Global rename symbol via LSP'
M.lsca = 'LSP Code Action - Code action via LSP'

-- Oil
M.fet = 'File Explorer Toggle'
M.fes = "File Explorer Save - Save Oil's CWD to given register"
M.fer = "File Explorer Restore - Set Oil's CWD to given register's path"

-- Hop
M.hw = ':HopWord'
M.hl = ':HopLine'

-- Git
M.gdif = ':Gdiffsplit HEAD'
M.gvdif = ':Gvdiffsplit HEAD'
M.gcoms = ':Telescope git_commits'
M.gbcoms = ':Telescope git_bcommits'
M.gdifall = 'Git Diff All - For each file matching regex, open a vertical diff in a new tab.'

return M
