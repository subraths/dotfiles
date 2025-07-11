return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = function(colors)
					return {
						-- Better telescope colors
						TelescopeNormal = { bg = colors.mantle },
						TelescopeBorder = { bg = colors.mantle, fg = colors.blue },
						TelescopePromptNormal = { bg = colors.surface0 },
						TelescopePromptBorder = { bg = colors.surface0, fg = colors.blue },
						TelescopePromptTitle = { bg = colors.blue, fg = colors.mantle },
						TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
						TelescopeResultsTitle = { bg = colors.lavender, fg = colors.mantle },
						TelescopeSelection = { bg = colors.surface0, fg = colors.text },
						TelescopeSelectionCaret = { fg = colors.blue },
						
						-- Better completion colors
						CmpItemMenu = { fg = colors.overlay0 },
						CmpItemAbbrMatch = { fg = colors.blue, style = { "bold" } },
						CmpItemAbbrMatchFuzzy = { fg = colors.blue, style = { "bold" } },
					}
				end,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					telescope = {
						enabled = true,
					},
					lsp_trouble = true,
					which_key = true,
					barbecue = {
						dim_dirname = true,
						bold_basename = true,
						dim_context = false,
						alt_background = false,
					},
					indent_blankline = {
						enabled = true,
						scope_color = "",
						colored_indent_levels = false,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
				},
			})
			
			-- Set colorscheme
			vim.cmd.colorscheme("catppuccin")
			
			-- Additional highlight customizations
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#6c7086" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa" })
		end,
	},
}
