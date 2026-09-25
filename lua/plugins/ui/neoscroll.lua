return {
  'karb94/neoscroll.nvim',
  opts = {
    mappings = {},
    duration_multiplier = 0.5,
  },
  config = function(_, opts)
    local neoscroll = require 'neoscroll'
    neoscroll.setup(opts)

    local mappings = {
      ['<C-u>'] = {
        callback = function()
          neoscroll.ctrl_u { duration = 250 }
        end,
        desc = 'Smooth half-page scroll up',
      },
      ['<C-d>'] = {
        callback = function()
          neoscroll.ctrl_d { duration = 250 }
        end,
        desc = 'Smooth half-page scroll down',
      },
      ['<C-b>'] = {
        callback = function()
          neoscroll.ctrl_b { duration = 450 }
        end,
        desc = 'Smooth full-page scroll up',
      },
      ['<C-f>'] = {
        callback = function()
          neoscroll.ctrl_f { duration = 450 }
        end,
        desc = 'Smooth full-page scroll down',
      },
      zt = {
        callback = function()
          neoscroll.zt { half_win_duration = 250 }
        end,
        desc = 'Smooth cursor line to top',
      },
      zz = {
        callback = function()
          neoscroll.zz { half_win_duration = 250 }
        end,
        desc = 'Smooth cursor line to center',
      },
      zb = {
        callback = function()
          neoscroll.zb { half_win_duration = 250 }
        end,
        desc = 'Smooth cursor line to bottom',
      },
    }

    for lhs, mapping in pairs(mappings) do
      vim.keymap.set({ 'n', 'v', 'x' }, lhs, mapping.callback, { desc = mapping.desc })
    end
  end,
}
