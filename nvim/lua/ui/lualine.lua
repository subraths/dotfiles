return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		local function get_lsp_clients()
			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			if #clients == 0 then
				return "No LSP"
			end
			local client_names = {}
			for _, client in ipairs(clients) do
				table.insert(client_names, client.name)
			end
			return table.concat(client_names, ", ")
		end

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { 
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 3)
						end,
					}
				},
				lualine_b = {
					{
						"branch",
						icon = "",
					},
					{
						"diff",
						source = diff_source,
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = " ",
						},
					},
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
				},
				lualine_x = {
					{
						get_lsp_clients,
						icon = " ",
						color = { gui = "bold" },
					},
					"encoding",
					{
						"fileformat",
						symbols = {
							unix = "", -- e712
							dos = "", -- e70f
							mac = "", -- e711
						},
					},
					"filetype",
				},
				lualine_y = {
					{
						"progress",
						separator = " ",
						padding = { left = 1, right = 0 },
					},
					{
						"location",
						padding = { left = 0, right = 1 },
					},
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "neo-tree", "lazy", "trouble", "mason" },
		})
	end,
}
