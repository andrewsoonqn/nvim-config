return {
  'delphinus/md-render.nvim',
  version = '*',
  ft = { 'markdown', 'markdown_inline' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>mp', '<cmd>botright vertical MdRender split<cr>', desc = 'Preview Markdown in right split' },
  },
  config = function()
    local markdown = require 'md-render.markdown'

    markdown.heading_icon = function(level)
      return string.rep('#', level)
    end
    markdown.heading_icon_prefix = function(level)
      return string.rep('#', level) .. ' '
    end

    require('md-render.text_size').setup { enabled = false }
  end,
}
