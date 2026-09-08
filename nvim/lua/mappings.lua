require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Neovide: ctrl+scroll to zoom (adjust font size)
if vim.g.neovide then
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0

  local function change_scale_factor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  map({ "n", "i", "v" }, "<C-ScrollWheelUp>", function()
    change_scale_factor(1.1)
  end, { desc = "Neovide zoom in" })

  map({ "n", "i", "v" }, "<C-ScrollWheelDown>", function()
    change_scale_factor(1 / 1.1)
  end, { desc = "Neovide zoom out" })
end
