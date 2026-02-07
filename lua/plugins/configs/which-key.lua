-- ============================================================================
-- Which-key 快捷键提示系统（v3 API）
-- ============================================================================

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- ========================================================================
		-- 基础配置
		-- ========================================================================
		preset = "modern", -- 使用现代化 UI 风格
		delay = 300, -- 延迟显示时间（毫秒）

		-- ========================================================================
		-- 插件配置
		-- ========================================================================
		plugins = {
			marks = true, -- 显示标记
			registers = true, -- 显示寄存器
			spelling = {
				enabled = true, -- 拼写建议
				suggestions = 20, -- 建议数量
			},
			presets = {
				operators = true, -- 操作符帮助
				motions = true, -- 移动帮助
				text_objects = true, -- 文本对象帮助
				windows = true, -- 窗口命令
				nav = true, -- 导航命令
				z = true, -- z 命令
				g = true, -- g 命令
			},
		},

		-- ========================================================================
		-- 窗口配置
		-- ========================================================================
		win = {
			border = "rounded", -- 边框样式
			padding = { 1, 2 }, -- 内边距
			title = true, -- 显示标题
			title_pos = "center", -- 标题位置
			zindex = 1000, -- z-index
			wo = {
				winblend = 0, -- 透明度
			},
		},

		-- ========================================================================
		-- 布局配置
		-- ========================================================================
		layout = {
			width = { min = 20, max = 50 }, -- 宽度
			height = { min = 4, max = 25 }, -- 高度
			spacing = 3, -- 列间距
			align = "left", -- 对齐方式
		},

		-- ========================================================================
		-- 过滤器配置
		-- ========================================================================
		filter = function(mapping)
			-- 排除某些映射
			return true
		end,

		-- ========================================================================
		-- 图标配置
		-- ========================================================================
		icons = {
			breadcrumb = "»", -- 面包屑分隔符
			separator = "➜", -- 键值分隔符
			group = "+", -- 组前缀
			ellipsis = "…", -- 省略号
			mappings = true, -- 显示映射图标
			rules = {}, -- 自定义图标规则
			colors = true, -- 使用颜色
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "⌫",
				Space = "󱁐 ",
				Tab = "󰌒 ",
			},
		},

<<<<<<< Updated upstream
    -- ========================================================================
    -- 快捷键分组配置（使用 v3 API + vim.schedule）
    -- ========================================================================
    vim.schedule(function()
      wk.add({
        -- 基础分组
        { "<leader>f", group = "Find/Telescope", mode = "n" },
        { "<leader>g", group = "Git", mode = "n" },
        { "<leader>x", group = "Diagnostics/Trouble", mode = "n" },
        { "<leader>m", group = "Markdown", mode = "n" },
        { "<leader>c", group = "Code", mode = "n" },
        { "<leader>l", group = "LSP", mode = "n" },
        { "<leader>s", group = "Search", mode = "n" },
        { "<leader>t", group = "Terminal/Toggle", mode = "n" },
        { "<leader>w", group = "Window", mode = "n" },
        { "<leader>b", group = "Buffer", mode = "n" },
        { "<leader>q", group = "Quit/Session", mode = "n" },

        -- Git 子分组
        { "<leader>gg", desc = "LazyGit", mode = "n" },
        { "<leader>gf", desc = "LazyGit Current File", mode = "n" },
        { "<leader>gc", desc = "LazyGit Config", mode = "n" },

        -- 查找子分组
        { "<leader>ff", desc = "Find Files", mode = "n" },
        { "<leader>fg", desc = "Live Grep", mode = "n" },
        { "<leader>fb", desc = "Find Buffers", mode = "n" },
        { "<leader>fh", desc = "Find Help", mode = "n" },
        { "<leader>ft", desc = "Find TODOs", mode = "n" },

        -- 诊断子分组
        { "<leader>xx", desc = "Diagnostics List", mode = "n" },
        { "<leader>xX", desc = "Buffer Diagnostics", mode = "n" },
        { "<leader>xs", desc = "Symbols", mode = "n" },
        { "<leader>xl", desc = "LSP Definitions/References", mode = "n" },
        { "<leader>xL", desc = "Location List", mode = "n" },
        { "<leader>xQ", desc = "Quickfix List", mode = "n" },
        { "<leader>xt", desc = "TODOs", mode = "n" },

        -- Markdown 子分组
        { "<leader>mp", desc = "Markdown Preview", mode = "n" },

        -- 代码子分组
        { "<leader>f", desc = "Format", mode = { "n", "v" } },

        -- LSP 子分组
        { "gd", desc = "Go to Definition", mode = "n" },
        { "gD", desc = "Go to Declaration", mode = "n" },
        { "gr", desc = "References", mode = "n" },
        { "gi", desc = "Go to Implementation", mode = "n" },
        { "K", desc = "Hover", mode = "n" },
        { "<leader>ca", desc = "Code Action", mode = "n" },
        { "<leader>rn", desc = "Rename", mode = "n" },

        -- TODO 导航
        { "]t", desc = "Next TODO", mode = "n" },
        { "[t", desc = "Previous TODO", mode = "n" },

        -- 诊断导航
        { "]d", desc = "Next Diagnostic", mode = "n" },
        { "[d", desc = "Previous Diagnostic", mode = "n" },
      })
    end)
  end,
