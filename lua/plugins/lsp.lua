return {
  "neovim/nvim-lspconfig",
  opts = {
    -- disable inline hits like the types of variables on ts.
    inlay_hints = { enabled = false },
    servers = {
      vtsls = {
        settings = {
          typescript = {
            hover = {
              expandAlias = true, -- Shows the actual type instead of just the name
            },
          },
        },
      },
    },
  },
}
