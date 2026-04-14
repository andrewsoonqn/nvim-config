return {
  'hat0uma/csvview.nvim',
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    view = {
      display_mode = 'highlight',
    },
    parser = { comments = { '#', '//' } },
    keymaps = {
      textobject_field_inner = { 'if', mode = { 'o', 'x' } },
      textobject_field_outer = { 'af', mode = { 'o', 'x' } },
      jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
      jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
      jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
      jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
    },
  },
  cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  ft = { 'csv', 'tsv' }, -- Lazy-load on filetype
  config = function(_, opts)
    require('csvview').setup(opts)

    -- Auto-enable CsvView when opening CSV/TSV files
    local csv_group = vim.api.nvim_create_augroup('CsvViewAuto', { clear = true })
    vim.api.nvim_create_autocmd('BufReadPost', {
      pattern = { '*.csv', '*.tsv' },
      group = csv_group,
      callback = function()
        vim.cmd 'CsvViewEnable'
      end,
    })
  end,
}
