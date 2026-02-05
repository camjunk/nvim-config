-- ============================================================================
-- mini.nvim 编辑增强套件配置
-- 提供括号补全、环绕操作、注释、文本对象等功能
-- ============================================================================

return {
  -- ========================================================================
  -- mini.nvim 核心插件
  -- ========================================================================
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- ======================================================================
      -- mini.pairs - 括号/引号自动补全
      -- ======================================================================
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },
      })

      -- ======================================================================
      -- mini.surround - 符号环绕操作（sa/sd/sr）
      -- ======================================================================
      require("mini.surround").setup({
        mappings = {
          add = "sa",            -- 添加环绕: sa{motion}{char}
          delete = "sd",         -- 删除环绕: sd{char}
          find = "sf",           -- 查找右侧环绕: sf{char}
          find_left = "sF",      -- 查找左侧环绕: sF{char}
          highlight = "sh",      -- 高亮环绕: sh{char}
          replace = "sr",        -- 替换环绕: sr{char}{char}
          update_n_lines = "sn", -- 更新搜索行数: sn
        },
        n_lines = 50,
        respect_selection_type = true,
        search_method = "cover_or_next",
      })

      -- ======================================================================
      -- mini.comment - 快速注释（gcc/gc）
      -- ======================================================================
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            -- 仅在 treesitter 可用时使用（将在阶段 3 添加）
            local has_ts_context, ts_context = pcall(require, "ts_context_commentstring.internal")
            if has_ts_context then
              return ts_context.calculate_commentstring() or vim.bo.commentstring
            end
            return vim.bo.commentstring
          end,
          ignore_blank_line = true,
          start_of_line = false,
          pad_comment_parts = true,
        },
        mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
          textobject = "gc",
        },
        hooks = {
          pre = function()
            -- 仅在 treesitter 可用时更新 commentstring
            local has_ts_context, ts_context = pcall(require, "ts_context_commentstring.internal")
            if has_ts_context then
              ts_context.update_commentstring({})
            end
          end,
        },
      })

      -- ======================================================================
      -- mini.ai - 文本对象增强
      -- ======================================================================
      local ai_config = {
        n_lines = 500,
        custom_textobjects = {
          -- 整个文件
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
        mappings = {
          around = "a",
          inside = "i",
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
          goto_left = "g[",
          goto_right = "g]",
        },
      }

      -- 仅在 treesitter 可用时添加 treesitter 文本对象（将在阶段 3 添加）
      local has_treesitter = pcall(require, "nvim-treesitter")
      if has_treesitter then
        ai_config.custom_textobjects.f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {})
        ai_config.custom_textobjects.c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {})
        ai_config.custom_textobjects.o = require("mini.ai").gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }, {})
        ai_config.custom_textobjects.l = require("mini.ai").gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }, {})
        ai_config.custom_textobjects.a = require("mini.ai").gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {})
      end

      require("mini.ai").setup(ai_config)

      -- ======================================================================
      -- mini.diff - Git diff 可视化覆盖层
      -- ======================================================================
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = {
            add = "▎",
            change = "▎",
            delete = "▁",
          },
          priority = 199,
        },
        source = nil,
        delay = {
          text_change = 200,
        },
        mappings = {
          apply = "gh",
          reset = "gH",
          textobject = "gh",
          goto_first = "[H",
          goto_prev = "[h",
          goto_next = "]h",
          goto_last = "]H",
        },
        options = {
          algorithm = "histogram",
          indent_heuristic = true,
          linematch = 60,
        },
      })

      -- ======================================================================
      -- mini.git - Git 集成
      -- ======================================================================
      require("mini.git").setup({
        job = {
          git_executable = "git",
          timeout = 30000,
        },
        command = {
          split = "auto",
        },
      })

      -- ======================================================================
      -- mini.bracketed - 增强跳转（[b]b [q]q [h]h）
      -- ======================================================================
      require("mini.bracketed").setup({
        buffer = { suffix = "b", options = {} },
        comment = { suffix = "c", options = {} },
        conflict = { suffix = "x", options = {} },
        diagnostic = { suffix = "d", options = {} },
        file = { suffix = "f", options = {} },
        indent = { suffix = "i", options = {} },
        jump = { suffix = "j", options = {} },
        location = { suffix = "l", options = {} },
        oldfile = { suffix = "o", options = {} },
        quickfix = { suffix = "q", options = {} },
        treesitter = { suffix = "t", options = {} },
        undo = { suffix = "u", options = {} },
        window = { suffix = "w", options = {} },
        yank = { suffix = "y", options = {} },
      })

      -- ======================================================================
      -- mini.trailspace - 尾随空格管理
      -- ======================================================================
      require("mini.trailspace").setup({
        only_in_normal_buffers = true,
      })

      -- 自动删除尾随空格（保存时）
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          if not vim.b.large_file then
            require("mini.trailspace").trim()
            require("mini.trailspace").trim_last_lines()
          end
        end,
        desc = "Trim trailing whitespace and blank lines",
      })

      -- ======================================================================
      -- mini.hipatterns - 高亮模式（备用，已注释）
      -- ======================================================================
      -- 提供文本高亮功能，如 TODO、FIXME、颜色代码等
      -- 由于我们使用 nvim-highlight-colors 处理颜色，这里仅用于其他模式
      --[[
      require("mini.hipatterns").setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      })
      ]]
    end,
  },

  -- ========================================================================
  -- nvim-ts-context-commentstring - 依赖插件
  -- ========================================================================
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
}
