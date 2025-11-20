local api = vim.api
if type(api.nvim_get_current_buf()) == "function" then
  local old = api.nvim_get_current_buf()
  local ok, val = pcall(old)
  if ok and type(val) == "number" then
    api.nvim_get_current_buf = val
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {}
require("vim-options")
require("lazy").setup("plugins")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
vim.opt.termguicolors = true
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

