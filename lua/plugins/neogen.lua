return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    enabled = true,
    languages = {
      typescript = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
      typescriptreact = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
    },
  },
  keys = {
    {
      "<leader>nf",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations",
    },
  },
}
