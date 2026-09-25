return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'helix',
      spec = {
        { '<leader>c', group = 'Directories' },
        { '<leader>d', group = 'Debug' },
        { '<leader>f', group = 'File and format' },
        { '<leader>h', group = 'Git hunks' },
        { '<leader>hd', group = 'Diffs' },
        { '<leader>ht', group = 'Persistent Git display' },
        { '<leader>j', group = 'Jumps and Harpoon' },
        { '<leader>l', group = 'External tools' },
        { '<leader>m', group = 'Markdown' },
        { '<leader>p', group = 'Project and session' },
        { '<leader>r', group = 'Run' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Toggles' },
      },
    },
  },
}
