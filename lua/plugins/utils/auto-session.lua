return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      auto_save = true,
      auto_restore = false,
    }

    vim.keymap.set('n', '<leader>rq', '<cmd>AutoSession restore<CR>', { desc = '[R]estore [Q]uit Session' })
    vim.keymap.set('n', '<leader>sq', '<cmd>AutoSession save<CR><cmd>qa<CR>', { desc = '[S]ave Session then [Q]uitting' })
  end,
}
