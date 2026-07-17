-- AntaresOS · Neovim — autocmds

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("antares_highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})
