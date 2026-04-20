-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- Blink already shows LSP signature help; disable Noice's auto-popup to avoid duplicate floats.
      signature = {
        enabled = false,
      },
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = 'mini', -- default view for messages
      view_error = 'mini', -- view for errors
      view_warn = 'mini', -- view for warnings
      -- view_history = 'split', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    views = {
      mini = {
        align = 'message-left',
        position = {
          col = 0,
        },
      },
    },
    routes = {
      {
        view = 'mini',
        filter = {
          event = 'msg_show',
        },
      },
      {
        view = 'mini',
        filter = { event = 'msg_showmode' },
      },
    },
  },
}
