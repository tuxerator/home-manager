return {
  "https://github.com/jbyuki/nabla.nvim.git",
  config = function()
    require("nabla").enable_virt()
    vim.keymap.set(
      "n",
      "<leader>p",
      require("nabla").popup() < CR > " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`"
    )
  end,
}
