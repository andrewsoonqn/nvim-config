local nvim_header = {
  '▄▄  ▄▄ ▄▄ ▄▄ ▄▄ ▄▄   ▄▄',
  '███▄██ ██▄██ ██ ██▀▄▀██',
  '██ ▀██  ▀█▀  ██ ██   ██',
  '',
}

vim.g.startify_custom_header = vim.fn['startify#pad'](nvim_header)

-- Optional: define your lists here too
vim.g.startify_lists = {
  { type = 'dir', header = { '   Recent: ' .. vim.fn.getcwd() } },
  { type = 'files', header = { '   Recent' } },
  { type = 'bookmarks', header = { '   Bookmarks' } },
}

vim.g.startify_files_number = 5
