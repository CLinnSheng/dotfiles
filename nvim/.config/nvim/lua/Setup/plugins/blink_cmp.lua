local trigger_text = ";"
return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	-- version = "1.*",
	opts = {
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

				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 15,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 85, -- the higher the number, the higher the priority
					should_show_items = function()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						-- NOTE: remember that `trigger_text` is modified at the top of the file
						return before_cursor:match(trigger_text .. "%w*$") ~= nil
					end,
					-- After accepting the completion, delete the trigger_text characters
					-- from the final inserted text
					-- Modified transform_items function based on suggestion by `synic` so
					-- that the luasnip source is not reloaded after each transformation
					-- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
					-- NOTE: I also tried to add the ";" prefix to all of the snippets loaded from
					-- friendly-snippets in the luasnip.lua file, but I was unable to do
					-- so, so I still have to use the transform_items here
					-- This removes the ";" only for the friendly-snippets snippets
					transform_items = function(_, items)
						local line = vim.api.nvim_get_current_line()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = line:sub(1, col)
						local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
						if start_pos then
							for _, item in ipairs(items) do
								if not item.trigger_text_modified then
									---@diagnostic disable-next-line: inject-field
									item.trigger_text_modified = true
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
										},
									}
								end
							end
						end
						return items
					end,
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
	},
}
