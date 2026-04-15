return {
  'jvgrootveld/telescope-zoxide',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local z_utils = require 'telescope._extensions.zoxide.utils'

    require('telescope').setup {
      extensions = {
        zoxide = {
          mappings = {
            default = {
              -- This is the "Teleport" logic
              action = function(selection)
                require('oil').open(selection.path)
              end,
            },
          },
        },
      },
    }
    -- Load the extension
    require('telescope').load_extension 'zoxide'

    -- Bind the zoxide list to a key
    vim.keymap.set('n', '<leader>cd', function()
      require('telescope').extensions.zoxide.list()
    end, { desc = 'cd in Oil' })
  end,
}
