return {
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
			},
			floating_window = true,

			-- virtual text
			hint_enable = false,
		},
	},
}
