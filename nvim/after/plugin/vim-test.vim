let test#strategy = 'harpoon_stay'
" Easily change between test strategies
nmap <leader>ts1 :let test#strategy = 'asyncrun_background_term'<CR>
nmap <leader>ts2 :let test#strategy = 'asyncrun'<CR>
nmap <leader>ts3 :let test#strategy = 'neovim'<CR>
nmap <leader>ts4 :let test#strategy = 'harpoon'<CR>
nmap <leader>ts5 :let test#strategy = 'harpoon_stay'<CR>

function! HarpoonStay(cmd)
  let g:cmd = a:cmd . "\n"
  if(exists("g:test#harpoon_term"))
    lua require("harpoon.term").sendCommand(vim.g["test#harpoon_term"] ,vim.g.cmd)
  else
    lua require("harpoon.term").sendCommand(1 ,vim.g.cmd)
  endif
endfunction

let g:test#custom_strategies = {'harpoon_stay': function('HarpoonStay')}

let test#neovim#term_position = "vert botright 100"
