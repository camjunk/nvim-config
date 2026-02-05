-- ============================================================================
-- nvim-lint 统一 Linting 系统
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- ========================================================================
    -- Linter 配置
    -- ========================================================================
    lint.linters_by_ft = {
      -- JavaScript / TypeScript / Vue
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },

      -- Markdown
      markdown = { "markdownlint" },

      -- Shell
      sh = { "shellcheck" },
      bash = { "shellcheck" },

      -- Python
      python = { "pylint" },

      -- YAML
      yaml = { "yamllint" },

      -- Dockerfile
      dockerfile = { "hadolint" },
    }

    -- ========================================================================
    -- 自动触发 Linting
    -- ========================================================================

    -- 创建自动命令组
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- 定义触发 Linting 的函数（带错误处理）
    local function try_lint()
      local ok, err = pcall(function()
        lint.try_lint()
      end)
      
      if not ok then
        -- 静默处理错误，避免干扰用户
        vim.schedule(function()
          vim.notify(
            string.format("Linting error: %s", tostring(err)),
            vim.log.levels.DEBUG
          )
        end)
      end
    end

    -- 在以下事件触发 Linting
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        try_lint()
      end,
      desc = "Trigger linting",
    })

    -- ========================================================================
    -- 用户命令
    -- ========================================================================

    -- 手动运行 Linter
    vim.api.nvim_create_user_command("Lint", function()
      local ok, err = pcall(function()
        lint.try_lint()
      end)
      
      if ok then
        vim.notify("Linting completed", vim.log.levels.INFO)
      else
        vim.notify(
          string.format("Linting failed: %s", tostring(err)),
          vim.log.levels.ERROR
        )
      end
    end, { desc = "Trigger linting for current file" })

    -- 显示 Linter 信息
    vim.api.nvim_create_user_command("LintInfo", function()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft] or {}
      
      if #linters == 0 then
        vim.notify(
          string.format("No linters configured for filetype: %s", ft),
          vim.log.levels.INFO
        )
      else
        vim.notify(
          string.format("Linters for %s: %s", ft, table.concat(linters, ", ")),
          vim.log.levels.INFO
        )
      end
    end, { desc = "Show linter info for current filetype" })
  end,
}
