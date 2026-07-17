-- AntaresOS · Neovim — sniprun (rodar blocos de código inline)
return {
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    cmd = { "SnipRun", "SnipReset", "SnipClose" },
    keys = {
      { "<leader>r", "<cmd>SnipRun<cr>", mode = { "n", "v" }, desc = "Sniprun: rodar" },
      { "<leader>rc", "<cmd>SnipReset<cr>", desc = "Sniprun: reset" },
      { "<leader>rq", "<cmd>SnipClose<cr>", desc = "Sniprun: fechar saída" },
    },
    opts = {
      display = { "Classic", "VirtualTextOk" },
      selected_interpreters = { "Python3_fifo" },
    },
  },
}
