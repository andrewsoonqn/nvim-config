local closers = {
  [')'] = true,
  [']'] = true,
  ['}'] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
  ['>'] = true,
}

local openers = {
  ['('] = true,
  ['['] = true,
  ['{'] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
  ['<'] = true,
}

local function is_tabout_char(char)
  return closers[char] or openers[char]
end

vim.keymap.set('i', '<Tab>', function()
  local ok, luasnip = pcall(require, 'luasnip')
  if ok and luasnip.jumpable(1) then
    luasnip.jump(1)
    return ''
  end

  local col = vim.fn.col '.'
  local line = vim.fn.getline '.'
  local next_char = line:sub(col, col)

  if is_tabout_char(next_char) then
    return '<Right>'
  end

  return '<Tab>'
end, { expr = true, silent = true, desc = 'Simple tabout' })

vim.keymap.set('i', '<S-Tab>', function()
  local ok, luasnip = pcall(require, 'luasnip')
  if ok and luasnip.jumpable(-1) then
    luasnip.jump(-1)
    return ''
  end

  local col = vim.fn.col '.'
  if col <= 1 then
    return '<S-Tab>'
  end

  local line = vim.fn.getline '.'
  local prev_char = line:sub(col - 1, col - 1)

  if is_tabout_char(prev_char) then
    return '<Left>'
  end

  return '<S-Tab>'
end, { expr = true, silent = true, desc = 'Simple reverse tabout' })

-- return {
--   {
--     'abecodes/tabout.nvim',
--     lazy = false,
--     config = function()
--       require('tabout').setup {
--         tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
--         backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
--         act_as_tab = true, -- shift content if tab out is not possible
--         act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
--         default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
--         default_shift_tab = '<C-d>', -- reverse shift default action,
--         enable_backwards = true, -- well ...
--         completion = false, -- if the tabkey is used in a completion pum
--         tabouts = {
--           { open = "'", close = "'" },
--           { open = '"', close = '"' },
--           { open = '`', close = '`' },
--           { open = '(', close = ')' },
--           { open = '[', close = ']' },
--           { open = '{', close = '}' },
--         },
--         ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
--         exclude = {}, -- tabout will ignore these filetypes
--       }
--     end,
--     dependencies = { -- These are optional
--       'nvim-treesitter/nvim-treesitter',
--       'L3MON4D3/LuaSnip',
--       'hrsh7th/nvim-cmp',
--     },
--     opt = true, -- Set this to true if the plugin is optional
--     event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
--     priority = 1000,
--   },
--   {
--     'L3MON4D3/LuaSnip',
--     keys = function()
--       -- Disable default tab keybinding in LuaSnip
--       return {}
--     end,
--   },
-- }
