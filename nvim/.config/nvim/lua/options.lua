vim.g.netrw_banner = 0

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.scrolloff = 999

vim.o.winborder = "single"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
-- vim.opt.breakindent = true -> Only use it if set `wrap`

-- Sync system clipboard with Neovim registers
vim.opt.clipboard = "unnamedplus"

vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Remove swap file and recover from undofile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- Enable file start with @ especially for ts/js file
vim.opt.isfname:append("@-@")

vim.opt.guicursor = ""
vim.opt.cursorline = false -- highlight cursor line

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true
vim.o.cmdheight = 1

-- Spell Check
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en_us" }
    end,
})

-- Highlighted the selected text yanked
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
