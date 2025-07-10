return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			local code_actions = null_ls.builtins.code_actions
			local diagnostics = null_ls.builtins.diagnostics
			local hover = null_ls.builtins.hover
			local completion = null_ls.builtins.completion

			null_ls.setup({
				code_actions = code_actions,
				diagnostics = diagnostics,
				completion = completion,
				hover = hover,
			})
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
