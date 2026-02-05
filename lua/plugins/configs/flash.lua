-- ============================================================================
-- Flash.nvim 快速跳转配置
-- 提供闪电般的跳转和搜索功能
-- ============================================================================

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    -- ========================================================================
    -- 标签配置
    -- ========================================================================
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      multi_window = true,
      forward = true,
      wrap = true,
      mode = "exact",
      incremental = false,
      exclude = {
        "notify",
        "cmp_menu",
        "noice",
        "flash_prompt",
        function(win)
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
      trigger = "",
      max_length = nil,
    },

    -- ========================================================================
    -- 跳转配置
    -- ========================================================================
    jump = {
      jumplist = true,
      pos = "start",
      history = false,
      register = false,
      nohlsearch = false,
      autojump = false,
      inclusive = nil,
      offset = nil,
    },

    -- ========================================================================
    -- 标签模式配置
    -- ========================================================================
    label = {
      uppercase = true,
      exclude = "",
      current = true,
      after = true,
      before = false,
      style = "overlay",
      reuse = "lowercase",
      distance = true,
      min_pattern_length = 0,
      rainbow = {
        enabled = false,
        shade = 5,
      },
      format = function(opts)
        return { { opts.match.label, opts.hl_group } }
      end,
    },

    -- ========================================================================
    -- 高亮配置
    -- ========================================================================
    highlight = {
      backdrop = true,
      matches = true,
      priority = 5000,
      groups = {
        match = "FlashMatch",
        current = "FlashCurrent",
        backdrop = "FlashBackdrop",
        label = "FlashLabel",
      },
    },

    -- ========================================================================
    -- 模式配置
    -- ========================================================================
    modes = {
      -- 基础搜索模式
      search = {
        enabled = true,
        highlight = { backdrop = false },
        jump = { history = true, register = true, nohlsearch = true },
        search = {
          mode = "search",
          incremental = false,
        },
      },

      -- 字符跳转模式
      char = {
        enabled = true,
        config = function(opts)
          -- 自动隐藏：在 operator-pending 模式 ("no") 且操作是 yank 时启用
          -- 这避免了在复制操作时显示不必要的标签
          opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")
          opts.jump_labels = opts.jump_labels
              and vim.v.count == 0
              and vim.fn.reg_executing() == ""
              and vim.fn.reg_recording() == ""
        end,
        autohide = false,
        jump_labels = false,
        multi_line = true,
        label = { exclude = "hjkliardc" },
        keys = { "f", "F", "t", "T", ";", "," },
        char_actions = function(motion)
          return {
            [";"] = "next",
            [","] = "prev",
            [motion:lower()] = "next",
            [motion:upper()] = "prev",
          }
        end,
        search = { wrap = false },
        highlight = { backdrop = true },
        jump = { register = false },
      },

      -- Treesitter 节点跳转
      treesitter = {
        labels = "abcdefghijklmnopqrstuvwxyz",
        jump = { pos = "range" },
        search = { incremental = false },
        label = { before = true, after = true, style = "inline" },
        highlight = {
          backdrop = false,
          matches = false,
        },
      },

      -- 远程操作模式
      remote = {
        remote_op = { restore = true, motion = true },
      },

      -- Treesitter 搜索
      treesitter_search = {
        jump = { pos = "range" },
        search = { multi_window = true, wrap = true, incremental = false },
        remote_op = { restore = true },
        label = { before = true, after = true, style = "inline" },
      },
    },

    -- ========================================================================
    -- 提示配置
    -- ========================================================================
    prompt = {
      enabled = true,
      prefix = { { "⚡", "FlashPromptIcon" } },
      win_config = {
        relative = "editor",
        width = 1,
        height = 1,
        row = -1,
        col = 0,
        zindex = 1000,
      },
    },

    -- ========================================================================
    -- 远程操作
    -- ========================================================================
    remote_op = {
      restore = false,
      motion = false,
    },
  },

  -- ========================================================================
  -- 快捷键配置
  -- ========================================================================
  keys = {
    -- 基础跳转
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },

    -- Treesitter 节点跳转
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },

    -- 远程操作
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },

    -- Treesitter 搜索
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },

    -- 切换搜索
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
