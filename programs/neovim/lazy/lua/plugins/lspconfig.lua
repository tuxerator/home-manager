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
        hls = {},
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
