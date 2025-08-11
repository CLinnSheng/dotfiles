local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.numberwidth = 2
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true

opt.wrap = true

-- Copy to clipboard
opt.clipboard = "unnamedplus"

-- Color Schemes
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = { "start", "eol", "indent" }

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.showmode = false

-- Split Windows
opt.splitright = true
opt.splitbelow = true

opt.updatetime = 50
opt.hlsearch = true
opt.cursorline = false -- higligh cursor line

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.editorconfig = true
