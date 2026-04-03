-- plugins/kanagawa.lua
return {
  'rebelot/kanagawa.nvim',
  lazy = false, -- Load on startup
  priority = 1000, -- Load before other plugins
  config = function()
    require('kanagawa').setup {
      compile = false, -- Manually compile if you want speed
      undercurl = true, -- For wavy underlines
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- THIS IS KEY: Removes the bg color
      dimInactive = false, -- Sylvan keeps his windows bright
      terminalColors = true, -- Use Kanagawa colors in :terminal
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none', -- Removes background from the line number column
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Make floating windows transparent too (LSP, Telescope)
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },

          -- Borderless Telescope look
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = 'none' },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = 'none' },
        }
      end,
      theme = 'dragon', -- Options: "wave", "dragon", "lotus"
    }

    -- Finally, load the colorscheme
    vim.cmd 'colorscheme kanagawa'
  end,
}
