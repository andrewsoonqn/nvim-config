return {
  'michaelb/sniprun',
  branch = 'master',

  build = 'sh install.sh',
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  config = function()
    require('sniprun').setup {
      display = {
        -- 'Classic', --# display results in the command-line  area
        'VirtualTextOk', --# display ok results as virtual text (multiline is shortened)

        -- "VirtualText",             --# display results as virtual text
        -- "VirtualLine",             --# display results as virtual lines
        -- "TempFloatingWindow",      --# display results in a floating window
        -- 'LongTempFloatingWindow', --# same as above, but only long results. To use with VirtualText[Ok/Err]
        'Terminal', --# display results in a vertical split
        -- "TerminalWithCode",        --# display results and code history in a vertical split
        -- "NvimNotify",              --# display with the nvim-notify plugin
        -- "Api"                      --# return output to a programming interface
      },
      -- your options
    }

    -- Normal Mode: Runs the current line
    vim.keymap.set('n', '<leader>rr', function()
      require('sniprun').run()
    end, { desc = 'Snip[R]un [R]un' })

    -- Visual Mode: Runs the highlighted selection
    vim.keymap.set('v', '<leader>r', function()
      require('sniprun').run 'v'
    end, { desc = 'Snip[R]un selection' })

    vim.keymap.set('n', '<leader>rR', function()
      require('sniprun').reset()
    end, { desc = 'Snip[R]un [R]eset' })

    vim.keymap.set('n', '<leader>rc', function()
      require('sniprun.display').close_all()
    end, { desc = '[C]lose/Clear SnipRun Displays' })
  end,
}
