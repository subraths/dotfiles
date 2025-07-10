return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					treesitter = true,
					neotree = true,
					gitsigns = true,
					lsp_trouble = true,
				},
			})
			require("catppuccin").load("macchiato")
		end,
	},
}
