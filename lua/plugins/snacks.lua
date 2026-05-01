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
                  ["O"] = { { "pick_win", "jump" }, mode = { "n", "i" } },

                  -- 'L' opens the file normally (usually in the last active window)
                  ["l"] = { "confirm", mode = { "n", "i" } },
                  ["o"] = { "confirm", mode = { "n", "i" } },

                  -- Map 'y' to copy the file/dir to the internal clipboard
                  -- ["y"] = "explorer_copy",
                  -- -- Map 'p' to paste the file/dir from the internal clipboard
                  -- ["p"] = "explorer_paste",
                  -- -- Optional: 'x' for cut (move)
                  -- ["x"] = "explorer_cut",
                  ["E"] = "paste_windows_file",
                },
              },
            },

            layout = {
              layout = {
                position = "left",
              },
            },

            actions = {
              paste_windows_file = function(picker)
                -- Get clipboard content and clean it (remove quotes and newlines)
                local clipboard = vim.fn.getreg("+"):gsub('^"', ""):gsub('"$', ""):gsub("[\r\n]", "")

                -- Verify it's actually a valid file
                if vim.fn.filereadable(clipboard) == 0 then
                  vim.notify("Clipboard does not contain a valid file path:\n" .. clipboard, vim.log.levels.WARN)
                  return
                end

                -- CORRECTED LINE: Get the currently focused item directly from the picker
                local item = picker:current()
                if not item then
                  return
                end

                -- Determine target directory (if focused item is a file, use its parent folder)
                local target_dir
                if vim.fn.isdirectory(item.file) == 1 then
                  target_dir = item.file
                else
                  target_dir = vim.fn.fnamemodify(item.file, ":h")
                end

                -- Construct destination path
                local filename = vim.fn.fnamemodify(clipboard, ":t")
                local dest = target_dir .. "/" .. filename

                -- Copy the file using Neovim's native libuv API
                local success, err = vim.uv.fs_copyfile(clipboard, dest)
                if success then
                  vim.notify("Pasted: " .. filename, vim.log.levels.INFO)
                  -- Refresh the explorer to show the new file
                  picker:find()
                else
                  vim.notify("Failed to paste file: " .. (err or "Unknown error"), vim.log.levels.ERROR)
                end
              end,
              explorer_paste = function(picker, item) --[[Override]]
                local Tree = require("snacks.explorer.tree")
                local files = vim.split(vim.fn.getreg(vim.v.register or "+") or "", "\n", { plain = true })
                files = vim.tbl_filter(function(file)
                  -- NOTE: Use `vim.uv.fs_stat` instead of `vim.fn.filereadable`
                  return file ~= "" and vim.uv.fs_stat(file) ~= nil
                end, files)
                if #files == 0 then
                  return Snacks.notify.warn(
                    ("The `%s` register does not contain any files"):format(vim.v.register or "+")
                  )
                end
                local dir = picker:dir()
                -- NOTE: Prefer parent when directory is closed
                if item.dir and not item.open then
                  dir = vim.fs.dirname(dir)
                end
                -- NOTE: Replace `Snacks.picker.util.copy`
                for _, file in ipairs(files) do
                  -- BUG: Prevent pasting inside itself
                  if file == dir then
                    Snacks.notify.warn(string.format("Skip recursive copy: %s", file))
                  else
                    local dst = vim.fs.joinpath(dir, vim.fn.fnamemodify(file, ":t"))
                    local dst_unique = dst
                    local count = 0
                    while vim.uv.fs_stat(dst_unique) do
                      count = count + 1
                      dst_unique = string.format("%s (copy %d)", dst, count)
                    end
                    Snacks.picker.util.copy_path(file, dst_unique)
                  end
                end
                Tree:refresh(dir)
                Tree:open(dir)
                picker:update({ target = dir })
              end,
            },
          },
          projects = {
            -- Sort strictly by chronological order (last opened), ignoring frecency score
            sort = { fields = { "idx" } },
          },
        },
      },
    },
  },
}
