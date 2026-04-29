return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- Show hidden/dotfiles
        ignored = true, -- Show git-ignored files
        enabled = true,
        sources = {
          explorer = { -- HERE!
            enabled = true,
            hidden = true,
            auto_close = false,
            win = {
              list = {
                keys = {

                  -- 'l' opens the window picker to choose where to open the file
                  ["L"] = { { "pick_win", "jump" }, mode = { "n", "i" } },

                  -- 'L' opens the file normally (usually in the last active window)
                  ["l"] = { "confirm", mode = { "n", "i" } },
                },
              },
            },
            layout = {
              layout = {
                position = "left",
              },
            },
          },
        },
      },
    },
  },
}
