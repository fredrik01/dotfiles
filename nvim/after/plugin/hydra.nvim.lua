local Hydra = require('hydra')
local pcmd = require('hydra.keymap-util').pcmd
local splits = require('smart-splits')

Hydra({
   name = 'Windows',
   config = {
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
   },
   mode = 'n',
   body = '<c-e>',
   heads = {
      { 'k', function() splits.resize_up(2)  end, { desc = 'up' } },
      { 'j', function() splits.resize_down(2)  end, { desc = 'down' } },
      { 'l', function() splits.resize_right(2)  end, { desc = 'right' } },
      { 'h', function() splits.resize_left(2)  end, { desc = 'left' } },
			{ 'v', pcmd('vsplit', 'E36'), { desc = 'vsplit' } },
			{ 's', pcmd('split', 'E36'), { desc = 'split' } },
			{ 'o', '<c-w>o', { desc = 'only' } },
			{ 'c', pcmd('close', 'E444'), { desc = 'close' } },
      { 'q', nil, { exit = true, desc = false }}
   },
})
