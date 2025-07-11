return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			-- Integration with blink.cmp
			local blink_cmp = require("blink.cmp")
			local autopairs = require("nvim-autopairs.completion.blink")
			blink_cmp.setup({
				sources = {
					completion = {
						enabled_providers = { "lsp", "path", "snippets", "buffer", "copilot" },
					},
				},
				completion = {
					accept = {
						-- Auto-bracket completion
						auto_brackets = {
							enabled = true,
						},
					},
				},
			})
		end,
	},
}