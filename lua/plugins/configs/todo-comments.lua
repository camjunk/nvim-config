-- ============================================================================
-- todo-comments.nvim - TODO 注释高亮
-- ============================================================================

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoLocList", "TodoQuickFix" },
  keys = {
<<<<<<< Updated upstream
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>ft", "<cmd>TodoQuickFix<cr>", desc = "搜索 TODO" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
=======
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "下一个 TODO",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "上一个 TODO",
    },
    {
      "<leader>ft",
      "<cmd>TodoQuickFix<cr>",  -- ✅ 简化为命令
      desc = "搜索 TODO",
    },
    {
      "<leader>xt",
      "<cmd>TodoTrouble<cr>",
      desc = "TODO 列表（Trouble）",
    },
>>>>>>> Stashed changes
  },
  opts = {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE",
      bg = "BOLD",
    },
    merge_keywords = true,
    highlight = {
      multiline = true,
      multiline_pattern = "^.",
      multiline_context = 10,
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
}
