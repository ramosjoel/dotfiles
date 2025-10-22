vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', '.git' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (e.g., LuaJIT for Neovim)
        version = 'LuaJIT',
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        library = { vim.env.VIMRUNTIME }
      },
      telemetry = {
        enable = false,
      },
      diagnostics = {
        globals = { 'vim' }, -- Add global variables like 'vim' to avoid diagnostics
      },
    },
  },
  on_init = function(client)
    -- Optional: Add custom logic when the client initializes
  end,
  -- Further options like capabilities, on_attach, etc.
})
