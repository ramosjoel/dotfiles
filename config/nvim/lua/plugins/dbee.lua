return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    keys = {
        -- { '<leader>do', function() require('dbee').open() end,       desc = '[D]bee [O]pen' },
        -- { '<leader>dc', function() require('dbee').close() end,       desc = '[D]bee [C]lose' },
        { '<leader>dbt', function() require('dbee').toggle() end, desc = '[D]bee Toggle Open/Close' },
        {
            '<leader>sj',
            function(filename)
                require('dbee').store('json', 'file',
                    { extra_arg = '/Users/joel/dev/ramosjoel/ramosdb/' + filename })
            end,
            desc = '[D]bee [S]tore [J]SON'
        },
    },
    build = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        require("dbee").install()
    end,
    config = function()
        require("dbee").setup({
            sources = {
                require("dbee.sources").MemorySource:new({
                    {
                        id = "ramosdb",
                        name = "RamosDB",
                        type = "sqlite",
                        url = "/Users/joel/dev/ramosjoel/ramosdb/ramos.db"
                    }
                })
            }
        })
    end,
}
