return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- make netrw look better
	{ "prichrd/netrw.nvim", opts = {} },

	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"f-person/git-blame.nvim",
		opts = {
			message_template = "<summary> • <date> • <author>",
			date_format = "%r",
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",
			})
			vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<cr>")
			vim.keymap.set("t", "<C-\\>", "<cmd>ToggleTerm<cr>")
		end,
	},
	-- {
	-- 	"chrisgrieser/nvim-spider",
	-- 	lazy = true,
	-- 	keys = {
	-- 		{
	-- 			"e",
	-- 			"<cmd>lua require('spider').motion('e')<CR>",
	-- 			mode = { "n", "o", "x" },
	-- 		},
	-- 		{
	-- 			"w",
	-- 			"<cmd>lua require('spider').motion('w')<CR>",
	-- 			mode = { "n", "o", "x" },
	-- 		},
	-- 		{
	-- 			"b",
	-- 			"<cmd>lua require('spider').motion('b')<CR>",
	-- 			mode = { "n", "o", "x" },
	-- 		},
	-- 	},
	-- },
	{ "echasnovski/mini.surround", version = "*", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					-- ["html"] = {
					-- 	enable_close = false,
					-- },
				},
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
}
