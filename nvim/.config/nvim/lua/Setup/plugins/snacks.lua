return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			explorer = {
				enabled = true,
				layout = {
					cycle = false,
				},
				show_hidden = true,
				sort = "name",
			},

			quickfile = {
				enabled = true,
			},

			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},

			picker = {
				enabled = true,

				matchers = {
					frequency = true,
					cwd_bonus = true,
				},

				formatters = {
					file = {
						filename_only = false,
						filename_first = false,
						icon_width = 2,
					},
				},

				layout = {
					preset = "telescope",
					cycle = false,
				},

				layouts = {
					select = {
						preview = false,
						layout = {
							backdrop = false,
							width = 0.6,
							min_width = 80,
							height = 0.4,
							min_height = 10,
							box = "vertical",
							border = "rounded",
							title = "{title}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
						},
					},

					telescope = {
						reverse = true,
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0.8,
							height = 0.9,
							border = "none",
							{
								box = "vertical",
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.50,
								border = "rounded",
								title_pos = "center",
							},
						},
					},
				},
			},
		},

		keys = {
			-- Explorer
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},

			-- Git
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Pick and Switch Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},

			-- Find
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},

			-- Grep
			{
				"<leader>sw",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep word",
			},
			{
				"<leader>sW",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},

			-- Search
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			}, -- Fixed: kkymaps -> keymaps
			{
				"<leader>sm",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},

			-- Rename
			{
				"<leader>rN",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},

			-- LSP
			-- added in lspconfig.lua
			-- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			-- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
			-- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			-- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			-- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
			-- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
			-- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
		},
	},

	-- Move todo-comments to a separate plugin spec
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		optional = true,
		keys = {
			{
				"<leader>pt",
				function()
					require("snacks").picker.todo_comments()
				end,
				desc = "Todo",
			},
		},
	},
}
