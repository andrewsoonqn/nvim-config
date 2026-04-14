return {
  'gennaro-tedesco/nvim-jqx',
  event = { 'BufReadPost' },
  ft = { 'json', 'yaml' },
  config = function()
    vim.keymap.set('n', '<leader>jl', '<cmd>JqxList<CR>', { desc = '[J]SON [L]ist' })
    vim.keymap.set('n', '<leader>jq', '<cmd>JqxQuery<CR>', { desc = '[J]SON [Q]uery' })

    -- Auto-preview on opening json files
    local jqx = vim.api.nvim_create_augroup('Jqx', {})
    vim.api.nvim_clear_autocmds { group = jqx }
    vim.api.nvim_create_autocmd('BufWinEnter', {
      pattern = { '*.json', '*.yaml' },
      desc = 'preview json and yaml files on open',
      group = jqx,
      callback = function()
        vim.cmd.JqxList()
      end,
    })
  end,
}
