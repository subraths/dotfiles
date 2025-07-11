return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		
		-- Register common keymaps with descriptions
		wk.add({
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>t", group = "Terminal/Toggle" },
			{ "<leader>w", group = "Window" },
			{ "<leader>x", group = "Trouble/Diagnostics" },
			{ "<leader>s", group = "Search/Session" },
			{ "<leader>b", group = "Buffer" },
		})
	end,
}