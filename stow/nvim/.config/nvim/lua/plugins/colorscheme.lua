-- Deepdeck · Neovim — base16 with the Deepdeck soft palette (17/11)
local antares = {
  base00 = "#0e0e14", -- background (Deepdeck soft, 17/11)
  base01 = "#16161f", -- lighter background (status line, line numbers)
  base02 = "#2a2a3a", -- selection
  base03 = "#878ca6", -- comments (5.8:1 on the background, WCAG AA)
  base04 = "#9a9fb5", -- dark foreground
  base05 = "#d8dae5", -- text
  base06 = "#e6e8f0",
  base07 = "#eef0f6",
  base08 = "#e8457a", -- variables, tags (magenta of the Deepdeck)
  base09 = "#e89a5c", -- numbers, constants
  base0A = "#e6c84c", -- classes, search
  base0B = "#5fd7a0", -- strings
  base0C = "#4cc9d6", -- support, regex (cyan of the Deepdeck)
  base0D = "#6b8cff", -- functions
  base0E = "#b36bd6", -- keywords
  base0F = "#c97a6b",
}

return {
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("base16-colorscheme").setup(antares)
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1d1d2a" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e6c84c", bold = true })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("base16-colorscheme").setup(antares)
        -- The current line stands out a little; its number is yellow (Deepdeck soft, 17/11).
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1d1d2a" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e6c84c", bold = true })
      end,
    },
  },
}
