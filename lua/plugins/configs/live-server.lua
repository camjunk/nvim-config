-- ============================================================================
-- live-server.nvim - 实时预览 HTML/CSS/JS
-- ============================================================================

return {
	"barrett-ruth/live-server.nvim",
	build = "npm install -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
	ft = { "html", "css", "javascript", "typescript", "vue", "svelte" },
	keys = {
		{
			"<leader>ls",
			"<cmd>LiveServerStart<cr>",
			desc = "启动 Live Server",
			ft = { "html", "css", "javascript" },
		},
		{
			"<leader>lS",
			"<cmd>LiveServerStop<cr>",
			desc = "停止 Live Server",
			ft = { "html", "css", "javascript" },
		},
		{
			"<leader>lt",
			"<cmd>LiveServerToggle<cr>",
			desc = "切换 Live Server",
			ft = { "html", "css", "javascript" },
		},
	},
	opts = {
		-- 服务器配置
		args = {
			"--port=5500", -- 端口号（与 VSCode 默认一致）
			"--host=localhost", -- 主机
			"--no-browser", -- 不自动打开浏览器（可选）
			"--quiet", -- 静默模式
		},

		-- 自动保存时重载
		autosave = true,
	},

	config = function(_, opts)
		require("live-server").setup(opts)

		-- 创建自动命令：保存时刷新
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.html", "*.css", "*.js", "*.ts", "*.vue" },
			callback = function()
				-- 如果 Live Server 正在运行，会自动刷新
				vim.notify("Live Server: 文件已更新", vim.log.levels.INFO, { title = "Live Server" })
			end,
		})

		-- 自定义通知样式
		vim.api.nvim_create_user_command("LiveServerOpen", function()
			vim.cmd("LiveServerStart")
			vim.defer_fn(function()
				vim.ui.open("http://localhost:5500")
			end, 1000)
		end, { desc = "启动 Live Server 并打开浏览器" })
	end,
}
