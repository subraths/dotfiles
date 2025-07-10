return {
	{
		"NTBBloodbath/zig-tools.nvim",
		ft = "lua",
		config = function()
			require("zig-tools").setup()
		end,
		dependencies = {
			"akinsho/toggleterm.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
}
