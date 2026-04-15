return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      auto_save = true,
      auto_restore = false,
    }

    vim.keymap.set('n', '<leader>rq', '<cmd>AutoSession restore<CR>', { desc = '[R]estore [Q]uit Session' })
  end,
}
