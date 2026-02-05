-- ============================================================================
-- snacks.nvim 多功能工具集配置
-- 提供搜索、文件树、终端、Dashboard 等核心功能
-- ============================================================================

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- ========================================================================
    -- 大文件优化
    -- ========================================================================
    bigfile = {
      enabled = true,
      notify = true,
      size = 1024 * 1024, -- 1MB
      -- 自动禁用以下功能以提升性能
      setup = function(ctx)
        vim.b.minianimate_disable = true
        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
        end)
      end,
    },

    -- ========================================================================
    -- Dashboard 启动页
    -- ========================================================================
    dashboard = {
      enabled = true,
      preset = {
        -- 顶部 Logo
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        -- 快捷操作按钮
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },

    -- ========================================================================
    -- 缩进可视化
    -- ========================================================================
    indent = {
      enabled = true,
      indent = {
        enabled = true,
        char = "│",
        blank = " ",
        only_scope = false,
        only_current = false,
        hl = "IblIndent",
      },
      scope = {
        enabled = true,
        char = "│",
        underline = false,
        only_current = false,
        hl = "IblScope",
      },
      chunk = {
        enabled = false,
      },
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        duration = {
          step = 20,
          total = 300,
        },
        easing = "linear",
      },
    },

    -- ========================================================================
    -- 通知系统
    -- ========================================================================
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { "level", "added" },
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
    },

    -- ========================================================================
    -- Picker（搜索/选择器）
    -- ========================================================================
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-c>"] = { "close", mode = { "n", "i" } },
            ["<CR>"] = "confirm",
            ["<C-s>"] = "select_and_close",
            ["<C-q>"] = "toggle_select",
            ["<Tab>"] = "preview_scroll_down",
            ["<S-Tab>"] = "preview_scroll_up",
          },
        },
      },
      sources = {
        files = {
          hidden = false,
          follow = true,
        },
        grep = {
          hidden = false,
          follow = true,
        },
      },
      icons = {
        enabled = true,
      },
      previewers = {
        git = {
          enabled = true,
        },
      },
    },

    -- ========================================================================
    -- 快速文件导航
    -- ========================================================================
    quickfile = {
      enabled = true,
    },

    -- ========================================================================
    -- Scratch（临时笔记）
    -- ========================================================================
    scratch = {
      enabled = true,
      name = "Scratch",
      ft = "markdown",
      icon = "󰈙",
      root = vim.fn.stdpath("data") .. "/scratch",
      autowrite = true,
      filekey = {
        cwd = true,
        branch = true,
        count = true,
      },
      win = {
        width = 100,
        height = 30,
        border = "rounded",
        title_pos = "center",
        footer_pos = "center",
      },
      win_by_ft = {
        lua = {
          keys = {
            ["source"] = {
              "<cr>",
              function(self)
                local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                Snacks.debug.run({ buf = self.buf, name = name })
              end,
              desc = "Source buffer",
              mode = { "n", "x" },
            },
          },
        },
      },
    },

    -- ========================================================================
    -- 平滑滚动
    -- ========================================================================
    scroll = {
      enabled = true,
      animate = {
        duration = {
          step = 15,
          total = 250,
        },
        easing = "linear",
      },
      spamming = 10,
      -- 禁用某些操作的平滑滚动
      filter = function(buf, key)
        return vim.fn.mode() ~= "c" and not vim.wo.diff
      end,
    },

    -- ========================================================================
    -- 状态栏组件
    -- ========================================================================
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = true,
        git_hl = true,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50,
    },

    -- ========================================================================
    -- 终端管理
    -- ========================================================================
    terminal = {
      enabled = true,
      win = {
        position = "float",
        border = "rounded",
        width = 0.8,
        height = 0.8,
        title_pos = "center",
      },
      override = function(cmd, opts)
        opts.env = opts.env or {}
        opts.env.TERM = "xterm-256color"
      end,
    },

    -- ========================================================================
    -- 切换功能
    -- ========================================================================
    toggle = {
      enabled = true,
      which_key = true,
      notify = true,
      -- 常用切换项
      map = {
        -- 诊断
        diagnostics = {
          name = "Diagnostics",
          get = function()
            return vim.diagnostic.is_enabled and vim.diagnostic.is_enabled()
          end,
          set = function(state)
            if state then
              vim.diagnostic.enable()
            else
              vim.diagnostic.disable()
            end
          end,
        },
        -- 拼写检查
        spell = {
          name = "Spelling",
          get = function()
            return vim.wo.spell
          end,
          set = function(state)
            vim.wo.spell = state
          end,
        },
        -- 自动换行
        wrap = {
          name = "Wrap",
          get = function()
            return vim.wo.wrap
          end,
          set = function(state)
            vim.wo.wrap = state
          end,
        },
        -- 相对行号
        relative_number = {
          name = "Relative Number",
          get = function()
            return vim.wo.relativenumber
          end,
          set = function(state)
            vim.wo.relativenumber = state
          end,
        },
      },
    },

    -- ========================================================================
    -- Words（光标下单词高亮）
    -- ========================================================================
    words = {
      enabled = true,
      debounce = 200,
      notify_jump = false,
      notify_end = true,
      foldopen = true,
      jumplist = true,
      modes = { "n", "i", "c" },
    },

    -- ========================================================================
    -- 样式配置
    -- ========================================================================
    styles = {
      notification = {
        border = "rounded",
        zindex = 100,
        ft = "markdown",
        wo = {
          winblend = 5,
          wrap = true,
          conceallevel = 2,
        },
        bo = { filetype = "snacks_notif" },
      },
      notification_history = {
        border = "rounded",
        title = "Notification History",
        title_pos = "center",
        width = 0.6,
        height = 0.6,
        minimal = false,
      },
    },
  },

  -- ========================================================================
  -- 按键映射
  -- ========================================================================
  keys = {
    -- Picker（搜索）
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
    { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fm", function() Snacks.picker.man() end, desc = "Man Pages" },

    -- Git Picker
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Commits" },

    -- LSP Picker（预留）
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },

    -- 终端
    { "<leader>ft", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
    { "<leader>fT", function() Snacks.terminal.open() end, desc = "Open Terminal" },

    -- Scratch（临时笔记）
    { "<leader>sn", function() Snacks.scratch() end, desc = "Scratch Buffer" },
    { "<leader>sN", function() Snacks.scratch.select() end, desc = "Select Scratch" },

    -- 通知
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },

    -- Git 浏览
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },

    -- 切换功能
    { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle Diagnostics" },
    { "<leader>ul", function() Snacks.toggle.line_number():toggle() end, desc = "Toggle Line Numbers" },
    { "<leader>us", function() Snacks.toggle.spell():toggle() end, desc = "Toggle Spelling" },
    { "<leader>uw", function() Snacks.toggle.wrap():toggle() end, desc = "Toggle Wrap" },
    { "<leader>ur", function() Snacks.toggle.relative_number():toggle() end, desc = "Toggle Relative Number" },
  },

  -- ========================================================================
  -- 初始化
  -- ========================================================================
  init = function()
    -- 设置全局 Snacks 对象
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- 创建一些有用的切换功能
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        -- 在打开文件时显示通知
        Snacks.toggle.option("background", {
          name = "Dark Background",
          off = "light",
          on = "dark",
        }):map("<leader>ub")
      end,
    })
  end,
}
