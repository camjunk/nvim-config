-- ============================================================================
-- Conform.nvim 统一格式化系统
-- ============================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo", "Format", "FormatToggle" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
          timeout_ms = 1000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format file or range",
    },
  },
  config = function()
    local conform = require("conform")

    -- ========================================================================
    -- 格式化器配置
    -- ========================================================================
    conform.setup({
      formatters_by_ft = {
        -- JavaScript / TypeScript / Vue
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },

        -- Lua
        lua = { "stylua" },

        -- Rust
        rust = { "rustfmt" },

        -- C / C++
        c = { "clang_format" },
        cpp = { "clang_format" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Python
        python = { "isort", "black" },

        -- Go
        go = { "goimports", "gofmt" },
      },

      -- 格式化选项
      format_on_save = function(bufnr)
        -- 禁用特定文件类型的自动格式化
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end

        -- 如果全局禁用了自动格式化，则跳过
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return {
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,

      -- 格式化器配置
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" }, -- 2 spaces indent
        },
        prettier = {
          prepend_args = { "--tab-width", "2" },
        },
      },

      -- 通知设置
      notify_on_error = true,
    })

    -- ========================================================================
    -- 用户命令
    -- ========================================================================

    -- 手动格式化命令
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end

      conform.format({
        async = true,
        lsp_fallback = true,
        range = range,
        timeout_ms = 1000,
      }, function(err)
        if not err then
          vim.notify("Formatted successfully", vim.log.levels.INFO)
        else
          vim.notify("Format failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end)
    end, { range = true, desc = "Format file or range" })

    -- 切换自动格式化命令
    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        -- Toggle for current buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        if vim.b.disable_autoformat then
          vim.notify("Auto-format disabled for this buffer", vim.log.levels.INFO)
        else
          vim.notify("Auto-format enabled for this buffer", vim.log.levels.INFO)
        end
      else
        -- Toggle globally
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          vim.notify("Auto-format disabled globally", vim.log.levels.INFO)
        else
          vim.notify("Auto-format enabled globally", vim.log.levels.INFO)
        end
      end
    end, {
      desc = "Toggle auto-format on save (! for buffer-local)",
      bang = true,
    })
  end,
}
