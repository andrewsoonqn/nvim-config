local parsers = {
  'bash',
  'c',
  'diff',
  'html',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require 'nvim-treesitter'

      treesitter.setup {}
      treesitter.install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        pattern = '*',
        callback = function(args)
          local language = vim.treesitter.language.get_lang(args.match)
          if not language then
            return
          end

          local started = pcall(vim.treesitter.start, args.buf, language)
          if started and args.match ~= 'ruby' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
