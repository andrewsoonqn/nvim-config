return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local presets = require 'markview.presets'

    require('markview').setup {
      preview = {
        enable = true,
        icon_provider = 'devicons',
      },
      markdown = {
        headings = presets.headings.glow,
        tables = presets.tables.rounded,
        block_quotes = presets.block_quotes.obsidian,
      },
    }
  end,
}
