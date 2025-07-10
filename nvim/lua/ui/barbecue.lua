return {
	{
		-- :TODO if uninstalling this plugin, remove associated autocmd
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			create_autocmd = true,
			attach_navic = true,
		},
	},
}
