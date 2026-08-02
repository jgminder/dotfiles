-- Loaded after LazyVim's own keymaps.lua (both fire on VeryLazy, LazyVim's
-- runs first), so this overrides its default <C-hjkl> window-nav maps to
-- route through vim-tmux-navigator instead of plain <C-w>h/j/k/l.
local map = vim.keymap.set

map("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "Go to Left Window" })
map("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "Go to Right Window" })
