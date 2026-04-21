-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<C-a>', 'gg"+yG')

vim.keymap.set('n', '<leader>fw', function()
  vim.cmd.write()
  -- vim.cmd.Ex()
  vim.cmd.Oil()
end, { desc = '[F]ile View after [W]rite' })

-- vim.keymap.set('c', 'W', 'w', { noremap = true, silent = true })
-- vim.keymap.set('c', 'Q', 'q', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = '[W]rite file' })

vim.keymap.set('n', '<leader>pc', ':Precognition toggle<CR>', { desc = 'Toggle [P]re[c]ognition' })

vim.keymap.set('n', '-', vim.cmd.Oil, { desc = 'Toggle file view' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- opt + backspace to delete a word
vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true })
vim.keymap.set('c', '<M-BS>', '<C-w>', { noremap = true })

-- tabout
local closers = {
  [')'] = true,
  [']'] = true,
  ['}'] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
  ['>'] = true,
}

local openers = {
  ['('] = true,
  ['['] = true,
  ['{'] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
  ['<'] = true,
}

local function is_tabout_char(char)
  return closers[char] or openers[char]
end

vim.keymap.set('i', '<Tab>', function()
  local col = vim.fn.col '.'
  local line = vim.fn.getline '.'
  local next_char = line:sub(col, col)

  if is_tabout_char(next_char) then
    return '<Right>'
  end

  return '<Tab>'
end, { expr = true, silent = true, desc = 'Simple tabout' })

vim.keymap.set('i', '<S-Tab>', function()
  local col = vim.fn.col '.'
  if col <= 1 then
    return '<S-Tab>'
  end

  local line = vim.fn.getline '.'
  local prev_char = line:sub(col - 1, col - 1)

  if is_tabout_char(prev_char) then
    return '<Left>'
  end

  return '<S-Tab>'
end, { expr = true, silent = true, desc = 'Simple reverse tabout' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    -- vim.opt.number = true
    -- vim.opt.relativenumber = true
  end,
})

vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end)

vim.keymap.set('n', '<leader>ls', function()
  vim.cmd 'vsplit'
  local uri = 'oil-ssh://andrewsq@xlogin1.comp.nus.edu.sg//home/a/andrewsq/'
  vim.cmd('edit ' .. uri)
end, { desc = '[L]og into [S]SH' })

vim.keymap.set('n', '<leader>sx', function()
  vim.cmd 'write'
  vim.cmd 'source %'
  print 'File saved and sourced!'
end, { desc = '[S]ave and E[x]ecute' })

-- local zz_check = false
-- vim.keymap.set('n', 'ZZ', function()
--   if zz_check then
--     -- Second press within 2 seconds: Execute the real ZZ
--     zz_check = false -- Reset state
--     vim.cmd 'wq'
--   else
--     -- First press: Set the gate and start the timer
--     zz_check = true
--     print 'Careful! Use <leader>fw to save. Press ZZ again within 2s to force quit.'
--
--     vim.defer_fn(function()
--       zz_check = false
--     end, 2000) -- 2000ms = 2 seconds
--   end
-- end)
--
-- local zq_check = false
-- vim.keymap.set('n', 'ZQ', function()
--   if zq_check then
--     zq_check = false
--     vim.cmd 'q!'
--   else
--     zq_check = true
--     print 'Warning: ZQ will discard changes. Press ZQ again in 2s to confirm.'
--     vim.defer_fn(function()
--       zq_check = false
--     end, 2000)
--   end
-- end)

-- -- Map 'q' to write and quit
-- vim.keymap.set('n', '<leader>zz', '<cmd>wq<CR>', { desc = 'ZZ' })
--
-- -- Map 'Q' to quit without saving (force)
-- vim.keymap.set('n', '<leader>zq', '<cmd>q!<CR>', { desc = 'ZQ' })

-- Normal mode: Yank current line to system clipboard
vim.keymap.set('n', '<C-y>', '"+yy', { desc = 'Yank line to system clipboard' })

-- Visual mode: Yank selection to system clipboard
vim.keymap.set('v', '<C-y>', '"+y', { desc = 'Yank selection to system clipboard' })

-- vim: ts=2 sts=2 sw=2 et
