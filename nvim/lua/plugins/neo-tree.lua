return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle dir=<cr>" },
		},
		opts = {
			close_if_last_window = true,
			default_component_configs = {
				diagnostics = {
					symbols = {
						hint = "󰌵",
						info = " ",
						warn = " ",
						error = " ",
					},
					highlights = {
						hint = "DiagnosticSignHint",
						info = "DiagnosticSignInfo",
						warn = "DiagnosticSignWarn",
						error = "DiagnosticSignError",
					},
				},
			},
			window = {
				width = 30,
				position = "right",
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
					leave_dir_open = false,
				},
				buffers = {
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--              -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
				},
				filtered_items = {
					hide_by_name = {
						"dist",
						"node_modules",
						"pnpm-lock.yaml",
					},
				},
			},
		},
	},
}
