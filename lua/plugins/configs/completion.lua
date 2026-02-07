-- ============================================================================
-- blink.cmp - 现代化补全引擎配置
-- ============================================================================

return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
		"j-hui/fidget.nvim",
		"folke/lazydev.nvim",
	},
	version = "v0.*",
	opts = {
		-- ===== 补全触发配置 =====
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_next()
					end
				end,
				"snippet_forward",
				"fallback",
			},

			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		-- ===== 补全外观配置 =====
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		-- ===== 补全源配置 =====
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev", "copilot" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					-- 核心配置：启用颜色图标，并自定义色块样式（支持 emoji/nerd font/纯文本）
					opts = { tailwind_color_icon = "██" }, -- "██" 是色块，也可以用 "🟥" 等 emoji
					score_offset = 100,
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 3,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = 80,
					opts = {
						friendly_snippets = true,
						search_paths = { vim.fn.stdpath("config") .. "/snippets" },
						global_snippets = { "all" },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					score_offset = 5,
					opts = {
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
				lazydev = { module = "lazydev.integrations.blink", score_offset = 85 },
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 90,
					async = true,
					opts = {
						kind_icon = "",
						kind_hl = "DevIconCopilot",
					},
				},
			},
		},

		-- ===== 补全窗口配置 =====
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},

			menu = {
				enabled = true,
				min_width = 15,
				max_height = 10,
				border = "rounded",
				winblend = 0,
				scrolloff = 2,
				scrollbar = true,
				direction_priority = { "s", "n" },

				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				update_delay_ms = 50,
				treesitter_highlighting = true,
				window = {
					min_width = 10,
					max_width = 60,
					max_height = 20,
					border = "rounded",
					winblend = 0,
					scrollbar = true,
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},

			ghost_text = {
				enabled = false, -- 禁用（与 Copilot 冲突）
			},
		},

		-- ===== 签名帮助配置 =====
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				scrollbar = false,
			},
		},

		-- ===== 模糊匹配配置 =====
		--  fuzzy = {
		--    use_typo_resistance = true,
		--    use_frecency = true,
		--    use_proximity = true,
		--    max_items = 200,
		--    sorts = { "label", "kind", "score" },
		--  },
	},
}
