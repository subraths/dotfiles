return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				tree_setter = {
					enable = true,
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				auto_install = true,
				ensure_installed = { "lua", "tsx", "javascript", "typescript" },
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>", -- set to `false` to disable one of the mappings
						node_incremental = "<C-space>",
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
	--  A treesitter-module which will place equals, semicolons, commas and double points automatically for you!
	-- "filNaj/tree-setter",
	"nvim-treesitter/playground",
}
