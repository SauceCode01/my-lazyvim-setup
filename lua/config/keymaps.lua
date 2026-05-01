-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>i", "<leader>bd", { remap = true, desc = "Close Buffer" })

vim.keymap.set("n", "<leader>no", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end, { desc = "Focus notify window" })

vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy File Path" })

vim.keymap.set("n", "<leader>hk", "<cmd>WhichKey<cr>", { desc = "Show WhichKey" })

-- vim.keymap.set("n", "<leader>ba", "<leader>bo<leader>bd", { remap = true, silent = true })

vim.keymap.set("n", "<leader>ba", function()
  -- Call the Lua functions directly
  require("snacks").bufdelete.other()
  require("snacks").bufdelete()
end, { desc = "Delete ALL buffers (Close Other + Close Current)" })

vim.keymap.set("n", "<leader>I", function()
  -- Call the Lua functions directly
  require("snacks").bufdelete.other()
  require("snacks").bufdelete()
end, { desc = "Delete ALL buffers (Close Other + Close Current)" })

-- allows to select a specific window when opening a definition
vim.keymap.set("n", "gW", function()
  -- 1. Get current cursor position for the LSP request
  -- Neovim 0.10+ requires window ID (0) and offset_encoding
  local params = vim.lsp.util.make_position_params(0, "utf-16")

  -- 2. Ask the LSP server for the definition location in the background
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, _)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify("No definition found", vim.log.levels.WARN)
      return
    end

    -- 3. Trigger the Snacks window picker overlay (A, B, C...)
    local target_win = Snacks.picker.util.pick_win()
    if not target_win then
      return
    end -- User cancelled

    -- 4. Switch to the selected window
    vim.api.nvim_set_current_win(target_win)

    -- 5. Jump to the definition
    local location = vim.islist(result) and result[1] or result
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local offset_encoding = client and client.offset_encoding or "utf-16"

    -- Updated for Neovim 0.10+: Use show_document with focus
    vim.lsp.util.show_document(location, offset_encoding, { focus = true })
  end)
end, { desc = "Goto Definition in Picked Window" })

-- Jump to the absolute leftmost window
vim.keymap.set("n", "<leader>H", "<cmd>99wincmd h<CR>", { desc = "Focus leftmost window" })
