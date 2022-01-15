" Use :make or :Make to compile
compiler go

" lua << EOF
" require("lspconfig").gopls.setup({
"     on_attach = function(client)
"         client.resolved_capabilities.document_formatting = false
"         client.resolved_capabilities.document_range_formatting = false
"     end,
" })
" EOF

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
