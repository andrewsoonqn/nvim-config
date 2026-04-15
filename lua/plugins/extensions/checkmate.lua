local function completed_metadata_style()
  local checked = vim.api.nvim_get_hl(0, { name = 'CheckmateCheckedMainContent', link = false })
  return {
    fg = checked.fg,
    strikethrough = true,
  }
end

local function metadata_style(base_style)
  return function(context)
    if context.todo.is_complete() then
      return completed_metadata_style()
    end

    if type(base_style) == 'function' then
      return base_style(context)
    end

    return base_style or {}
  end
end

local function parse_duration(value)
  if not value then
    return math.huge
  end

  value = value:lower()
  if value == 'hh' then
    return 120
  end

  local amount, unit = value:match '^(%d+)([mh])$'
  amount = tonumber(amount)

  if not amount then
    return math.huge
  end

  if unit == 'h' then
    return amount * 60
  end

  return amount
end

local function parse_timestamp(value)
  if not value then
    return math.huge
  end

  local month, day, year, hour, min = value:match '^(%d%d)/(%d%d)/(%d%d) (%d%d):(%d%d)$'
  if not month then
    return math.huge
  end

  return os.time {
    year = 2000 + tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = tonumber(hour),
    min = tonumber(min),
  }
end

local function todo_sort_key(todo, mode)
  if mode == 'size' then
    local _, value = todo.get_metadata 'size'
    return parse_duration(value)
  end

  if mode == 'due' then
    local _, value = todo.get_metadata 'due'
    return value or 'zzzzzzzz'
  end

  if mode == 'started' then
    local _, value = todo.get_metadata 'started'
    return parse_timestamp(value)
  end

  if mode == 'state' then
    if todo.is_incomplete() then
      return 1
    end

    if todo.is_inactive() then
      return 2
    end

    return 3
  end

  return todo.row
end

