vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
        diagnostics = {
                globals = {"vim", "Snacks", "snacks"}
            }
    },
  },
})

vim.lsp.enable({"pyright", "ts_ls", "lua_ls"})
