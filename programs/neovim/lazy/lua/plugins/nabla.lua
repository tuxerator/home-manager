return {
  "https://github.com/jbyuki/nabla.nvim.git",
  config = function()
    require("nabla").enable_virt()
    vim.keymap.set("n", "<lder>p", require("nabla").popup())
  end,
}