=======
		-- ========================================================================
		-- 显示配置
		-- ========================================================================
		show_help = true, -- 显示帮助信息
		show_keys = true, -- 显示按键
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- ========================================================================
		-- 快捷键分组配置（使用 v3 API）
		-- ========================================================================
		wk.add({
			-- 基础分组
			{ "<leader>a", group = "AI" },
			{ "<leader>f", group = "Find/Telescope" },
			{ "<leader>g", group = "Git" },
			{ "<leader>x", group = "Diagnostics/Trouble" },
			{ "<leader>m", group = "Markdown" },
			{ "<leader>c", group = "Code" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>s", group = "Window" },
			{ "<leader>t", group = "Terminal/Toggle" },
			{ "<leader>n", group = "notify" },
			{ "<leader>w", group = "Window" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>q", group = "Quit/Session" },
			{ "<leader>z", group = "代码折叠" },

			-- Git 子分组
			{ "<leader>gg", desc = "LazyGit" },
			{ "<leader>gf", desc = "LazyGit Current File" },
			{ "<leader>gc", desc = "LazyGit Config" },

			-- 查找子分组
			{ "<leader>ff", desc = "Find Files" },
			{ "<leader>fg", desc = "Live Grep" },
			{ "<leader>fb", desc = "Find Buffers" },
			{ "<leader>fh", desc = "Find Help" },
			{ "<leader>ft", desc = "Find TODOs" },

			-- 诊断子分组
			{ "<leader>xx", desc = "Diagnostics List" },
			{ "<leader>xX", desc = "Buffer Diagnostics" },
			{ "<leader>xs", desc = "Symbols" },
			{ "<leader>xl", desc = "LSP Definitions/References" },
			{ "<leader>xL", desc = "Location List" },
			{ "<leader>xQ", desc = "Quickfix List" },
			{ "<leader>xt", desc = "TODOs" },

			-- Markdown 子分组
			{ "<leader>mp", desc = "Markdown Preview" },

			-- 代码子分组
			-- { "<leader>f", desc = "Format", mode = { "n", "v" } },

			-- LSP 子分组
			{ "gd", desc = "Go to Definition" },
			{ "gD", desc = "Go to Declaration" },
			{ "gr", desc = "References" },
			{ "gi", desc = "Go to Implementation" },
			{ "K", desc = "Hover" },
			{ "<leader>la", desc = "Code Action" },
			{ "<leader>lr", desc = "Rename" },

			-- TODO 导航
			{ "]t", desc = "Next TODO" },
			{ "[t", desc = "Previous TODO" },

			-- 诊断导航
			{ "]d", desc = "Next Diagnostic" },
			{ "[d", desc = "Previous Diagnostic" },
		})
	end,
>>>>>>> Stashed changes
}
