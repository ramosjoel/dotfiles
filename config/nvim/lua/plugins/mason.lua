return {
    {
       'williamboman/mason.nvim',
       config = function()
           require('mason').setup()
       end,
   },
   {
       'williamboman/mason-lspconfig.nvim',
       dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
       config = function()
           require('mason-lspconfig').setup {
               ensure_installed = {
                    'lua_ls',
                    'ts_ls',
                    'bash-language-server',
                    'beautysh',
                    'black',
                    'buf-language-server',
                    'buildifier',
                    'bzl',
                    'chrome-debug-adapter',
                    'cssls',
                    'cucumber_language_server',
                    'docker_compose_language_service',
                    'dockerls',
                    'eslint',
                    'go-debug-adapter',
                    'goimports',
                    'golangci-lint',
                    'golangci_lint_ls',
                    'gotests',
                    'graphql',
                    'html',
                    'htmx',
                    'jinja_lsp',
                    'js-debug-adapter',
                    'jsonls',
                    'jsonld-lsp',
                    'jsonlint',
                    'kotlin-language-server kotlin_language_server',
                    'luau_lsp',
                    'markdownlint',
                    'mdformat',
                    'prettier',
                    'prosemd_lsp',
                    'protolint',
                    'pylsp',
                    'reformat-gherkin',
                    'sql-formatter',
                    'sqlfmt',
                    'tailwindcss',
                    'tree-sitter-cli',
                    'yamlls',
                    'yamlfix',
                    'yamlfmt',
                    'yamllint',
                }, -- Example servers
               -- automatic_enable = true, -- Default is true, no need to explicitly set unless changing
           }
       end,
   },
   {
       'neovim/nvim-lspconfig',
       -- nvim-lspconfig is still needed as it provides the server-specific configurations
       -- but its 'setup' function is no longer called directly.
       dependencies = {
         -- Automatically install LSPs to stdpath for neovim
         'williamboman/mason.nvim',
         'williamboman/mason-lspconfig.nvim',
         -- Useful status updates for LSP
         -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
         { 'j-hui/fidget.nvim', opts = {} },
         -- Additional lua configuration, makes nvim stuff amazing!
         'folke/neodev.nvim',
       }
   },
}
