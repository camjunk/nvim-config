-- ============================================================================
-- Mason + LSP 插件配置
-- LSP 服务器管理与自动安装
-- ============================================================================

return {
	-- ========================================================================
	-- Mason 核心插件
	-- ========================================================================
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				width = 0.8,
				height = 0.8,
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			max_concurrent_installers = 10,
		},
	},

	-- ========================================================================
	-- Schema Store（JSON/YAML Schema 支持）
	-- ========================================================================
	{
		"b0o/schemastore.nvim",
		lazy = true,
		version = false,
	},

	-- ========================================================================
	-- LSP 系统初始化
	-- ========================================================================
	{
		"neovim/nvim-lspconfig", -- 仅用于确保 LSP 相关的依赖加载
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"b0o/schemastore.nvim",
		},
		config = function()
			-- 初始化原生 LSP 系统
			require("lsp").setup()
		end,
	},

	-- ========================================================================
	-- Mason LSP 配置（自动安装 LSP 服务器）
	-- ========================================================================
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			-- 自动安装的 LSP 服务器
			ensure_installed = {
				-- 前端
				"ts_ls", -- TypeScript/JavaScript
				-- "volar", -- Vue 3
				"vuels", -- Vue 3
				"html", -- HTML
				"cssls", -- CSS/SCSS/LESS
				"eslint", -- ESLint

				-- 配置文件
				"jsonls", -- JSON
				"yamlls", -- YAML

				-- 编程语言
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"rust_analyzer", -- Rust
				"bashls", -- Bash

				-- 文档
				"marksman", -- Markdown
			},

			-- 自动安装配置的服务器
			automatic_installation = true,
		},
	},
}
