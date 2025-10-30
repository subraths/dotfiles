return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {
		modes = {
			preview_float = {
				mode = "diagnostics",
				preview = {
					type = "float",
					relative = "editor",
					border = "rounded",
					title = "Preview",
					title_pos = "center",
					position = { 0, -2 },
					size = { width = 0.3, height = 0.3 },
					zindex = 200,
				},
			},
			lsp_document_symbols = {
				desc = "document symbols",
				mode = "lsp_document_symbols",
				focus = false,
				win = { position = "right" },
				filter = { 
					-- remove Package since luals uses it for control flow structures
					["not"] = { ft = "lua", kind = "Package" } 
				},
			},
		},
		icons = {
			indent = {
				middle = " ",
				last = " ",
				top = " ",
				ws = "│  ",
			},
			folder_closed = " ",
			folder_open = " ",
			kinds = {
				Array         = " ",
				Boolean       = "󰨙 ",
				Class         = " ",
				Constant      = "󰏿 ",
				Constructor   = " ",
				Enum          = " ",
				EnumMember    = " ",
				Event         = " ",
				Field         = " ",
				File          = " ",
				Function      = "󰊕 ",
				Interface     = " ",
				Key           = " ",
				Method        = "󰊕 ",
				Module        = " ",
				Namespace     = "󰦮 ",
				Null          = " ",
				Number        = "󰎠 ",
				Object        = " ",
				Operator      = " ",
				Package       = " ",
				Property      = " ",
				String        = " ",
				Struct        = "󰆼 ",
				TypeParameter = " ",
				Variable      = "󰀫 ",
			},
		},
	},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cS",
			"<cmd>Trouble lsp_document_symbols toggle focus=false win.position=right<cr>",
			desc = "LSP Document Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous trouble/quickfix item",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next trouble/quickfix item",
		},
	},
}
