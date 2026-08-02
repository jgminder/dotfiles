return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    -- Set before the plugin loads so it skips its own default <C-hjkl>
    -- mappings; our config/keymaps.lua defines the ones we actually want.
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
