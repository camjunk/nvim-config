-- ============================================================================
-- Noice.nvim - 美化命令行/消息/LSP 文档配置
-- ============================================================================

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		-- ========================================================================
		-- LSP 配置
		-- ========================================================================
		lsp = {
			-- 覆盖 LSP 文档和签名的 markdown 渲染
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},

			-- 悬停文档
			hover = {
				enabled = true,
				silent = false,
			},

			-- 签名帮助
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true,
					luasnip = true,
					throttle = 50,
				},
			},

			-- 消息
			message = {
				enabled = true,
				view = "notify",
			},

			-- 文档
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { concealcursor = "n", conceallevel = 3 },
				},
			},
		},

		-- ========================================================================
		-- 预设配置
		-- ========================================================================
		presets = {
			bottom_search = false, -- 搜索不在底部
			command_palette = true, -- 命令面板居中
			long_message_to_split = true, -- 长消息发送到分割窗口
			inc_rename = false, -- 不使用 inc_rename
			lsp_doc_border = true, -- LSP 文档边框
		},

		-- ========================================================================
		-- 命令行配置
		-- ========================================================================
		cmdline = {
			enabled = true,
			view = "cmdline_popup", -- 居中弹出式命令行
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
			},
		},

		-- ========================================================================
		-- 消息配置
		-- ========================================================================
		messages = {
			enabled = true,
			view = "notify",
			view_error = "notify",
			view_warn = "notify",
			view_history = "messages",
			view_search = "virtualtext",
		},

		-- ========================================================================
		-- 弹出菜单配置
		-- ========================================================================
		popupmenu = {
			enabled = true,
			backend = "nui", -- 使用 nui 后端
		},

		-- ========================================================================
		-- 通知配置
		-- ========================================================================
		notify = {
			enabled = true,
			view = "notify",
		},

		-- ========================================================================
		-- 路由配置（过滤不重要的消息）
		-- ========================================================================
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "more line",
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "fewer line",
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "lines yanked",
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "msg_show",
					kind = "search_count",
				},
				opts = { skip = true },
			},
		},

		-- ========================================================================
		-- 视图配置
		-- ========================================================================
		views = {
			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
		},
	},

	-- ========================================================================
	-- 快捷键配置
	-- ========================================================================
	keys = {
		{
			"<leader>nl",
			function()
				require("noice").cmd("last")
			end,
			desc = "Noice: 显示最后一条消息",
		},
		{
			"<leader>nh",
			function()
				-- require("noice").cmd("history")
				local message = require("noice").cmd("history")
				if message then
					vim.schedule(function()
						Snacks.win({
							buf = vim.api.nvim_create_buf(false, true),
							title = "消息历史",
							width = 0.8,
							height = 0.8,
						})
						vim.cmd("messages")
					end)
				end
			end,
			desc = "Noice: 显示消息历史",
		},
		{
			"<leader>na",
			function()
				require("noice").cmd("all")
			end,
			desc = "Noice: 显示所有消息",
		},
		{
			"<leader>nd",
			function()
				require("noice").cmd("dismiss")
			end,
			desc = "Noice: 关闭所有通知",
		},
		{
			"<C-f>",
			function()
				if not require("noice.lsp").scroll(4) then
					return "<C-f>"
				end
			end,
			silent = true,
			expr = true,
			desc = "Noice: 向下滚动",
			mode = { "i", "n", "s" },
		},
		{
			"<C-b>",
			function()
				if not require("noice.lsp").scroll(-4) then
					return "<C-b>"
				end
			end,
			silent = true,
			expr = true,
			desc = "Noice: 向上滚动",
			mode = { "i", "n", "s" },
		},
	},
}
