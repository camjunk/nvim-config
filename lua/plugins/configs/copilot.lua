-- ============================================================================
-- GitHub Copilot 配置（AI 代码补全）
-- ============================================================================

return {
<<<<<<< Updated upstream
  -- ===== 1. Copilot 核心引擎 =====
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = false, -- 禁用，由 blink-copilot 接管
        auto_trigger = false,
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node",
      server_opts_overrides = {},
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- ===== 2. Copilot 与 blink.cmp 桥接 =====
  {
    "fang2hou/blink-copilot",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "saghen/blink.cmp",
    },
    event = "InsertEnter",
    opts = {},
  },
=======
	-- ===== 1. Copilot 核心引擎 =====
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			panel = {
				enabled = false,
				auto_refresh = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
				help = false,
				gitcommit = true,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node",
			server_opts_overrides = {},
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			vim.api.nvim_set_hl(0, "CopilotSuggestion", {
				fg = "#555555",
				ctermfg = 8,
				italic = true,
			})
		end,
	},

	-- ===== 2. Copilot 与 blink.cmp 桥接 =====
	{
		"fang2hou/blink-copilot",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"saghen/blink.cmp",
		},
		event = "InsertEnter",
		config = function()
			local function register_copilot()
				local ok, blink = pcall(require, "blink.cmp")
				if not ok then
					return
				end

				if blink.config and blink.config.sources then
					table.insert(blink.config.sources.default, "copilot")
					blink.config.sources.providers.copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					}
				end
			end

			vim.defer_fn(register_copilot, 100)
		end,
	},
>>>>>>> Stashed changes
}
