" Use :make or :Make to compile
compiler go

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
