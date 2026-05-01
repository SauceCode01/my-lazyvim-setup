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

-- Force enable LSP diagnostic underlines
vim.diagnostic.config({
  underline = true,
  virtual_text = true, -- Keeps the inline text on the right
  signs = true,
  update_in_insert = false,
})

-- Force standard straight underlines for errors/warnings instead of undercurls
-- since lazyvim tokyonight hides the underlines
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "Red" })
--     vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "Yellow" })
--     vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "Blue" })
--     vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "Cyan" })
--   end,
-- })

vim.opt.clipboard = "unnamedplus"
