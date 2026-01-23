return {
	-- {
	-- 	"rust-lang/rust.vim",
	-- 	ft = { "rust" },
	-- 	init = function()
	-- 		vim.g.rustfmt_autosave = 1
	-- 	end,
	-- },
	{
		"saecki/crates.nvim",
		ft = { "tonl" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enable = true,
					},
				},
				require("cmp").setup.buffer({ sources = { { name = "crates" } } }),
			})
		end,
	},
}
