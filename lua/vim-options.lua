vim.cmd("set number!")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
vim.cmd("highlight StatusLineNC guibg=NONE ctermbg=NONE")
vim.opt.autoindent = true      -- copy indentation from previous line
vim.opt.smartindent = true     -- smarter indentation for code
vim.opt.wrap = true            -- enable line wrapping
vim.opt.breakindent = true     -- visually indent wrapped lines
vim.cmd("filetype plugin indent on")
vim.api.nvim_set_hl(0, "fsVariable", { fg="#D19A66" })
vim.api.nvim_set_hl(0, "fsFunction", { fg="#61AFEF" })
vim.api.nvim_set_hl(0, "fsParameter", { fg="#E06C75" })
