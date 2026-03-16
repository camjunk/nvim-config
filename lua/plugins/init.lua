-- ============================================================================
-- Lazy.nvim 插件配置
-- 基于 Issue #1 的分阶段实施计划
-- ============================================================================

-- lazy.nvim 配置选项
local lazy_config = {
	-- 性能优化
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- UI 配置
	ui = {
		border = "rounded",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
		},
	},
	-- 检测配置文件更改时自动重载
	change_detection = {
		enabled = true,
		notify = true,
	},
}

-- ============================================================================
-- 插件列表（第一阶段：基础架构）
-- ============================================================================

local plugins = {
	-- ========================================================================
	-- 主题插件（8 个主题）
	-- ========================================================================
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = false,
			})
		end,
	},

	{
		"shaunsingh/nord.nvim",
		priority = 1000,
		lazy = true,
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("onedark").setup({
				style = "dark",
			})
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = true,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("tokyonight").setup({
				style = "night",
			})
		end,
	},

	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		lazy = true,
	},

	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		lazy = true,
	},

	{
		"neanias/everforest-nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("everforest").setup({
				background = "hard",
			})
		end,
	},

	-- ========================================================================
	-- 基础依赖
	-- ========================================================================
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ========================================================================
	-- 阶段 2：核心插件配置 + UI 增强
	-- ========================================================================
	require("plugins.configs.snacks"), -- snacks.nvim 多功能工具集
	require("plugins.configs.mini"), -- mini.nvim 编辑增强套件
	-- require("plugins.configs.oil"), -- Oil.nvim 文件系统编辑器（主文件树）✅ 已更新
	require("plugins.configs.flash"), -- Flash.nvim 快速跳转
	require("plugins.configs.colors"), -- nvim-highlight-colors 颜色可视化
	require("plugins.configs.colorizer"), --Colorizer 颜色高亮插件（已更新）
	require("plugins.configs.live-server"), -- ✅ 添加 Live Server
	require("plugins.configs.browser-sync"), -- ✅ BrowserSync（强大）
	require("plugins.configs.ui"), -- lualine + bufferline UI 组件
	require("plugins.configs.nui"), -- ✅ 新增：nui.nvim UI 组件库
	require("plugins.configs.notify"), -- ✅ 新增：nvim-notify 通知系统
	require("plugins.configs.noice"), -- ✅ 新增：noice.nvim 美化系统

	-- ========================================================================
	-- 阶段 3：补全与 AI 系统
	-- ========================================================================
	require("plugins.configs.completion"), -- blink.cmp 现代化补全引擎
	require("plugins.configs.copilot"), -- GitHub Copilot AI 补全
	require("plugins.configs.snippets"), -- LuaSnip 代码片段引擎
	require("plugins.configs.treesitter"), -- Treesitter 语法高亮与解析
	require("plugins.configs.codecompanion"), -- CodeCompanion AI 助手

	-- ========================================================================
	-- 阶段 4：原生 LSP 配置
	-- ========================================================================
	require("plugins.configs.lsp"), -- Mason + LSP 系统

	-- ========================================================================
	-- 阶段 5：工具增强
	-- ========================================================================
	require("plugins.configs.markdown"), -- Markdown 增强
	require("plugins.configs.lazygit"), -- LazyGit
	require("plugins.configs.conform"), -- 格式化工具
	require("plugins.configs.lint"), -- Linting 工具
	require("plugins.configs.todo-comments"), -- TODO 高亮
	require("plugins.configs.trouble"), -- 诊断列表
	require("plugins.configs.which-key"), -- 快捷键提示

	-- ========================================================================
	-- 说明
	-- ========================================================================
	-- 最后阶段：
	-- - 阶段 6: 最终优化、性能调整、文档完善
}

-- ============================================================================
-- 初始化 Lazy.nvim
-- ============================================================================

require("lazy").setup(plugins, lazy_config)
