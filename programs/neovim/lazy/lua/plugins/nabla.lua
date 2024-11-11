return {
  "https://github.com/jbyuki/nabla.nvim.git",
  config = function()
    vim.keymap.set("n", "<leader>p", require("nabla").popup)
  end,
}
