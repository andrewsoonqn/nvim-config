return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    win_options = {
      winbar = "%#StatusLine# %{toupper(mode())} %{v:lua.require('oil').get_current_dir()} %m",
    },

    default_file_explorer = true,

    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,

    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ['g?'] = { 'actions.show_help', mode = 'n', desc = 'Show Oil help' },
      ['<CR>'] = { 'actions.select', desc = 'Open entry' },
      ['<C-s>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open entry in vertical split' },
      ['<C-h>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open entry in horizontal split' },
      ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open entry in new tab' },
      ['<C-p>'] = { 'actions.preview', desc = 'Preview entry' },
      ['<C-c>'] = { 'actions.close', mode = 'n', desc = 'Close Oil' },
      ['<C-l>'] = { 'actions.refresh', desc = 'Refresh Oil' },
      ['-'] = { 'actions.parent', mode = 'n', desc = 'Open parent directory' },
      ['_'] = { 'actions.open_cwd', mode = 'n', desc = 'Open working directory' },
      ['`'] = { 'actions.cd', mode = 'n', desc = 'Change Neovim working directory' },
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n', desc = 'Change tab working directory' },
      ['gs'] = { 'actions.change_sort', mode = 'n', desc = 'Change [s]ort order' },
      ['gx'] = { 'actions.open_external', desc = 'Open entry e[x]ternally' },
      ['g.'] = { 'actions.toggle_hidden', mode = 'n', desc = 'Toggle hidden files' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n', desc = 'Toggle trash view' },
    },

    columns = {
      'icon',
      -- 'permissions',
      'size',
      'mtime',
    },

    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,

    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, bufnr)
        local m = name:match '^%.'
        return m ~= nil
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, bufnr)
        return false
      end,
      -- Sort file names with numbers in a more intuitive order for humans.
      -- Can be "fast", true, or false. "fast" will turn it off for large directories.
      natural_order = 'fast',
      -- Sort file and directory names case insensitive
      case_insensitive = false,
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { 'type', 'asc' },
        { 'name', 'asc' },
      },
      -- Customize the highlight group for the file name
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
        return nil
      end,
    },
  },
  -- Optional dependencies
  -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
