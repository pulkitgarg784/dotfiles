require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>ch", function()
  local extension = vim.fn.expand "%:e"
  local alternate_extension

  if extension == "C" then
    alternate_extension = "h"
  elseif extension == "h" then
    alternate_extension = "C"
  else
    vim.notify("Current file is not a .C or .h file", vim.log.levels.WARN)
    return
  end

  local alternate = vim.fn.expand "%:r" .. "." .. alternate_extension
  if vim.fn.filereadable(alternate) == 0 then
    vim.notify("Alternate file not found: " .. alternate, vim.log.levels.WARN)
    return
  end

  vim.cmd.edit(vim.fn.fnameescape(alternate))
end, { desc = "Switch between .C and .h" })

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
