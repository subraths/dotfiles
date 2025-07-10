return {
	-- 	{
	-- 		"L3MON4D3/LuaSnip",
	-- 		build = "make install_jsregexp",
	-- 		dependencies = {
	-- 			"rafamadriz/friendly-snippets",
	-- 			"saadparwaiz1/cmp_luasnip",
	-- 		},
	-- 		keys = {
	-- 			{
	-- 				"<C-l>",
	-- 				function()
	-- 					require("luasnip").jump(1)
	-- 				end,
	-- 				mode = { "i", "s" },
	-- 			},
	-- 			{
	-- 				"<C-j>",
	-- 				function()
	-- 					require("luasnip").jump(-1)
	-- 				end,
	-- 				mode = { "i", "s" },
	-- 			},
	-- 		},
	-- 	},
	-- 	{
	-- 		"hrsh7th/nvim-cmp",
	-- 		lazy = false,
	-- 		dependencies = {
	-- 			"hrsh7th/cmp-buffer",
	-- 			"hrsh7th/cmp-path",
	-- 			"windwp/nvim-autopairs",
	-- 			"hrsh7th/cmp-nvim-lsp",
	-- 			"lukas-reineke/cmp-under-comparator",
	-- 		},
	-- 		config = function()
	-- 			local cmp = require("cmp")
	-- 			local luasnip = require("luasnip")
	-- 			-- If you want insert `(` after select function or method item
	-- 			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	-- 			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	--
	-- 			luasnip.filetype_extend("javascript", { "html" })
	-- 			luasnip.filetype_extend("javascriptreact", { "html" })
	-- 			luasnip.filetype_extend("typescriptreact", { "html" })
	--
	-- 			require("luasnip.loaders.from_vscode").lazy_load()
	--
	-- 			local kind_icons = {
	-- 				Text = "",
	-- 				Method = "󰆧",
	-- 				Function = "󰊕",
	-- 				Constructor = "",
	-- 				Field = "󰇽",
	-- 				Variable = "󰂡",
	-- 				Class = "󰠱",
	-- 				Interface = "",
	-- 				Module = "",
	-- 				Property = "󰜢",
	-- 				Unit = "",
	-- 				Value = "󰎠",
	-- 				Enum = "",
	-- 				Keyword = "󰌋",
	-- 				Snippet = "",
	-- 				Color = "󰏘",
	-- 				File = "󰈙",
	-- 				Reference = "",
	-- 				Folder = "󰉋",
	-- 				EnumMember = "",
	-- 				Constant = "󰏿",
	-- 				Struct = "",
	-- 				Event = "",
	-- 				Operator = "󰆕",
	-- 				TypeParameter = "󰅲",
	-- 				Copilot = "",
	-- 			}
	--
	-- 			cmp.setup({
	-- 				view = {
	-- 					docs = {
	-- 						auto_open = true,
	-- 					},
	-- 				},
	-- 				formatting = {
	-- 					format = function(_, vim_item)
	-- 						-- Kind icons
	-- 						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
	-- 						vim_item.menu = nil
	-- 						return vim_item
	-- 					end,
	-- 				},
	-- 				window = {
	-- 					documentation = cmp.config.window.bordered(),
	-- 					completion = cmp.config.window.bordered(),
	-- 				},
	-- 				preselect = cmp.PreselectMode.None,
	-- 				completion = {
	-- 					completeopt = "menu,menuone,preview",
	-- 				},
	-- 				snippet = {
	-- 					expand = function(args)
	-- 						require("luasnip").lsp_expand(args.body)
	-- 					end,
	-- 				},
	--
	-- 				mapping = cmp.mapping.preset.insert({
	-- 					["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 					["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 					["<C-Space>"] = cmp.mapping.complete(),
	-- 					["<C-e>"] = cmp.mapping.abort(),
	-- 					["<CR>"] = cmp.mapping.confirm({ select = true }),
	-- 					["<Tab>"] = cmp.mapping(function(fallback)
	-- 						if cmp.visible() then
	-- 							cmp.select_next_item()
	-- 						else
	-- 							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
	-- 						end
	-- 					end, { "i", "s" }),
	--
	-- 					["<S-Tab>"] = cmp.mapping(function()
	-- 						if cmp.visible() then
	-- 							cmp.select_prev_item()
	-- 						end
	-- 					end, { "i", "s" }),
	-- 				}),
	--
	-- 				sources = cmp.config.sources({
	-- 					{ name = "copilot", group_index = 2 },
	-- 					{ name = "nvim_lsp" },
	-- 					{ name = "nvim_lua" },
	-- 					{ name = "luasnip" },
	-- 					{ name = "path" },
	-- 					{
	-- 						name = "lazydev",
	-- 						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	-- 					},
	-- 				}, {
	-- 					{ name = "buffer" },
	-- 				}),
	-- 				sorting = {
	-- 					comparators = {
	-- 						cmp.config.compare.offset,
	-- 						cmp.config.compare.exact,
	-- 						cmp.config.compare.score,
	-- 						require("cmp-under-comparator").under,
	-- 						cmp.config.compare.kind,
	-- 						cmp.config.compare.sort_text,
	-- 						cmp.config.compare.length,
	-- 						cmp.config.compare.order,
	-- 					},
	-- 				},
	-- 				-- sorting = {
	-- 				-- 	comparators = {
	-- 				-- 		cmp.config.compare.offset,
	-- 				-- 		cmp.config.compare.exact,
	-- 				-- 		cmp.config.compare.score,
	-- 				-- 		function(entry1, entry2)
	-- 				-- 			local _, entry1_under = entry1.completion_item.label:find("^_+")
	-- 				-- 			local _, entry2_under = entry2.completion_item.label:find("^_+")
	-- 				-- 			entry1_under = entry1_under or 0
	-- 				-- 			entry2_under = entry2_under or 0
	-- 				-- 			if entry1_under > entry2_under then
	-- 				-- 				return false
	-- 				-- 			elseif entry1_under < entry2_under then
	-- 				-- 				return true
	-- 				-- 			end
	-- 				-- 		end,
	-- 				--
	-- 				-- 		cmp.config.compare.kind,
	-- 				-- 		cmp.config.compare.sort_text,
	-- 				-- 		cmp.config.compare.length,
	-- 				-- 		cmp.config.compare.order,
	-- 				-- 	},
	-- 				-- 	snippet = {
	-- 				-- 		expand = function(args)
	-- 				-- 			require("luasnip").lsp_expand(args.body)
	-- 				-- 		end,
	-- 				-- 	},
	-- 				-- },
	-- 			})
	-- 		end,
	-- 	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestions = {
					enabled = false,
				},
				server_opts_overrides = {
					trace = "verbose",
					settings = {
						advanced = {
							listCount = 10, -- #completions for panel
							inlineSuggestCount = 3, -- #completions for getCompletions
						},
					},
				},
			})
		end,
	},
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
