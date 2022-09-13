local dap, dapui = require("dap"), require("dapui")
dapui.setup {} -- use default
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.after.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv( "HOME" ) .. '/.local/share/nvim/debuggers/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000,
    pathMappings = {
        ["/app"] = "${workspaceFolder}"
    }
  }
}

        -- ["/app"] = "${workspaceFolder}"
        -- ["/var/www"] = "${workspaceFolder}"


-- local dap_install = require("dap-install")
-- dap_install.config(
-- 	"php",
--     {
--         adapters = {
--           type = 'executable',
--           command = 'node',
--           args = {'/Users/fredrik/.local/share/nvim/dapinstall/php/vscode-php-debug/out/phpDebug.js'}
--         },
--         configurations = {
--             {
--                 type = 'php',
--                 request = 'launch',
--                 name = 'Listen for Xdebug',
--                 port = 9000,
--                 pathMappings = {
--                     ["/app"] = "${workspaceFolder}"
--                 }
--             }
--         }
--     }
-- )

-- nnoremap <silent> <Leader>dd :lua require'dap'.continue()<cr>
-- nnoremap <silent> <Leader>db :lua require'dap'.toggle_breakpoint()<cr>
-- nnoremap <silent> <Leader>dc :lua require'dap'.clear_breakpoints()<CR>
-- nnoremap <silent> <Leader>dq :lua require'dap'.terminate()<CR> :lua require'dapui'.close()<CR>
-- nnoremap <silent> <Leader>dj :lua require'dap'.step_over()<CR>
-- nnoremap <silent> <Leader>dl :lua require'dap'.step_into()<CR>
-- nnoremap <silent> <Leader>dk :lua require'dap'.step_out()<CR>
