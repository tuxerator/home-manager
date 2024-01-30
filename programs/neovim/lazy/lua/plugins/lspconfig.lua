return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
    },
    opts = {
      servers = {
        gopls = {},
        nil_ls = {},
        ltex = {
          settings = {
            ltex = {
              language = "en-GB",
              completionEnabled = true,
              checkFrequency = "save",
            },
          },
        },
      },
    },
  },
}
