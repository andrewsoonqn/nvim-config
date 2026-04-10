local function obsidian_new_with_prompt()
  local date = os.date '%d%m%y'
  -- Get your vault path from the config (or hardcode it if easier)
  local vault_path = "/Users/andrewsoon/Andrew's Vault"

  vim.ui.input({ prompt = 'What topic/message? ' }, function(input)
    if input == nil then
      return
    end

    local display_title = (input ~= '' and input or 'Untitled')
    local filename = (input ~= '' and (input .. ' ') or '') .. date .. '.md'
    local full_path = vault_path .. '/' .. filename

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
    vim.opt_local.conceallevel = 2
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
        path = "/Users/andrewsoon/Andrew's Vault",
      },
    },
    daily_notes = {
      folder = 'Dailies',
      date_format = '%d-%m-%Y',
      template = '00 STORAGE/Templates/_Dailies Template',
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}
