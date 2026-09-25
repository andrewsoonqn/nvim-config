return {
  'chrisgrieser/nvim-spider',
  keys = {
    {
      'w',
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { 'n', 'o', 'x' },
      desc = 'Next subword start',
    },
    {
      'e',
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { 'n', 'o', 'x' },
      desc = 'Next subword end',
    },
    {
      'b',
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { 'n', 'o', 'x' },
      desc = 'Previous subword start',
    },
    {
      'ge',
      "<cmd>lua require('spider').motion('ge')<CR>",
      mode = { 'n', 'o', 'x' },
      desc = 'Previous subword end',
    },
  },
  opts = {
    -- skipInsignificantPunctuation = true,
    -- subwordMovement = true,
    -- consistentOperatorPending = false,
    -- customPatterns = {},
  },
}
