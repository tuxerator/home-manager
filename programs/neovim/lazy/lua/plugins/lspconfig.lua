return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
    },
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        gopls = {},
        nil_ls = {
          mason = false,
          settings = {
            ["nil"] = {
              formatting = {
                command = { "nixpkgs-fmt" },
              },
            },
          },
        },
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
