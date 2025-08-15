local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- Disable netrw (just in case this file loads before init.vim lines)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  view = { width = 35, side = "left" },
  renderer = {
    group_empty = true,
    icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
  },
  update_focused_file = { enable = true, update_root = false },
  actions = { open_file = { resize_window = true } },
  filesystem_watchers = { enable = true },
})

-- Toggle file tree and focus on current file
vim.keymap.set(
  "n",
  "<leader>e",
  ":NvimTreeFindFileToggle<CR>",
  { silent = true, desc = "Toggle file tree (reveal current file)" }
)
