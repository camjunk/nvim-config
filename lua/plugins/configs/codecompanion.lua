-- ============================================================================
-- CodeCompanion.nvim - AI 编程助手（修复内联功能）
-- ============================================================================

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"zbirenbaum/copilot.lua",
			opts = {
				suggestion = { enabled = true },
				panel = { enabled = false },
			},
		},
	},
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionActions",
		"CodeCompanionToggle",
	},
	keys = {
		-- 基础功能
		{
			"<leader>aa",
			function()
				local actions = {
					{ name = "💬 中文聊天", cmd = "CodeCompanionChat" },
					{ name = "📝 解释代码", cmd = "CodeCompanion /explain" },
					{ name = "🔧 修复错误", cmd = "CodeCompanion /fix" },
					{ name = "⚡ 优化代码", cmd = "CodeCompanion /optimize" },
					{ name = "🧪 生成测试", cmd = "CodeCompanion /tests" },
					{ name = "📚 生成文档", cmd = "CodeCompanion /docs" },
					{ name = "🔍 代码审查", cmd = "CodeCompanion /review" },
					{ name = "♻️  重构建议", cmd = "CodeCompanion /refactor" },
					{ name = "➕ 添加到聊天", cmd = "CodeCompanionChat Add" },
				}

				vim.ui.select(actions, {
					prompt = "CodeCompanion 动作 > ",
					format_item = function(item)
						return item.name
					end,
				}, function(choice)
					if choice then
						vim.cmd(choice.cmd)
					end
				end)
			end,
			mode = { "n", "v" },
			desc = "CodeCompanion 动作",
		},
		{
			"<leader>ac",
			"<cmd>CodeCompanionChat Toggle<cr>",
			mode = { "n", "v" },
			desc = "CodeCompanion 聊天",
		},
		{
			"<leader>ai",
			"<cmd>CodeCompanion<cr>",
			mode = { "n", "v" }, -- ✅ 支持 visual 模式
			desc = "CodeCompanion 内联",
		},

		-- 快速操作
		{
			"<leader>ae",
			"<cmd>CodeCompanionChat Add<cr>",
			mode = "v",
			desc = "添加到聊天",
		},
		{
			"<leader>ax",
			function()
				vim.cmd("CodeCompanion /explain")
			end,
			mode = { "n", "v" },
			desc = "解释代码",
		},
		{
			"<leader>af",
			function()
				vim.cmd("CodeCompanion /fix")
			end,
			mode = { "n", "v" },
			desc = "修复代码",
		},
		{
			"<leader>ao",
			function()
				vim.cmd("CodeCompanion /optimize")
			end,
			mode = { "n", "v" },
			desc = "优化代码",
		},
		{
			"<leader>at",
			function()
				vim.cmd("CodeCompanion /tests")
			end,
			mode = { "n", "v" },
			desc = "生成测试",
		},
		{
			"<leader>ad",
			function()
				vim.cmd("CodeCompanion /docs")
			end,
			mode = { "n", "v" },
			desc = "生成文档",
		},
		{
			"<leader>ar",
			function()
				vim.cmd("CodeCompanion /review")
			end,
			mode = { "n", "v" },
			desc = "代码审查",
		},
		{
			"<leader>aR",
			function()
				vim.cmd("CodeCompanion /refactor")
			end,
			mode = { "n", "v" },
			desc = "重构建议",
		},
	},

	config = function()
		require("codecompanion").setup({
			-- ===== 适配器配置 =====
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "gpt-4",
							},
						},
					})
				end,
			},

			-- ===== 策略配置 =====
			strategies = {
				chat = {
					adapter = "copilot",
					slash_commands = {
						["buffer"] = {
							callback = "strategies.chat.slash_commands.buffer",
							description = "插入打开的缓冲区",
							opts = {
								contains_code = true,
								provider = "default",
							},
						},
						["file"] = {
							callback = "strategies.chat.slash_commands.file",
							description = "插入文件",
							opts = {
								contains_code = true,
								max_lines = 1000,
								provider = "default",
							},
						},
						["help"] = {
							callback = "strategies.chat.slash_commands.help",
							description = "插入帮助标签",
							opts = {
								contains_code = false,
								max_lines = 128,
								provider = "default",
							},
						},
						["now"] = {
							callback = "strategies.chat.slash_commands.now",
							description = "插入当前日期和时间",
							opts = {
								contains_code = false,
							},
						},
						["symbols"] = {
							callback = "strategies.chat.slash_commands.symbols",
							description = "插入符号/大纲",
							opts = {
								contains_code = true,
								provider = "default",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
				agent = {
					adapter = "copilot",
				},
			},

			-- ===== 中文提示词配置 =====
			prompt_library = {
				-- ===== 内联提示词（关键！）=====
				["Generate Code"] = {
					strategy = "inline", -- ✅ 内联策略
					description = "生成代码",
					opts = {
						index = 1,
						is_default = true,
						is_slash_cmd = false,
						user_prompt = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return [[你是一位专业的编程助手。
请根据用户的描述生成完整、可运行的代码。
- 只返回代码，不要添加解释
- 代码要符合最佳实践
- 考虑边界情况和错误处理
- 使用适当的注释（中文）]]
							end,
						},
						{
							role = "user",
							content = function(context)
								local text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return string.format(
									"我正在使用 %s 语言。\n\n请生成代码：%s\n\n%s",
									context.filetype,
									text,
									context.user_input or ""
								)
							end,
						},
					},
				},

				["Complete Code"] = {
					strategy = "inline", -- ✅ 内联策略
					description = "补全代码",
					opts = {
						index = 2,
						is_default = true,
						is_slash_cmd = false,
						user_prompt = false,
						auto_submit = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return [[你是一位代码补全助手。
请根据上下文补全代码。
- 只返回补全的代码，不要重复已有内容
- 保持代码风格一致
- 确保语法正确]]
							end,
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return string.format(
									"请补全以下 %s 代码：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
						},
					},
				},

				-- ===== 聊天提示词 =====
				["Custom"] = {
					strategy = "chat",
					description = "自定义提示",
					opts = {
						index = 3,
						is_default = true,
						is_slash_cmd = false,
						user_prompt = true,
					},
					prompts = {
						{
							role = "system",
							content = function()
								return "我是一个 AI 编程助手，精通多种语言。我会用中文详细、清晰地回答问题。"
							end,
						},
						{
							role = "user",
							content = function()
								return vim.fn.input("提示 > ")
							end,
						},
					},
				},

				["Explain"] = {
					strategy = "chat",
					description = "解释代码",
					opts = {
						index = 4,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位经验丰富的软件工程师。
请用中文详细解释以下代码：
1. 代码的主要功能是什么
2. 关键部分如何工作
3. 使用的算法或设计模式
4. 可能的优化建议

请用清晰、易懂的中文回答。]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文解释这段 %s 代码：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Fix"] = {
					strategy = "chat",
					description = "修复代码",
					opts = {
						index = 5,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位专业的代码审查员。
请用中文分析并修复代码中的问题：
1. 识别潜在的 bug 和错误
2. 提供修复方案
3. 解释为什么这样修复
4. 给出改进后的完整代码]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文修复这段 %s 代码：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Optimize"] = {
					strategy = "chat",
					description = "优化代码",
					opts = {
						index = 6,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位性能优化专家。
请用中文分析并优化以下代码：
1. 性能优化建议
2. 可读性改进
3. 代码简化方案
4. 提供优化后的代码]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文优化这段 %s 代码：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Tests"] = {
					strategy = "chat",
					description = "生成测试",
					opts = {
						index = 7,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位测试工程师。
请用中文为以下代码生成完整的单元测试：
1. 覆盖主要功能
2. 包含边界情况
3. 测试异常处理
4. 使用合适的测试框架]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文为这段 %s 代码生成单元测试：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Docs"] = {
					strategy = "chat",
					description = "生成文档",
					opts = {
						index = 8,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位技术文档专家。
请用中文为以下代码生成完整的文档注释：
1. 函数/类的功能说明
2. 参数说明
3. 返回值说明
4. 使用示例]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文为这段 %s 代码生成文档：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Review"] = {
					strategy = "chat",
					description = "代码审查",
					opts = {
						index = 9,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位资深的代码审查专家。
请用中文对以下代码进行全面审查：
1. 代码质量评估
2. 潜在问题识别
3. 安全性分���
4. 最佳实践建议]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文审查这段 %s 代码：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Refactor"] = {
					strategy = "chat",
					description = "重构建议",
					opts = {
						index = 10,
						is_default = true,
						is_slash_cmd = true,
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = [[你是一位代码重构专家。
请用中文分析代码并提供重构建议：
1. 识别代码异味
2. 提出重构方案
3. 提供重构后的代码
4. 解释重构的好处]],
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return string.format(
									"请用中文为这�� %s 代码提供重构建议：\n\n```%s\n%s\n```",
									context.filetype,
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
			},

			-- ===== 显示配置 =====
			display = {
				action_palette = {
					width = 95,
					height = 10,
					prompt = "CodeCompanion 动作 > ",
					provider = "default",
				},
				chat = {
					window = {
						layout = "vertical",
						border = "rounded",
						height = 0.8,
						width = 0.45,
						relative = "editor",
						opts = {
							breakindent = true,
							cursorcolumn = false,
							cursorline = false,
							foldcolumn = "0",
							linebreak = true,
							list = false,
							signcolumn = "no",
							spell = false,
							wrap = true,
						},
					},
					intro_message = "👋 你好！我是你的 AI 编程助手，有什么可以帮你的吗？",
					show_settings = true,
					show_token_count = true,
				},
			},

			-- ===== ��认提示词 =====
			opts = {
				language = "Chinese",
				system_prompt = [[你是一位专业的 AI 编程助手。
请遵循以下原则：
1. 始终用中文回答
2. 提供的代码要完整、可运行
3. 解释要清晰易懂
4. 遵循最佳实践
5. 考虑性能和安全性]],
			},

			-- ===== 其他配置 =====
			log_level = "ERROR",
			send_code = true,
			use_default_actions = true, -- ✅ 启用默认动作
			use_default_prompt_library = true, -- ✅ 启用默认库（关键！）
		})

		-- ✅ 设置高亮组
		vim.api.nvim_set_hl(0, "CodeCompanionChatHeader", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "CodeCompanionChatAgent", { fg = "#61AFEF" })
		vim.api.nvim_set_hl(0, "CodeCompanionChatUser", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "CodeCompanionVirtualText", { fg = "#5C6370", italic = true })
	end,
}
