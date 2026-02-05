-- ============================================================================
-- LSP 主入口
-- 基于 Neovim 原生 API 的 LSP 配置系统
-- ============================================================================

local M = {}

-- ============================================================================
-- 初始化 LSP 系统
-- ============================================================================

function M.setup()
  -- 加载全局处理器
  local handlers = require("lsp.handlers")
  handlers.setup()

  -- 获取全局能力
  local capabilities = handlers.capabilities()

  -- ========================================================================
  -- LSP 服务器列表
  -- ========================================================================
  local servers = {
    "ts_ls",        -- TypeScript/JavaScript
    "volar",        -- Vue 3
    "lua_ls",       -- Lua
    "clangd",       -- C/C++
    "marksman",     -- Markdown
    "html",         -- HTML
    "cssls",        -- CSS/SCSS/LESS
    "jsonls",       -- JSON
    "yamlls",       -- YAML
    "eslint",       -- ESLint
    "rust_analyzer",-- Rust
    "bashls",       -- Bash
  }

  -- ========================================================================
  -- 为每个服务器设置自动命令
  -- ========================================================================
  for _, server_name in ipairs(servers) do
    local ok, server_config = pcall(require, "lsp.servers." .. server_name)
    
    if ok then
      -- 合并服务器特定配置和全局配置
      local config = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = handlers.on_attach,
      }, server_config.config or {})

      -- 为每个文件类型创建自动命令
      if server_config.filetypes then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = server_config.filetypes,
          callback = function(args)
            -- 检查是否已经有相同的服务器在运行
            local clients = vim.lsp.get_clients({ bufnr = args.buf })
            for _, client in ipairs(clients) do
              if client.name == server_config.name then
                return -- 已经附加，不需要重复启动
              end
            end

            -- 启动 LSP 服务器
            vim.lsp.start(vim.tbl_deep_extend("force", config, {
              name = server_config.name,
              cmd = server_config.cmd,
              root_dir = vim.fs.dirname(
                vim.fs.find(server_config.root_patterns or { ".git" }, { upward = true })[1]
              ),
            }))
          end,
          desc = string.format("启动 %s LSP 服务器", server_config.name),
        })
      end
    else
      vim.notify(
        string.format("Failed to load LSP server config: %s", server_name),
        vim.log.levels.WARN
      )
    end
  end

  -- ========================================================================
  -- 用户命令
  -- ========================================================================
  
  -- 显示 LSP 信息
  vim.api.nvim_create_user_command("LspInfo", function()
    require("lsp.utils").show_lsp_info()
  end, { desc = "显示 LSP 信息" })

  -- 重启 LSP
  vim.api.nvim_create_user_command("LspRestart", function()
    vim.cmd("LspStop")
    vim.cmd("sleep 100m")
    vim.cmd("edit")
    vim.notify("LSP restarted", vim.log.levels.INFO)
  end, { desc = "重启 LSP" })

  -- 查看 LSP 日志
  vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd("edit " .. vim.lsp.get_log_path())
  end, { desc = "打开 LSP 日志" })

  -- 切换自动格式化
  vim.api.nvim_create_user_command("FormatToggle", function()
    require("lsp.utils").toggle_format_on_save()
  end, { desc = "切换自动格式化" })

  -- ========================================================================
  -- Conform 集成
  -- ========================================================================
  local has_conform_integration, conform_integration = pcall(require, "lsp.conform_integration")
  if has_conform_integration then
    conform_integration.setup()
  end
end

return M
