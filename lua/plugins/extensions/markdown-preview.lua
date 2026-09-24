return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview_auto_refresh = 1
    vim.g.mkdp_auto_close = 0

    vim.g.mkdp_browserfunc = ''
    vim.g.mkdp_browser = ''

    -- Theme & Appearance
    vim.g.mkdp_theme = 'dark' -- Sets overall UI to light

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(args)
        vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { buffer = args.buf, desc = '[M]arkdown [P]review' })
        vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { buffer = args.buf, desc = '[M]arkdown Preview [S]top' })
      end,
    })
  end,
  ft = { 'markdown' },
}
