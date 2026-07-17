-- AntaresOS · Neovim — Matrix (base16 + paleta Antares)
local antares = {
  base00 = "#000000",
  base01 = "#0b140b",
  base02 = "#14371f",
  base03 = "#2e6b3e",
  base04 = "#4f9e63",
  base05 = "#00ff41",
  base06 = "#7cffa0",
  base07 = "#c8ffd4",
  base08 = "#ff4d4d",
  base09 = "#ff9f45",
  base0A = "#f5d76e",
  base0B = "#35ff8a",
  base0C = "#48ffe0",
  base0D = "#35c9ff",
  base0E = "#ff6fd8",
  base0F = "#a6e22e",
}

return {
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("base16-colorscheme").setup(antares)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("base16-colorscheme").setup(antares)
      end,
    },
  },
}
