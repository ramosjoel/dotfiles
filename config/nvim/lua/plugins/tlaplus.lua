-- https://github.com/susliko/tla.nvim
return {
  "susliko/tla.nvim",
  config = function ()
    require("tla") .setup()
  end,
  keys = {
    { "<leader>tc", function () require('tla').check() end, desc = "Run TLA+ Model Checker" },
  },
}
