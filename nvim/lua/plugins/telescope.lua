return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader><space>", builtin.find_files, {})
			vim.keymap.set("n", "fg", builtin.live_grep, {})
			vim.keymap.set("n", "<C-b>", builtin.buffers, {})
			vim.keymap.set("n", "fo", builtin.oldfiles, {})
			vim.keymap.set("n", "gr", builtin.lsp_references, {})
			vim.keymap.set("n", "gd", builtin.lsp_definitions, {})

			local open_with_trouble = require("trouble.sources.telescope").open
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- layout_strategy = "horizontal",
					-- layout_config = {
					-- 	horizontal = {
					-- 		position = "top",
					-- 	},
					-- },
					-- sorting_strategy = "ascending",
					mappings = {
						i = { ["<c-t>"] = open_with_trouble, ["<esc>"] = actions.close },
						n = { ["<c-t>"] = open_with_trouble },
					},
				},
			})
		end,
	},
	-- using dressing.nvim as alternative for telescope-ui-select
	-- {
	-- 	"nvim-telescope/telescope-ui-select.nvim",
	-- 	config = function()
	-- 		require("telescope").setup({
	-- 			extensions = {
	-- 				["ui-select"] = {
	-- 					require("telescope.themes").get_dropdown({}),
	-- 				},
	-- 			},
	-- 		})
	-- 		require("telescope").load_extension("ui-select")
	-- 	end,
	-- },
}
