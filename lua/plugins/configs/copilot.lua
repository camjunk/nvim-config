-- ============================================================================
-- GitHub Copilot 配置（AI 代码补全）
-- ============================================================================

return {
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
}
