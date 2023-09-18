require("mason-null-ls").setup({
    ensure_installed = { "shellcheck", "hadolint", "vint", "yamllint" }
})

local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.formatting.phpcbf.with({
        prefer_local = "vendor/bin",
    }),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,

    null_ls.builtins.diagnostics.phpcs.with({
        prefer_local = "vendor/bin",
    }),
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.yamllint,
}

null_ls.setup({ sources = sources })
