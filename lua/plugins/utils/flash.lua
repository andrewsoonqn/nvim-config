return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        -- search = {
        --   -- Forces literal and case-sensitive matching for f, F, t, T
        --   mode = function(str)
        --     return '\\V\\C' .. vim.fn.escape(str, '\\')
        --   end,
        -- },
        jump_labels = true,
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Labelled jump',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Treesitter-aware labelled jump',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote labelled jump',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash search integration',
    },
  },
  config = function(_, opts)
    require('flash').setup(opts)

    vim.api.nvim_set_hl(0, 'FlashLabel', {
      fg = '#ffff00',
      bold = true,
    })
  end,
}
