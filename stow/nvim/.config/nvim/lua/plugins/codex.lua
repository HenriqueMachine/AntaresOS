-- AntaresOS · Neovim — Codex (snippets da library)
return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      local lib = os.getenv("ANTARES_LIB") or vim.fn.expand("~/Github/AntaresOS/library")
      local codex = lib .. "/codex/.build"
      if vim.fn.isdirectory(codex) == 1 then
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { codex } })
      end
      return opts
    end,
  },
}
