-- ============================================================================
-- BrowserSync 集成 - 高级实时预览
-- ============================================================================

local M = {}

-- 存储 BrowserSync 终端实例
local bs_term = nil
local bs_running = false

-- 启动 BrowserSync
local function start_browser_sync()
	if bs_running then
		vim.notify("BrowserSync 已在运行", vim.log.levels.WARN, { title = "BrowserSync" })
		return
	end

	local cwd = vim.fn.getcwd()
	local current_file_dir = vim.fn.expand("%:p:h")

	-- 优先使用当前文件所在目录，如果是项目根目录则使用 cwd
	local server_dir = current_file_dir
	if vim.fn.filereadable(cwd .. "/package.json") == 1 then
		server_dir = cwd
	end

	vim.notify("正在启动 BrowserSync...", vim.log.levels.INFO, { title = "BrowserSync" })

	-- 使用 Snacks 终端启动 BrowserSync
	bs_term = Snacks.terminal.open({
		"browser-sync",
		"start",
		"--server",
		server_dir,
		"--files",
		"**/*.html,**/*.css,**/*.js,**/*.ts,**/*.vue",
		"--port",
		"3000",
		"--host",
		"0.0.0.0",
		"--browser",
		"chrome",
		"--no-notify",
		"--no-open",
		"--no-ui",
		"--reload-delay",
		"300",
		"--reload-debounce",
		"500",
	}, {
		cwd = server_dir,
		esc_esc = false,
		win = {
			position = "bottom",
			height = 0.3,
		},
	})

	bs_running = true

	-- 延迟后打开浏览器
	vim.defer_fn(function()
		vim.ui.open("http://localhost:3000")
		vim.notify(
			string.format("BrowserSync 运行在: http://localhost:3000\n服务目录: %s", server_dir),
			vim.log.levels.INFO,
			{
				title = "BrowserSync",
				timeout = 3000,
			}
		)
	end, 2000)
end

-- 停止 BrowserSync
local function stop_browser_sync()
	if not bs_running then
		vim.notify("BrowserSync 未运行", vim.log.levels.WARN, { title = "BrowserSync" })
		return
	end

	-- 关闭终端
	if bs_term then
		vim.cmd("close")
		bs_term = nil
	end

	bs_running = false
	vim.notify("BrowserSync 已停止", vim.log.levels.INFO, { title = "BrowserSync" })
end

-- 切换 BrowserSync
local function toggle_browser_sync()
	if bs_running then
		stop_browser_sync()
	else
		start_browser_sync()
	end
end

-- 创建用户命令
vim.api.nvim_create_user_command("BrowserSyncStart", start_browser_sync, {
	desc = "启动 BrowserSync",
})

vim.api.nvim_create_user_command("BrowserSyncStop", stop_browser_sync, {
	desc = "停止 BrowserSync",
})

vim.api.nvim_create_user_command("BrowserSyncToggle", toggle_browser_sync, {
	desc = "切换 BrowserSync",
})

-- 获取 BrowserSync 状态
vim.api.nvim_create_user_command("BrowserSyncStatus", function()
	if bs_running then
		vim.notify("BrowserSync 运行中\nURL: http://localhost:3000", vim.log.levels.INFO, { title = "BrowserSync" })
	else
		vim.notify("BrowserSync 未运行", vim.log.levels.INFO, { title = "BrowserSync" })
	end
end, { desc = "查看 BrowserSync 状态" })

-- 快捷键
vim.keymap.set("n", "<leader>bs", start_browser_sync, { desc = "启动 BrowserSync" })
vim.keymap.set("n", "<leader>bS", stop_browser_sync, { desc = "停止 BrowserSync" })
vim.keymap.set("n", "<leader>bt", toggle_browser_sync, { desc = "切换 BrowserSync" })
vim.keymap.set("n", "<leader>bi", ":BrowserSyncStatus<cr>", { desc = "BrowserSync 状态" })

return {}
