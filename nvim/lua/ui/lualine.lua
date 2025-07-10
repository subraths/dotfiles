return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = {
					"filename",
				},
				lualine_c = {},
				-- lualine_x = { "os.date('%a %d %b %H:%M')", "data", "require'lsp-status'.status()" },
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { "progress" },
			},
		})
	end,
}
