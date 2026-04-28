return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true, -- Show hidden/dotfiles
            ignored = true, -- Show git-ignored files
          },
        },
      },
    },
  },
}
