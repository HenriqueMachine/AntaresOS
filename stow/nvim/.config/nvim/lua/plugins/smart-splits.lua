-- AntaresOS · Neovim — smart-splits (navegação sem emenda com o Zellij)
return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = { multiplexer_integration = "zellij" },
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Ir para split à esquerda" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Ir para split abaixo" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Ir para split acima" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Ir para split à direita" },
    },
  },
}
