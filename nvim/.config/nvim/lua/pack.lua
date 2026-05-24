-- Build hook for markdown-preview.nvim
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "markdown-preview.nvim" and (kind == "install" or kind == "update") then
            local app_dir = ev.data.path .. "/app"
            vim.notify("Building markdown-preview.nvim...", vim.log.levels.INFO)
            vim.system({ "npm", "install" }, { cwd = app_dir }, function(obj)
                if obj.code == 0 then
                    vim.notify("Successfully built markdown-preview.nvim!", vim.log.levels.INFO)
                else
                    vim.notify("Failed to build markdown-preview.nvim: " .. (obj.stderr or ""), vim.log.levels.ERROR)
                end
            end)
        end
    end,
})

vim.pack.add({
    "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/echasnovski/mini.nvim",
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-completion",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
    "https://www.github.com/ibhagwan/fzf-lua",
    "https://www.github.com/lewis6991/gitsigns.nvim",
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/rafamadriz/friendly-snippets",
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = "v1.9.1",
    },
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/iamcco/markdown-preview.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/saecki/crates.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/j-hui/fidget.nvim"
})

-- Icons
require("nvim-web-devicons").setup({})

-- Oil (File Explorer)
require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Mini Setup
require("mini.surround").setup({})
require("mini.trailspace").setup({})
-- Force automatic trailing whitespace removal on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Automatically trim trailing whitespace on save",
    callback = function()
        MiniTrailspace.trim()
    end,
})

-- Database Config
vim.g.dbs = {
}


vim.keymap.set("n", "<leader>db", "<CMD>DBUIToggle<CR>", { desc = "Toggle Dadbod UI Sidebar" })

-- Fzf finder
require("fzf-lua").setup({
    dependencies = { "nvim-tree/nvim-web-devicons" },
    winopts = {
        split = "belowright 15new",
    },
})
require("fzf-lua").register_ui_select()

vim.keymap.set("n", "<leader>ff", function()
    require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fw", function()
    require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
-- vim.keymap.set("n", "<leader>fb", function()
--     require("fzf-lua").buffers()
-- end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
    require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
    require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
    require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })
vim.keymap.set("n", "<leader>fk", function()
    require("fzf-lua").keymaps()
end, { desc = "FZF Keymaps" })

-- Git Signs
require("gitsigns").setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    current_line_blame = false,
})
vim.keymap.set("n", "<leader>gb", function()
    require("gitsigns").blame_line()
end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>gd", function()
    require("gitsigns").diffthis()
end, { desc = "Diff this" })

-- Treesitter
local setup_treesitter = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup({})
    local ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "yaml",
        "html",
        "css",
        "python",
        "http",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "cpp",
        "java",
        "rust",
        "typst",
    }

    local config = require("nvim-treesitter.config")

    local already_installed = config.get_installed()
    local parsers_to_install = {}

    for _, parser in ipairs(ensure_installed) do
        if not vim.tbl_contains(already_installed, parser) then
            table.insert(parsers_to_install, parser)
        end
    end

    if #parsers_to_install > 0 then
        treesitter.install(parsers_to_install)
    end

    local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
            if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
                vim.treesitter.start(args.buf)
            end
        end,
    })
end

setup_treesitter()

-- Autotag
require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
    },
    per_filetype = {
        ["html"] = { enable_close = true },
        ["typescriptreact"] = { enable_close = true },
    },
})

local trigger_text = ";"

-- Blink Autocomplete Setup
require("blink.cmp").setup({
    keymap = {
        preset = "none",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-Space>"] = { "show" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        -- kind_icons = true,
    },

    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
            sql = { "snippets", "dadbod", "buffer" },
            mysql = { "snippets", "dadbod", "buffer" },
            plsql = { "snippets", "dadbod", "buffer" },
        },

        providers = {
            lsp = {
                name = "lsp",
                enabled = true,
                module = "blink.cmp.sources.lsp",
                min_keyword_length = 0,
                score_offset = 90,
            },

            path = {
                name = "Path",
                module = "blink.cmp.sources.path",
                score_offset = 25,
                fallbacks = { "snippets", "buffer" },
                opts = {
                    trailing_slash = false,
                    label_trailing_slash = true,
                    get_cwd = function(context)
                        return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                    end,
                    show_hidden_files_by_default = true,
                },
            },

            buffer = {
                name = "Buffer",
                enabled = true,
                max_items = 3,
                module = "blink.cmp.sources.buffer",
                min_keyword_length = 2,
                score_offset = 15, -- the higher the number, the higher the priority
            },

            dadbod = {
                name = "vim-dadbod-completion",
                module = "vim_dadbod_completion.blink",
                score_offset = 100,
            },

        },
    },

    completion = {
        list = {
            selection = {
                preselect = false,
                auto_insert = false,
            },
        },

        ghost_text = {
            enabled = true,
        },

        menu = {
            border = "rounded",
        },
        documentation = {
            auto_show = true,
            window = {
                border = "rounded",
            },
        },
    },

    cmdline = {
        keymap = {
            preset = "cmdline",
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
        },
        completion = {
            menu = {
                auto_show = true,
            },
        },
    },
})

-- Autopair
require("nvim-autopairs").setup({})

-- Render Markdown Setup
require("render-markdown").setup({
    render_modes = { "n", "c", "t" },
})

-- Crates Setup
require("crates").setup({
    lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
    },
})

-- Lualine Setup
local lualine = require("lualine")

local colors = {
    darkgray = "#16161d",
    gray = "#727169",
    innerbg = nil,
    outerbg = "#16161D",
    normal = "#7e9cd8",
    insert = "#98bb6c",
    visual = "#ffa066",
    replace = "#e46876",
    command = "#e6c384",
}

local my_lualine_theme = {
    inactive = {
        a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
    },
    visual = {
        a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
    },
    replace = {
        a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
    },
    normal = {
        a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
    },
    insert = {
        a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
    },
    command = {
        a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
    },
}

lualine.setup({
    options = {
        theme = my_lualine_theme,
        disabled_filetypes = { "NvimTree", "alpha" },
    },
    sections = {
        lualine_x = {
            { "encoding" },
            { "fileformat" },
            { "filetype" },
        },
    },
    extensions = { "fugitive" },
})

-- Fidget
require("fidget").setup({})
