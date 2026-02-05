-- ============================================================================
-- CodeCompanion.nvim - AI 助手配置
-- ============================================================================

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionToggle",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat<cr>", desc = "AI: 打开对话", mode = { "n", "v" } },
    { "<leader>at", "<cmd>CodeCompanionToggle<cr>", desc = "AI: 切换内联建议" },
    { "<leader>ae", "<cmd>CodeCompanionActions<cr>", desc = "AI: 快捷操作", mode = { "n", "v" } },
  },
  opts = {
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = "OPENAI_API_KEY",
          },
        })
      end,
    },

    strategies = {
      chat = {
        adapter = "openai",
      },
      inline = {
        adapter = "openai",
      },
    },

    display = {
      action_palette = {
        width = 95,
        height = 10,
      },
      chat = {
        window = {
          layout = "vertical",
          border = "rounded",
          height = 0.8,
          width = 0.45,
        },
      },
    },

    log_level = "ERROR",
  },

  config = function(_, opts)
    require("codecompanion").setup(opts)

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        local api_key = vim.env.OPENAI_API_KEY
        if not api_key or api_key == "" then
          vim.notify(
            "⚠️  CodeCompanion: 未检测到 OPENAI_API_KEY\n如需使用 AI 功能，请设置环境变量",
            vim.log.levels.WARN
          )
        end
      end,
    })
  end,
}
