return {
	"folke/noice.nvim",
	opts = {
		-- add any options here
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				timeout = 1200,
				stages = "slide_out",
				render = "minimal",
				fps = 60,
				background_colour = "#000000",
			},
		},
	},
}
