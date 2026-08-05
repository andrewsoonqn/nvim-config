-- why: single source of truth - the plugin workspace and the capture keymap
--       both hang off this, so a vault move is a one-line change.
local vault_path = vim.fn.expand '~/vault'
-- why: unfiled captures belong in the Inbox, not the JD-structured vault root.
local inbox_path = vault_path .. '/00-09 System/00 System management/00.01 Inbox'

local function obsidian_new_with_prompt()
  local date = os.date '%d%m%y'

  vim.ui.input({ prompt = 'What topic/message? ' }, function(input)
    if input == nil then
      return
    end

    local display_title = (input ~= '' and input or 'Untitled')
    local filename = (input ~= '' and (input .. ' ') or '') .. date .. '.md'
    local full_path = inbox_path .. '/' .. filename

    -- 1. Open the file directly (bypass ObsidianNew logic)
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))

    -- 2. Insert your content into the clean buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
      '#to-tag',
      '# ' .. display_title,
      '',
      '',
      '',
    })

    -- 3. Position cursor
    vim.api.nvim_win_set_cursor(0, { 4, 0 })

    -- 4. Save the file immediately so Obsidian recognizes it
    vim.cmd 'write'
  end)
end
vim.keymap.set('n', '<leader>on', obsidian_new_with_prompt, { desc = '[O]bsidian [N]ote' })

return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = false, -- Set to false so the keymap works immediately
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    vim.opt.conceallevel = 2
    vim.opt.concealcursor = ''

    local conceal_group = vim.api.nvim_create_augroup('ObsidianConceal', { clear = true })

    -- When entering Insert mode in a markdown file, reveal EVERYTHING
    vim.api.nvim_create_autocmd('InsertEnter', {
      group = conceal_group,
      pattern = '*.md',
      callback = function()
        vim.opt_local.conceallevel = 0
      end,
    })

    -- When leaving Insert mode (back to Normal), hide everything again
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = conceal_group,
      pattern = '*.md',
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
  opts = {
    note_id_func = function(title)
      return title
    end,

    frontmatter = {
      enabled = false,
    },
    legacy_commands = false,

    workspaces = {
      {
        name = "Andrew's Vault",
        path = vault_path,
      },
    },
    -- why: mirrors ~/vault/.obsidian/templates.json - resolved against the
    --       vault root, so templates load regardless of nvim's cwd.
    templates = {
      folder = '00-09 System/01 Meta/01.01 Templates',
    },
    -- why: mirrors ~/vault/.obsidian/daily-notes.json.
    daily_notes = {
      folder = '10-19 Dailies/11 Journal/11.01 Daily notes',
      date_format = '%d-%m-%Y',
      template = '_Dailies Template',
    },
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },

    -- If enabling, uncomment the config field above too
    ui = {
      enable = true,
    },
  },
}
