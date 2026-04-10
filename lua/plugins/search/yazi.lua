return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    -- Customize these to your liking
    {
      '<leader>-',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      -- Open in the current working directory
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "Open yazi in nvim's working directory",
    },
  },
}
