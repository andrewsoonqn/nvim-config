return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }

    _G.OpenMarkdownPreview = function(url)
      local browser = vim.fn.exepath 'terminal-browser'
      if browser == '' then
        vim.notify('terminal-browser is not installed', vim.log.levels.ERROR)
        return
      end

      local script = [[
on run argv
  set previewUrl to item 1 of argv
  set browserBin to item 2 of argv
  set workingDirectory to item 3 of argv
  set commandText to quoted form of browserBin & " " & quoted form of previewUrl

  tell application "Ghostty"
    set targetTerminal to focused terminal of selected tab of front window
    split targetTerminal direction right with configuration {initial working directory:workingDirectory, initial input:commandText & linefeed}
  end tell
end run
]]

      vim.system({ 'osascript', '-', url, browser, vim.fn.getcwd() }, { stdin = script }, function(result)
        if result.code ~= 0 then
          vim.schedule(function()
            vim.notify('Failed to open Markdown preview in Ghostty: ' .. (result.stderr or 'unknown error'), vim.log.levels.ERROR)
          end)
        end
      end)
    end
    vim.cmd [[
      function! OpenMarkdownPreview(url) abort
        call v:lua.OpenMarkdownPreview(a:url)
      endfunction
    ]]
    vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

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
