local M = {}

M.opts = { noremap = true, silent = true }

-- General
M.default = 'No description provided.'
M.kmr = 'Key Map Reload - Refresh keymaps without reloading neovim.'
M.sess = 'Session - Restore session from previous neovim instance.'
M.tlf = 'Top Level Fold - Jump cursor top level of indentation.'
M.dx = 'Diagnostics - Display warnings and/or errors.'

-- Telescope
M.tsff = 'TeleScope Find Files | Search CWD for files'
M.tsb = 'TeleScope Buffers | Search open buffers'
M.tsws = 'TeleScope WorkSpace | Search workspace symbols'
M.tslg = 'TeleScope Live Grep | Search CWD for regex /w grep'

-- UI
M.toggleTerm = 'ToggleTerm [register]'

M.ctrlw = 'Ctrl + w'
M.x = 'close buffer'
M.bd = 'Buffer Delete (goto previous buffer)'
M.bD = 'Buffer Delete (goto next buffer)'

M.tabc = 'Tabpage Close'
M.tabe = 'Tabpage Edit (current buffer)'
M.tabo = 'Tabpage Only (close all except current)'
M.bufo = 'Buffer Only (close all except current)'

M.scoot = 'H|J|K|L, 0-100 | Scoot the current window by 0-100%'

M.cst = 'ColorScheme Toggle | Toggle between light/dark mode'

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
M.lsrn = 'LSP Rename - Global rename symbol via LSP'
M.lsca = 'LSP Code Action - Code action via LSP'

-- Oil
M.fet = 'File Explorer Toggle'
M.fes = "File Explorer Save - Save Oil's CWD to given register"
M.fer = "File Explorer Restore - Set Oil's CWD to given register's path"

-- Hop
M.hw = 'HopWord | Type the character(s) on the screen to jump to that word'
M.hl = 'HopLine | Type the character(s) on the screen to jump to that line'

-- Git
M.gdif = 'Git Diff | :Gdiffsplit HEAD | Open diff between CWT and HEAD for current buffer'
M.gvdif = 'Git Vertical Diff | :Gvdiffsplit HEAD | Open vertical diff between CWT and HEAD for current buffer'
M.gcoms = 'Git Commits | :Telescope git_commits | Search commits for current branch with Telescope'
M.gbcoms = 'Git Buffer Commits | :Telescope git_bcommits | Search commits for current branch AND buffer with Telescope'
M.gdifall = 'Git Diff All | For each file matching regex, open a vertical diff in a new tab. Optionally accepts two target commits/branches.'

return M
