-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- show path on top right of each buffer window
-- vim.opt.winbar = "%=%m %f"

-- show path relative to cwd on top right of each buffer window
vim.opt.winbar = "%=%m %{expand('%:~:.')}"

-- turn off relative number
vim.opt.relativenumber = false

-- enable line wrapping
-- vim.opt.wrap = true

vim.opt.wrap = true
vim.opt.breakindent = true
-- Optional: Adds 2 extra spaces for wrapped lines
vim.opt.breakindentopt = "shift:1"
-- Optional: Ensures wrapping doesn't happen in the middle of a word
vim.opt.linebreak = true

-- vim.opt.formatoptions:append({ "r", "o" })
