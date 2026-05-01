return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  config = true, -- use default config
  keys = {
    { "gP", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview Definition in Float" },
    { "gq", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close all Preview Windows" },
  }
}
