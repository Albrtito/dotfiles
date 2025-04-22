return {
	-- Setup nvim-dap
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Configuration for the UI
			require("dapui").setup()

			-- Configuration for python debugging
			require("dap-python").setup("./.venv/bin/python")
			-- If using the above, then `/path/to/venv/bin/python -m debugpy --version`
			-- must work in the shell)

			-- Open automatically all windows
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Keymaps for debugging
			vim.keymap.set("n", "<Leader>dp", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
			vim.keymap.set("n", "<Leader>do", dap.step_over, {})
			vim.keymap.set("n", "<Leader>di", dap.step_into, {})
			vim.keymap.set("n", "<Leader>dt", dap.terminate, {})
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, {})
			vim.keymap.set("n", "<Leader>dl", dap.run_last, {})
		end,
	},

	-- Setup mason-nvim-dap
	{
		"jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {}
        },

	},
}
