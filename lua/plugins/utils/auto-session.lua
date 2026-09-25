return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      auto_save = true,
      auto_restore = false,
    }

    vim.keymap.set('n', '<leader>pr', '<cmd>AutoSession restore<CR>', { desc = '[r]estore project session' })
    vim.keymap.set('n', '<leader>pq', '<cmd>AutoSession save<CR><cmd>qa<CR>', { desc = 'Save project session and [q]uit Neovim' })
  end,
}
