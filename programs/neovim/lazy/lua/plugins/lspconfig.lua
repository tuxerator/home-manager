function getHostname()
  local f = io.popen("hostname")
  local hostname = f:read("*a") or ""
  f:close()
  hostname = string.gsub(hostname, "\n$", "")
  return hostname
end
function getUsername()
  local f = io.popen("whoami")
  local username = f:read("*a") or ""
  f:close()
  username = string.gsub(username, "\n$", "")
  return username
end

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
        nixd = {
          mason = false,
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> { }",
              },
              formatting = {
                command = { "nixfmt" },
              },
              options = {
                nixos = {
                  expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.'
                    .. getHostname()
                    .. ".options",
                },
                home_manager = {
                  expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."'
                    .. getUsername()
                    .. "@"
                    .. getHostname()
                    .. '".options',
                },
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
        clangd = {
          mason = false,
          clangd = {
            keys = {
              { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            },
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern(
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja"
              )(fname) or require("lspconfig.util").root_pattern(
                "compile_commands.json",
                "compile_flags.txt"
              )(fname) or require("lspconfig.util").find_git_ancestor(fname)
            end,
            capabilities = {
              offsetEncoding = { "utf-16" },
            },
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },
}
