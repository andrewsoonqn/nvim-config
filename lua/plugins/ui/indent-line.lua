return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
      char = ' ', -- A blank space hides the inactive indent lines
      tab_char = ' ',
    },
    scope = {
      enabled = true,
      char = '│', -- Explicitly set the line character for the active scope
      show_start = false,
      show_end = false,
    },
  },
}
