-- ============================================================================
-- TODO 高亮与诊断列表美化
-- ============================================================================

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>ft", "<cmd>TodoQuickFix<cr>", desc = "搜索 TODO" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
  },
  opts = {
    -- ========================================================================
    -- TODO 关键词配置
    -- ========================================================================
    signs = true, -- 在 sign column 显示图标
    sign_priority = 8, -- sign 优先级
    keywords = {
      FIX = {
        icon = " ", -- 错误图标
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = {
        icon = " ", -- 待办图标
        color = "info",
      },
      HACK = {
        icon = " ", -- 骇客图标
        color = "warning",
      },
      WARN = {
        icon = " ", -- 警告图标
        color = "warning",
        alt = { "WARNING", "XXX" },
      },
      PERF = {
        icon = " ", -- 性能图标
        color = "default",
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      NOTE = {
        icon = " ", -- 笔记图标
        color = "hint",
        alt = { "INFO" },
      },
      TEST = {
        icon = "⏲ ", -- 测试图标
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },

    -- ========================================================================
    -- GUI 样式配置
    -- ========================================================================
    gui_style = {
      fg = "NONE", -- 前景色样式
      bg = "BOLD", -- 背景色样式（NONE, BOLD, ITALIC, UNDERLINE）
    },
    merge_keywords = true, -- 合并默认关键词

    -- ========================================================================
    -- 高亮配置
    -- ========================================================================
    highlight = {
      multiline = true, -- 启用多行 TODO 注释
      multiline_pattern = "^.", -- Lua 模式匹配多行注释
      multiline_context = 10, -- 额外显示的上下文行数
      before = "", -- 关键词前的高亮
      keyword = "wide", -- 关键词高亮模式（fg, bg, wide, wide_bg, wide_fg）
      after = "fg", -- 关键词后的高亮
      pattern = [[.*<(KEYWORDS)\s*:]], -- 匹配模式
      comments_only = true, -- 仅在注释中查找
      max_line_len = 400, -- 忽略超长行
      exclude = {}, -- 排除的文件类型
    },

    -- ========================================================================
    -- 颜色配置
    -- ========================================================================
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },

    -- ========================================================================
    -- 搜索配置
    -- ========================================================================
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]], -- ripgrep 正则表达式
    },
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)

    -- ========================================================================
    -- 自定义命令
    -- ========================================================================

    -- 使用 Snacks picker 搜索 TODO（如果 Snacks 可用）
    vim.api.nvim_create_user_command("TodoSnacks", function()
      local has_snacks, snacks = pcall(require, "snacks")
      if has_snacks and snacks.picker then
        snacks.picker.todo_comments()
      else
        -- 回退到 Telescope（如果可用）
        local has_telescope, telescope = pcall(require, "telescope")
        if has_telescope then
          telescope.extensions["todo-comments"].todo()
        else
          vim.notify("Neither Snacks nor Telescope available for TODO search", vim.log.levels.WARN)
        end
      end
    end, { desc = "Search TODOs with Snacks" })

    -- Trouble 集成
    vim.api.nvim_create_user_command("TodoTrouble", function()
      local has_trouble, trouble = pcall(require, "trouble")
      if has_trouble then
        trouble.toggle("todo")
      else
        vim.notify("Trouble not available", vim.log.levels.WARN)
      end
    end, { desc = "Show TODOs in Trouble" })
  end,
}
