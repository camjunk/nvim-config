-- ============================================================================
-- nvim-colorizer - 颜色高亮与预览
-- ============================================================================

return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer" },
	opts = {
		filetypes = {
			"*", -- 所有文件类型都启用
			css = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
			},
			scss = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				mode = "background",
			},
			sass = {
				RGB = true,
				RRGGBB = true,
				names = true,
				mode = "background",
			},
			html = {
				RGB = true,
				RRGGBB = true,
				names = true,
				mode = "background",
			},
			vue = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				mode = "background",
			},
			javascript = {
				RGB = true,
				RRGGBB = true,
				names = false,
				mode = "background",
			},
			typescript = {
				RGB = true,
				RRGGBB = true,
				names = false,
				mode = "background",
			},
		},

		user_default_options = {
			RGB = true, -- #RGB 十六进制颜色
			RRGGBB = true, -- #RRGGBB 十六进制颜色
			names = true, -- "Name" 颜色名称，如 Blue 或 blue
			RRGGBBAA = true, -- #RRGGBBAA 十六进制颜色
			AARRGGBB = true, -- 0xAARRGGBB 十六进制颜色
			rgb_fn = true, -- CSS rgb() 和 rgba() 函数
			hsl_fn = true, -- CSS hsl() 和 hsla() 函数
			css = true, -- 启用所有 CSS 功能
			css_fn = true, -- 启用所有 CSS *函数*

			-- 显示模式
			mode = "background", -- 可选: foreground, background, virtualtext

			-- Tailwind CSS 支持
			tailwind = true,

			-- Sass 支持
			sass = {
				enable = true,
				parsers = { "css" },
			},

			-- 虚拟文本字符
			virtualtext = "■",

			-- 实时更新
			always_update = true,
		},

		-- ✅ 为补全菜单添加颜色高亮支持
		buftypes = {},
	},

	config = function(_, opts)
		require("colorizer").setup(opts)

		-- ✅ 自动为相关文件类型启用颜色高亮
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"css",
				"scss",
				"sass",
				"html",
				"vue",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			},
			callback = function()
				vim.cmd("ColorizerAttachToBuffer")
			end,
		})

		-- ✅ 创建用户命令
		vim.api.nvim_create_user_command("ColorizerToggle", function()
			vim.cmd("ColorizerToggle")
		end, { desc = "切换颜色高亮" })

		vim.api.nvim_create_user_command("ColorizerReload", function()
			vim.cmd("ColorizerReloadAllBuffers")
		end, { desc = "重新加载所有缓冲区的颜色高亮" })
	end,
}
