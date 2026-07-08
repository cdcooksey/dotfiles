-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run test file" })
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Run test suite" })
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Go to last test file" })
vim.keymap.set("n", "<leader>$j", ":SplitjoinJoin<CR>", { desc = "Join line" })
vim.keymap.set("n", "<leader>$s", ":SplitjoinSplit<CR>", { desc = "Split line" })
vim.keymap.set("n", "<leader>$a", ":Switch<CR>", { desc = "Switch word" })
vim.keymap.set("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Yank file path" })

-- Override LazyVim's default lazygit keymaps: lazygit only *displays* the
-- worktree/repo you switch to inside its own TUI. Actually moving anywhere
-- requires the shell-wrapper handshake lazygit expects: it writes the target
-- path to $LAZYGIT_NEW_DIR_FILE on exit, and it's the caller's job to `cd`
-- there. snacks.nvim's lazygit integration never wires this up, so Neovim's
-- cwd/buffers never move — see https://github.com/jesseduffield/lazygit/discussions/2803
-- Snacks reuses/toggles the same terminal buffer across invocations and its
-- own TermClose handling runs first, so hooking TermClose ourselves proved
-- unreliable. Poll for the drop file directly instead — it only appears
-- once lazygit has actually exited and written it, so this is equivalent
-- to the shell wrapper's `if [ -f $LAZYGIT_NEW_DIR_FILE ]` check, just
-- decoupled from Snacks' internal event wiring.
local lazygit_watch_timer = nil

local function watch_for_new_dir(new_dir_file)
  if lazygit_watch_timer then
    lazygit_watch_timer:stop()
    lazygit_watch_timer:close()
  end
  local ticks = 0
  lazygit_watch_timer = vim.loop.new_timer()
  lazygit_watch_timer:start(300, 300, function()
    ticks = ticks + 1
    local found = vim.loop.fs_stat(new_dir_file) ~= nil
    if not found and ticks < 3600 then -- give up after ~18 minutes
      return
    end
    lazygit_watch_timer:stop()
    lazygit_watch_timer:close()
    lazygit_watch_timer = nil
    if not found then
      return
    end
    vim.schedule(function()
      local f = io.open(new_dir_file, "r")
      if not f then
        return
      end
      local dir = vim.trim(f:read("*a"))
      f:close()
      os.remove(new_dir_file)
      if dir ~= "" and vim.loop.fs_stat(dir) then
        vim.cmd.cd(dir)
        vim.notify("cwd -> " .. dir, vim.log.levels.INFO, { title = "lazygit" })
      end
    end)
  end)
end

local function lazygit_cd(opts)
  opts = opts or {}
  local new_dir_file = vim.fn.stdpath("cache") .. "/lazygit-newdir"
  os.remove(new_dir_file) -- clear any stale write from a previous session
  opts.env = vim.tbl_extend("force", opts.env or {}, { LAZYGIT_NEW_DIR_FILE = new_dir_file })

  Snacks.lazygit(opts)
  watch_for_new_dir(new_dir_file)
end

vim.keymap.set("n", "<leader>gg", function()
  lazygit_cd({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

vim.keymap.set("n", "<leader>gG", function()
  lazygit_cd()
end, { desc = "Lazygit (cwd)" })
