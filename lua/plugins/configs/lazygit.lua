-- ============================================================================
-- LazyGit 集成配置
-- ============================================================================

return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		{ "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
		{ "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "LazyGit Config" },
	},
	config = function()
		-- LazyGit 配置
		vim.g.lazygit_floating_window_winblend = 10 -- 透明度
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 窗口大小比例
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- 边框字符
		vim.g.lazygit_floating_window_use_plenary = 1 -- 使用 plenary.nvim
		vim.g.lazygit_use_neovim_remote = 1 -- 使用 neovim-remote
		vim.g.lazygit_use_custom_config_file_path = 0 -- 使用自定义配置文件

		vim.g.lazygit_on_exit_callback = function()
			-- 退出后刷新文件缓冲区（避免 Git 操作后内容不同步）
			vim.cmd("checktime")
			-- 可选：刷新 GitGutter/NeoGit 等插件的状态
			-- pcall(vim.cmd, "GitGutterRefresh")
		end

		-- 设置 LazyGit 打开时的自动命令
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "lazygit" then
					-- 禁用行号
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
				end
			end,
			desc = "Disable line numbers in LazyGit",
		})
	end,
}
