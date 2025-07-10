return {
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("alpha").setup(require("alpha.themes.theta").config)
		end,
	},
	{
		"Shatur/neovim-session-manager",
		keys = {
			{
				"<leader>ls",
				function()
					require("session_manager").load_session(false)
				end,
			},
			{
				"<leader>sm",
				"<cmd>SessionManager<cr>",
			},
		},
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
				autoload_mode = config.AutoloadMode.Disabled,
			})
		end,
	},
}
