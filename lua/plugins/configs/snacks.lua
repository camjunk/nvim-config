-- ============================================================================
-- snacks.nvim 完整配置（多功能工具集）
-- ============================================================================

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- ===== 1. 大文件优化 =====
    bigfile = {
      enabled = true,
      size = 1024 * 1024, -- 1MB
      setup = function(ctx)
        vim.opt_local.swapfile = false
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.undolevels = -1
        vim.opt_local.undoreload = 0
        vim.opt_local.list = false
      end,
    },

    -- ===== 2. 启动页（Dashboard）=====
    dashboard = {
      enabled = true,
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        keys = {
          { icon = " ", key = "f", desc = "查找文件", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "新建文件", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "全局搜索", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "最近文件", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "编辑配置", action = ":e $MYVIMRC" },
          { icon = "󰒲 ", key = "l", desc = "Lazy 插件", action = ":Lazy" },
          { icon = " ", key = "q", desc = "退出", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },

    -- ===== 3. 缩进可视化 =====
    indent = {
      enabled = true,
      indent = {
        enabled = true,
        char = "│",
      },
      scope = {
        enabled = true,
        char = "│",
      },
    },

    -- ===== 4. 快速文件操作 =====
    quickfile = {
      enabled = true,
    },

    -- ===== 5. 平滑滚动 =====
    scroll = {
      enabled = true,
    },

    -- ===== 6. 状态栏列 =====
    statuscolumn = {
      enabled = false, -- 使用默认状态列
    },

    -- ===== 7. 光标下单词引用高亮 =====
    words = {
      enabled = true,
      debounce = 200,
    },

    -- ===== 8. 样式配置 =====
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },

  -- ===== 快捷键配置 =====
  keys = {
    -- 文件搜索
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "查找文件",
    },
    -- 全局搜索
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "全局搜索",
    },
    -- 搜索光标下的单词
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "搜索光标下的单词",
    },
    -- Buffer 搜索
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "查找 Buffer",
    },
    -- 最近文件
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "最近文件",
    },
    -- 帮助文档
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "搜索帮助文档",
    },
    -- 快捷键搜索
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "搜索快捷键",
    },
    -- 命令历史
    {
      "<leader>fc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "命令历史",
    },
    -- 浮动终端
    {
      "<leader>ft",
      function()
        Snacks.terminal()
      end,
      desc = "浮动终端",
    },
    -- 终端快捷切换
    {
      "<C-\\>",
      function()
        Snacks.terminal()
      end,
      desc = "切换终端",
      mode = { "n", "t" },
    },
    -- 临时笔记
    {
      "<leader>sn",
      function()
        Snacks.scratch()
      end,
      desc = "临时笔记",
    },
    -- 选择临时笔记
    {
      "<leader>sN",
      function()
        Snacks.scratch.select()
      end,
      desc = "选择临时笔记",
    },
    -- Git blame 行
    {
      "<leader>gB",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame 行",
    },
    -- 通知历史
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "通知历史",
    },
    -- 关闭所有通知
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "关闭所有通知",
    },
  },

  -- ===== 初始化配置 =====
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- 设置缩进高亮颜色
        vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#C678DD" })

        -- 创建一些实用命令
        vim.api.nvim_create_user_command("Notifications", function()
          Snacks.notifier.show_history()
        end, { desc = "显示通知历史" })
      end,
    })
  end,
}
