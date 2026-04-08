return {
  'oskarnurm/koda.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('koda').setup { transparent = true }
    vim.cmd 'colorscheme koda-moss'

    local bg_dark = '#000000'
    local fg_high = '#FFFFFF'

    local zen_groups = {
      'ZenlineNormal',
      'ZenlineInsert',
      'ZenlineVisual',
      'ZenlineReplace',
    }

    for _, group in ipairs(zen_groups) do
      vim.api.nvim_set_hl(0, group, {
        bg = bg_dark,
        fg = fg_high,
        bold = true,
      })
    end

    vim.api.nvim_set_hl(0, 'Visual', { bg = '#4a4a4a', fg = 'NONE' })
  end,
}
