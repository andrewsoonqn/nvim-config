return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_browser = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

    -- Theme & Appearance
    vim.g.mkdp_theme = 'dark' -- Sets overall UI to light

    -- Keymaps
    vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = '[M]arkdown [P]review' })
    vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = '[M]arkdown Preview [S]top' })
  end,
  ft = { 'markdown' },
}
