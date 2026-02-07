-- ============================================================================
-- nvim-lint - Linting 工具配置
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Linter 配置
    lint.linters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },

      -- Markdown
      markdown = { "markdownlint" },

      -- Bash
      sh = { "shellcheck" },
      bash = { "shellcheck" },

      -- Python
      python = { "pylint" },

      -- YAML
      yaml = { "yamllint" },

      -- Docker
      dockerfile = { "hadolint" },
    }

    -- ✅ 修复：不要在这里修改 linter 配置
    -- eslint_d 会自动处理 stdin 文件名

    -- 创建自动命令组
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- 自动触发 lint（带错误处理）
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- 只在有 linter 的文件类型中运行
        if lint.linters_by_ft[vim.bo.filetype] then
          -- 添加错误处理
          local ok, err = pcall(lint.try_lint)
          if not ok then
            -- 静默失败，不打扰用户
            vim.notify(
              string.format("Lint 失败: %s", err),
              vim.log.levels.DEBUG,  -- ✅ 改为 DEBUG 级别
              { title = "nvim-lint" }
            )
          end
        end
      end,
    })

    -- 创建命令
    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, { desc = "手动运行 Linter" })

    vim.api.nvim_create_user_command("LintInfo", function()
      local filetype = vim.bo.filetype
      local linters = lint.linters_by_ft[filetype] or {}
      if #linters == 0 then
        vim.notify(string.format("没有为文件类型 '%s' 配置 linter", filetype), vim.log.levels.INFO)
      else
        vim.notify(
          string.format("文件类型 '%s' 的 linters: %s", filetype, table.concat(linters, ", ")),
          vim.log.levels.INFO
        )
      end
    end, { desc = "显示当前文件的 Linter 信息" })
  end,
}
