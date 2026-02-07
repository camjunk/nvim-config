-- ============================================================================
-- UI 组件配置（lualine + bufferline）
-- ============================================================================

return {
<<<<<<< Updated upstream
  -- ===== 1. lualine - 状态栏 =====
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "auto", -- 自动适配主题
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "alpha", "dashboard", "snacks_dashboard" },
            winbar = {},
          },
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              path = 1, -- 0 = 仅文件名，1 = 相对路径，2 = 绝对路径
              shorting_target = 40,
            },
          },
          lualine_x = {
            -- Copilot 状态指示器
            {
              function()
                local ok, copilot_api = pcall(require, "copilot.api")
                if not ok then
                  return ""
                end
                local status = copilot_api.status.data
                if not status or not status.status then
                  return ""
                end
                if status.status == "Normal" then
                  return " "
                elseif status.status == "InProgress" then
                  return " "
                else
                  return ""
                end
              end,
              color = { fg = "#6CC644" },
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "lazy", "quickfix" },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },

  -- ===== 2. bufferline - 标签栏 =====
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    version = "*",
    opts = {
      options = {
        mode = "buffers",
        themable = true, -- 允许主题自定义
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "snacks_explorer",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },
=======
	-- ===== 1. lualine - 状态栏 =====
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = function()
			return {
				options = {
					theme = "auto", -- 自动适配主题

					component_separators = "|",
					section_separators = { left = "", right = "" },
					globalstatus = true,
					-- 始终只在底部显示一个全局状态栏
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "alpha", "dashboard", "snacks_dashboard" },
						winbar = {},
					},
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						"mode",
						-- separator = { left = "" },
						-- right_padding = 2
					},
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1, -- 0 = 仅文件名，1 = 相对路径，2 = 绝对路径
							shorting_target = 40,
						},
					},
					lualine_x = {
						-- Copilot 状态（阶段 3 启用）

						{
							function()
								local ok, copilot_api = pcall(require, "copilot.api")
								if not ok then
									return ""
								end

								local status = copilot_api.status.data
								if not status or not status.status then
									return " "
								end

								if status.status == "Normal" then
									return "" -- Copilot 正常
								elseif status.status == "InProgress" then
									return "" -- 正在生成
								else
									return "" -- 错误或离线
								end
							end,
							color = { fg = "#6CC644" },
						}, -- function()
						-- 	local status = vim.g.copilot_status or ""
						-- 	if status == "Normal" then
						-- 		return ""
						-- 	elseif status == "InProgress" then
						-- 		return "󰚩"
						-- 	else
						-- 		return ""
						-- 	end
						-- end,
						-- "encoding",

						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = {
						"location",
						-- specifier = { right = "" },
						-- left_padding = 2
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = { "lazy", "oil", "quickfix" },
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},

	-- ===== 2. bufferline - 标签栏 =====
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		version = "*",
		opts = {
			options = {
				mode = "buffers",
				themable = true, -- 允许主题自定义
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "▎",
					style = "icon",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15,
				truncate_names = true,
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				offsets = {
					{
						filetype = "oil",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				persist_buffer_sort = true,
				separator_style = "thin",
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				sort_by = "insert_after_current",
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
>>>>>>> Stashed changes
}
