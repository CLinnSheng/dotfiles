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

opt.wrap = false

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
opt.cursorline = false -- highlight cursor line

-- Floating window border
vim.opt.winborder = "rounded"

vim.g.editorconfig = true

-- Spell Check
opt.spell = true
opt.spelllang = { "en_us" }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.lsp.set_log_level("error")

-- 🔧 Force all floating preview windows to have rounded borders
local orig_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_floating_preview(contents, syntax, opts, ...)
end

-- Finding Files
-- pt.path:append("**")
-- opt.wildmenu = true

vim.g.dbs = {
	{ name = "PerryTech_Dev", url = "mysql://linnsheng:2KZFwWawGYZO4Rnb@3.114.154.135:3306/" },
}
