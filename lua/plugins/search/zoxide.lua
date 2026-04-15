return {
  'jvgrootveld/telescope-zoxide',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local z_utils = require 'telescope._extensions.zoxide.utils'
    local action_state = require 'telescope.actions.state'

    require('telescope').setup {
      extensions = {
        zoxide = {
          mappings = {
            default = {
              -- Action for selecting an existing zoxide entry
              action = function(selection)
                require('oil').open(selection.path)
              end,
            },
            -- Add an extra mapping to handle manual input
            ['<C-cr>'] = { -- Or use '<C-e>' if you prefer
              action = function(selection)
                -- Get the raw text currently typed in the prompt
                local current_input = action_state.get_current_line()

                -- Expand ~ to home directory if present
                local path = vim.fn.expand(current_input)

                -- Open in Oil
                require('oil').open(path)
              end,
            },
          },
        },
      },
    }

    require('telescope').load_extension 'zoxide'

    vim.keymap.set('n', '<leader>cd', function()
      require('telescope').extensions.zoxide.list()
    end, { desc = 'Zoxide (Oil)' })
  end,
}
