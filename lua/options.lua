-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.winborder = 'rounded'

vim.o.number = true
vim.o.ruler = true

vim.o.relativenumber = true

vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
-- NOTE: use "+yy instead!
--
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

vim.o.scrolloff = 10

-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.o.backup = true
vim.o.backupdir = vim.fn.expand '~/.backup/'
-- vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.wrap = true
vim.o.linebreak = true

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy '+',
    ['*'] = require('vim.ui.clipboard.osc52').copy '*',
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste '+',
    ['*'] = require('vim.ui.clipboard.osc52').paste '*',
  },
}

-- vim.opt.guicursor = 'i:block'

-- Create an autocommand group (this prevents duplicates if you reload your config)
local diagnostic_toggle = vim.api.nvim_create_augroup('DiagnosticToggle', { clear = true })

-- Hide diagnostics when entering Insert Mode
vim.api.nvim_create_autocmd('InsertEnter', {
  group = diagnostic_toggle,
  pattern = '*',
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- Show diagnostics when leaving Insert Mode
vim.api.nvim_create_autocmd('InsertLeave', {
  group = diagnostic_toggle,
  pattern = '*',
  callback = function()
    vim.diagnostic.enable(true)
  end,
})

vim.opt.conceallevel = 2
vim.opt.concealcursor = ''

local conceal_group = vim.api.nvim_create_augroup('Conceal', { clear = true })

-- When entering Insert mode, reveal EVERYTHING
vim.api.nvim_create_autocmd('InsertEnter', {
  group = conceal_group,
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- When leaving Insert mode (back to Normal), hide everything again
vim.api.nvim_create_autocmd('InsertLeave', {
  group = conceal_group,
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- vim: ts=2 sts=2 sw=2 et
