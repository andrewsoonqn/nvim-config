-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

require 'plugins.ui.startify-setup'

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufFilePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('ExercismQuiet', { clear = true }),
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)
    local exercism = vim.startswith(path, vim.fn.expand('~/dev/exercism/'))

    vim.b.completion = not exercism
    vim.diagnostic.enable(not exercism)
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
