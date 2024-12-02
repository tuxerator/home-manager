return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  enabled = false,
  event = "LspAttach",
  opts = {},
  init = function()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = { only_current_line = true },
    })
  end,
}
