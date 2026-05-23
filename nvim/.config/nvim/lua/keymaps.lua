vim.g.mapleader = " "

-- Replace selected text without losing previous work yanked
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

-- Delete text without saving it into re
vim.keymap.set({ "n", "v" }, "d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "D", [["_D]], { desc = "Delete whole line without yanking" })

-- Change text without overwriting your clipboard
vim.keymap.set({ "n", "v" }, "c", [["_c]], { desc = "Change without yanking" })
vim.keymap.set({ "n", "v" }, "C", [["_C]], { desc = "Change to end of line without yanking" })

-- Delete a character without overwriting your paste register
vim.keymap.set({ "n", "v" }, "x", [["_x]], { desc = "Delete character without yanking" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("v", ">", ">gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>cs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Window Splitting
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
vim.keymap.set("n", "<leader>sq", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Tab
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })        -- open new tab
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })        --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })    --  go to previous tab

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart Neovim (:restart)" })

-- Forces Ctrl-g to always show the full, absolute file path
vim.keymap.set("n", "<C-g>", "1<C-g>", { desc = "Show full file path and status" })

-- Native undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

-- Fix Pasting from system clipboard
vim.keymap.set("n", "V", "0vg_", { noremap = true, desc = "Select entire line without newline" })

-- Save
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = "Save file" })

-- Quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = "Quit" })