local function open_sorted_todos()
  local checkmate = require 'checkmate'
  local todos = vim.tbl_filter(function(todo)
    return not todo.is_complete()
  end, checkmate.get_todos())

  if #todos == 0 then
    vim.notify('No active todos found', vim.log.levels.INFO)
    return
  end

  local modes = {
    { label = 'Position', value = 'position' },
    { label = 'Size', value = 'size' },
    { label = 'Due', value = 'due' },
    { label = 'Started', value = 'started' },
    { label = 'State', value = 'state' },
  }

  vim.ui.select(modes, {
    prompt = 'Sort todos by',
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if not choice then
      return
    end

    table.sort(todos, function(left, right)
      local left_key = todo_sort_key(left, choice.value)
      local right_key = todo_sort_key(right, choice.value)

      if left_key == right_key then
        return left.row < right.row
      end

      return left_key < right_key
    end)

    local items = vim.tbl_map(function(todo)
      return {
        todo = todo,
        label = todo.text,
      }
    end, todos)

    vim.ui.select(items, {
      prompt = 'Sorted todos',
      format_item = function(item)
        return item.label
      end,
    }, function(item)
      if not item then
        return
      end

      vim.api.nvim_win_set_cursor(0, { item.todo.row + 1, item.todo.indent })
      vim.cmd.normal { 'zv', bang = true }
    end)
  end)
end

return {
  'bngarren/checkmate.nvim',
  ft = 'markdown',
  config = function(_, opts)
    require('checkmate').setup(opts)

    local api = require 'checkmate.api'
    if api._done_metadata_hooked then
      return
    end

    api._done_metadata_hooked = true

    local original_toggle_state = api.toggle_state

    api.toggle_state = function(ctx, operations)
      local hunks = original_toggle_state(ctx, operations)
      local add_done_ops = {}
      local remove_done_ops = {}

      for _, op in ipairs(operations) do
        local item = ctx.get_todo_by_id(op.id)
        if item then
          if op.target_state == 'checked' and not item.metadata.by_tag.done then
            add_done_ops[#add_done_ops + 1] = { id = op.id, meta_name = 'done' }
          elseif op.target_state == 'unchecked' and item.metadata.by_tag.done then
            remove_done_ops[#remove_done_ops + 1] = { id = op.id, meta_names = { 'done' } }
          end
        end
      end

      if #add_done_ops > 0 then
        ctx.add_cb(function(tx_ctx)
          tx_ctx.add_op(api.add_metadata, add_done_ops)
        end)
      end

      if #remove_done_ops > 0 then
        ctx.add_cb(function(tx_ctx)
          tx_ctx.add_op(api.remove_metadata, remove_done_ops)
        end)
      end

      return hunks
    end
  end,
  opts = {
    ui = {
      picker = 'native',
    },
    style = {
      CheckmateUncheckedMarker = { bold = true },
      CheckmateCheckedMarker = { bold = true },
    },
    todo_states = {
      ---@diagnostic disable-next-line: missing-fields
      unchecked = { marker = '󰄱', order = 1 },
      ---@diagnostic disable-next-line: missing-fields
      -- checked = { marker = '✔︎', order = 2 },
      checked = { marker = '', order = 2 },
    },
    keys = {
      ['<leader>x'] = {
        rhs = function()
          require('checkmate').toggle()
        end,
        desc = 'Toggle todo + sync @done',
        modes = { 'n', 'v' },
      },
      ['<leader>tn'] = { rhs = '<cmd>Checkmate create<CR>', desc = '[N]ew todo', modes = { 'n', 'v' } },
      ['<leader>tr'] = { rhs = '<cmd>Checkmate remove<CR>', desc = '[R]emove todo marker', modes = { 'n', 'v' } },
      ['<leader>ta'] = { rhs = '<cmd>Checkmate archive<CR>', desc = '[A]rchive completed todos', modes = { 'n' } },
      ['<leader>ts'] = { rhs = '<cmd>Checkmate select_todo<CR>', desc = '[S]elect todo', modes = { 'n' } },
      ['<leader>to'] = { rhs = open_sorted_todos, desc = '[O]rder todos', modes = { 'n' } },
      ['<leader>tv'] = { rhs = '<cmd>Checkmate metadata select_value<CR>', desc = '[V]alue: update metadata', modes = { 'n' } },
      ['<leader>]'] = { rhs = '<cmd>Checkmate metadata jump_next<CR>', desc = 'Jump to next metadata', modes = { 'n' } },
      ['<leader>['] = { rhs = '<cmd>Checkmate metadata jump_previous<CR>', desc = 'Jump to previous metadata', modes = { 'n' } },
    },
    metadata = {
      due = {
        key = '<leader>Tu',
        style = metadata_style(),
      },
      started = {
        aliases = { 'init' },
        style = metadata_style { fg = '#7aa2f7' },
        get_value = function()
          return tostring(os.date '%m/%d/%y %H:%M')
        end,
        key = '<leader>Ts',
        sort_order = 20,
      },
      size = {
        key = '<leader>Th',
        style = metadata_style(function(context)
          local value = context.value:lower()
          if value == '2m' then
            return { fg = '#c28f2c', bold = true, underline = true }
          end

          return { fg = '#c28f2c' }
        end),
        get_value = function()
          return '1h'
        end,
        choices = function()
          return { '2m', '30m', '1h', 'hh' }
        end,
      },
      done = {
        aliases = { 'completed', 'finished' },
        style = metadata_style { fg = '#96de7a' },
        get_value = function()
          return tostring(os.date '%m/%d/%y %H:%M')
        end,
        key = '<leader>Td',
        on_add = function(todo)
          require('checkmate').set_todo_state(todo, 'checked')
        end,
        on_remove = function(todo)
          require('checkmate').set_todo_state(todo, 'unchecked')
        end,
        sort_order = 30,
      },
    },
  },
}
