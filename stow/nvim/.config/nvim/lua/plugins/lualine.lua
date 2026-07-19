-- AntaresOS · Neovim — lualine no tema Matrix (combina com Ghostty/Zellij)
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local c = {
        green = "#00ff41",
        black = "#000000",
        cyan = "#48ffe0",
        magenta = "#ff6fd8",
        red = "#ff4d4d",
        yellow = "#f5d76e",
        text = "#7cffa0",
        dim = "#2e6b3e",
        surface = "#0b140b",
      }
      local matrix = {
        normal = {
          a = { fg = c.black, bg = c.green, gui = "bold" },
          b = { fg = c.green, bg = c.surface },
          c = { fg = c.text, bg = "NONE" },
        },
        insert = { a = { fg = c.black, bg = c.cyan, gui = "bold" } },
        visual = { a = { fg = c.black, bg = c.magenta, gui = "bold" } },
        replace = { a = { fg = c.black, bg = c.red, gui = "bold" } },
        command = { a = { fg = c.black, bg = c.yellow, gui = "bold" } },
        inactive = {
          a = { fg = c.dim, bg = c.surface },
          b = { fg = c.dim, bg = c.surface },
          c = { fg = c.dim, bg = "NONE" },
        },
      }
      opts.options = opts.options or {}
      opts.options.theme = matrix
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }
    end,
  },
}
