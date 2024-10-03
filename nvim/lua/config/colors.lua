vim.cmd('syntax on')
vim.cmd('colorscheme nightfly')
-- vim.cmd('colorscheme github_dark_default')

vim.g.moonflyCursorColor = 1
vim.g.moonflyUnderlineMatchParen = 1

-- Thin border on vertical splits
vim.cmd('hi VertSplit ctermbg=NONE guibg=NONE')

-- Highlight current line: https://vimtricks.com/p/highlight-specific-lines/
-- define line highlight color
vim.cmd('highlight LineHighlight ctermbg=darkgrey guibg=#222222')

-- vim.cmd('highlight MiniDiffSignAdd guifg=#26c978') -- Add sign color
vim.cmd('highlight MiniDiffSignChange guifg=#0096FF') -- Change sign color
-- vim.cmd('highlight MiniDiffSignDelete guifg=#de4949') -- Delete sign color
vim.cmd('highlight MiniDiffOverContext guibg=#33487d') -- Change overlay bg color
vim.cmd('highlight MiniDiffOverDelete guibg=#6b2d37') -- Delete overlay bg color

-- highlight the current line
-- vim.api.nvim_set_keymap('n', '<Leader>ll', ':call matchadd("LineHighlight", "\\%'..vim.fn.line(".").."l")<CR>', { noremap = true, silent = true })
-- clear all the highlighted lines
-- vim.api.nvim_set_keymap('n', '<Leader>lc', ':call clearmatches()<CR>', { noremap = true, silent = true })
