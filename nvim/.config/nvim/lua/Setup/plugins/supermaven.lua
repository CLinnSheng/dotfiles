return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",

	opts = {
		keymaps = {
			accept_suggestion = nil, -- bind to Tab (or whatever you like)
			accept_word = "<C-l>",
			clear_suggestion = "<C-]>",
		},
		disable_inline_completion = vim.g.ai_cmp,
		ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
	},
}
