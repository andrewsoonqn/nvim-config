return {
  {
    'gh-tui-tools/gh-review.nvim',
    cmd = {
      'GHReview',
      'GHReviewClose',
      'GHReviewDiscard',
      'GHReviewFiles',
      'GHReviewStart',
      'GHReviewSubmit',
    },
    keys = {
      { '<leader>gr', '<cmd>GHReview<cr>', desc = 'Open GitHub [r]eview' },
    },
    opts = {},
  },
}
