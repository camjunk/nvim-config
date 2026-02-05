-- ============================================================================
-- Trouble 诊断列表美化
-- ============================================================================

return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
  opts = {
    -- ========================================================================
    -- 基础配置
    -- ========================================================================
    modes = {
      -- 诊断模式配置
      diagnostics = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
      -- LSP 模式配置
      lsp = {
        mode = "lsp",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
      -- 符号模式配置
      symbols = {
        mode = "lsp_document_symbols",
        focus = false,
        win = {
          position = "right",
          size = 0.3,
        },
        filter = {
          -- 移除某些符号类型
          ["not"] = { ft = "help" },
        },
      },
      -- QuickFix 模式
      qflist = {
        mode = "qflist",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
      -- LocList 模式
      loclist = {
        mode = "loclist",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
      -- TODO 模式（与 todo-comments 集成）
      todo = {
        mode = "todo",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },

    -- ========================================================================
    -- UI 配置
    -- ========================================================================
    icons = {
      indent = {
        top = "│ ",
        middle = "├╴",
        last = "└╴",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
      folder_closed = " ",
      folder_open = " ",
      kinds = {
        Array = " ",
        Boolean = "󰨙 ",
        Class = " ",
        Constant = "󰏿 ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Function = "󰊕 ",
        Interface = " ",
        Key = " ",
        Method = "󰊕 ",
        Module = " ",
        Namespace = "󰦮 ",
        Null = " ",
        Number = "󰎠 ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        String = " ",
        Struct = "󰆼 ",
        TypeParameter = " ",
        Variable = "󰀫 ",
      },
    },

    -- ========================================================================
    -- 窗口配置
    -- ========================================================================
    win = {
      type = "split",
      position = "bottom",
      size = 10,
      wo = {
        wrap = false,
      },
    },

    -- ========================================================================
    -- 预览配置
    -- ========================================================================
    preview = {
      type = "split",
      relative = "win",
      position = "right",
      size = 0.3,
      wo = {
        wrap = true,
      },
    },

    -- ========================================================================
    -- 其他配置
    -- ========================================================================
    throttle = {
      refresh = 20, -- 刷新间隔（毫秒）
      update = 10, -- 更新间隔（毫秒）
      render = 10, -- 渲染间隔（毫秒）
      follow = 100, -- 跟随间隔（毫秒）
      preview = { ms = 100, debounce = true }, -- 预览延迟
    },

    keys = {
      ["?"] = "help",
      r = "refresh",
      R = "toggle_refresh",
      q = "close",
      o = "jump_close",
      ["<esc>"] = "cancel",
      ["<cr>"] = "jump",
      ["<2-leftmouse>"] = "jump",
      ["<c-s>"] = "jump_split",
      ["<c-v>"] = "jump_vsplit",
      ["}"] = "next",
      ["]]"] = "next",
      ["{"] = "prev",
      ["[["] = "prev",
      dd = "delete",
      d = { action = "delete", mode = "v" },
      i = "inspect",
      p = "preview",
      P = "toggle_preview",
      zo = "fold_open",
      zO = "fold_open_recursive",
      zc = "fold_close",
      zC = "fold_close_recursive",
      za = "fold_toggle",
      zA = "fold_toggle_recursive",
      zm = "fold_more",
      zM = "fold_close_all",
      zr = "fold_reduce",
      zR = "fold_open_all",
      zx = "fold_update",
      zX = "fold_update_all",
      zn = "fold_disable",
      zN = "fold_enable",
      zi = "fold_toggle_enable",
      gb = { -- 按缓冲区分组示例
        action = function(view)
          view:filter({ buf = 0 }, { toggle = true })
        end,
        desc = "Toggle Current Buffer Filter",
      },
      s = { -- 严重性过滤示例
        action = function(view)
          local f = view:get_filter("severity")
          local severity = ((f and f.filter.severity or 0) + 1) % 5
          view:filter({ severity = severity }, {
            id = "severity",
            template = "{hl:Title}Filter:{hl} {severity}",
            del = severity == 0,
          })
        end,
        desc = "Toggle Severity Filter",
      },
    },

    -- ========================================================================
    -- 自动命令配置
    -- ========================================================================
    auto_open = false, -- 自动打开
    auto_close = false, -- 自动关闭
    auto_preview = true, -- 自动预览
    auto_refresh = true, -- 自动刷新
    auto_jump = false, -- 自动跳转
    focus = false, -- 获取焦点
    restore = true, -- 恢复窗口
    follow = true, -- 跟随光标
    indent_guides = true, -- 显示缩进参考线
    max_items = 200, -- 最大项目数
    multiline = true, -- 多行支持
    pinned = false, -- 固定窗口
  },
}
