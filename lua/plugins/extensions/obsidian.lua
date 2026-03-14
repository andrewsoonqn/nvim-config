return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  ft = 'markdown',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'personal',
        path = "~/Andrew's Vault/",
      },
    },

    daily_notes = {
      -- The folder where your daily notes are stored (relative to vault root)
      folder = 'Dailies',
      -- The date format used for the filename (must match Obsidian App settings)
      date_format = '%d-%m-%Y',
      -- The alias for the daily note (optional)
      template = '00 STORAGE/Templates/_Empty Template',
    },

    disable_frontmatter = true,
  },
}
