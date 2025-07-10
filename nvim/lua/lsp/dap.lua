return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dap.adapters["node2"] = {
				type = "executable",
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
				},
			}

			dap.configurations.javascript = {
				{
					name = "Launch",
					type = "node2",
					request = "launch",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
			}

			-- dap.listeners.before.attach.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.launch.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end

			vim.keymap.set("n", "<C-S-i>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<C-S-o>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<C-S-p>", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<leader>b", function()
				dap.toggle_breakpoint()
			end)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{
				"<leader>ui",
				function()
					require("dapui").toggle()
				end,
			},
		},
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = true,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-vscode-js").setup({
				node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.

				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			})
			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {
			highlight_changed_variables = false,
		},
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- dap config for golang
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
