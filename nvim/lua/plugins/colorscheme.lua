return {
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    lazy = false,
    priority = 1000,

    config = function(_, opts)
      require("flexoki").setup(opts)
      vim.cmd.colorscheme("flexoki")
    end,
  },
}
