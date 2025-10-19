return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      options = {
        transparency = true,
      },
      styles = {
        comments = "italic",
        keywords = "italic",
        functions = "bold",
        variables = "NONE",
      },
      highlights = {
        Normal = { bg = "NONE" },
        NormalFloat = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
      },
    })
    vim.cmd("colorscheme onelight")
  end,
}
