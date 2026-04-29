return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
      -- Do NOT define format_on_save here.
      -- LazyVim handles this automatically.
    },
  },
}
