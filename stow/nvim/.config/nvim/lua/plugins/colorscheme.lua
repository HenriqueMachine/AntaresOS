-- ═══════════════════════════════════════════════════════════════
--  LabOS · Neovim — tema Catppuccin Mocha (unifica com o resto)
-- ═══════════════════════════════════════════════════════════════
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = true,
        which_key = true,
        mason = true,
        native_lsp = { enabled = true },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
