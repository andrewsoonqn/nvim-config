return {
  {
    'theprimeagen/harpoon',
    config = function()
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      local function open_file(index)
        return function()
          ui.nav_file(index)
        end
      end

      vim.keymap.set('n', '<leader>a', mark.add_file, { desc = '[a]dd current file to Harpoon' })
      vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Toggle Harpoon menu' })
      vim.keymap.set('n', '<C-h>', open_file(1), { desc = 'Open Harpoon file 1' })
      vim.keymap.set('n', '<C-j>', open_file(2), { desc = 'Open Harpoon file 2' })
      vim.keymap.set('n', '<C-k>', open_file(3), { desc = 'Open Harpoon file 3' })
      vim.keymap.set('n', '<C-l>', open_file(4), { desc = 'Open Harpoon file 4' })

      vim.keymap.set('n', '<leader>ja', mark.add_file, { desc = '[a]dd current file (fast: <leader>a)' })
      vim.keymap.set('n', '<leader>jm', ui.toggle_quick_menu, { desc = 'Toggle Harpoon [m]enu (fast: <C-e>)' })
      vim.keymap.set('n', '<leader>j1', open_file(1), { desc = 'Open Harpoon file [1] (fast: <C-h>)' })
      vim.keymap.set('n', '<leader>j2', open_file(2), { desc = 'Open Harpoon file [2] (fast: <C-j>)' })
      vim.keymap.set('n', '<leader>j3', open_file(3), { desc = 'Open Harpoon file [3] (fast: <C-k>)' })
      vim.keymap.set('n', '<leader>j4', open_file(4), { desc = 'Open Harpoon file [4] (fast: <C-l>)' })
    end,
  },
}
