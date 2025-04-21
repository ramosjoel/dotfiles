-- Neotest
return {
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-python',
    'rcasia/neotest-bash',
    'thenbe/neotest-playwright',
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/neotest-jest',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-python',
            'rcasia/neotest-bash',
            'thenbe/neotest-playwright',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    -- https://github.com/rcasia/neotest-bash
                    require('neotest-bash'),
                    -- https://github.com/thenbe/neotest-playwright?tab=readme-ov-file#installation
                    require('neotest-playwright').adapter({
                        options = {
                            persist_project_selection = true,
                            enable_dynamic_test_discovery = true,
                            get_playwright_binary = function()
                                return vim.loop.cwd() .. '/node_modules/.bin/playwright'
                            end,

                            get_playwright_config = function()
                                return vim.loop.cwd() .. '/playwright.config.ts'
                            end,
                            experimental = {
                                telescope = {
                                    -- If true, a telescope picker will be used for `:NeotestPlaywrightProject`.
                                    -- Otherwise, `vim.ui.select` is used.
                                    -- In normal mode, `<Tab>` toggles the project under the cursor.
                                    -- `<CR>` (enter key) applies the selection.
                                    enabled = true,
                                    opts = {},
                                },
                            },
                        },
                    }),
                },
            })
        end,
    },
}
