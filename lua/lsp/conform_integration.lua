-- ============================================================================
-- Conform 与 LSP 集成补丁
-- 自动检测 Conform 格式化器，避免与 LSP 格式化冲突
-- ============================================================================

local M = {}

-- ============================================================================
-- 检查 Conform 是否为特定缓冲区配置了格式化器
-- ============================================================================

local function has_conform_formatter(bufnr)
  local ok, conform = pcall(require, "conform")
  if not ok then
    return false
  end

  local formatters = conform.list_formatters(bufnr)
  return formatters and #formatters > 0
end

-- ============================================================================
-- 禁用 LSP 格式化功能（如果 Conform 可用）
-- ============================================================================

local function disable_lsp_formatting(client, bufnr)
  -- 检查客户端是否支持格式化
  if client.supports_method("textDocument/formatting") then
    -- 检查是否有 Conform 格式化器
    if has_conform_formatter(bufnr) then
      -- 禁用 LSP 格式化
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      
      vim.notify(
        string.format("LSP formatting disabled for %s (using Conform)", client.name),
        vim.log.levels.DEBUG
      )
    end
  end
end

-- ============================================================================
-- 设置 Conform 集成
-- ============================================================================

function M.setup()
  -- 仅在 Conform 可用时设置
  local ok, _ = pcall(require, "conform")
  if not ok then
    return
  end

  -- 创建自动命令组
  local augroup = vim.api.nvim_create_augroup("ConformLspIntegration", { clear = true })

  -- 当 LSP 附加到缓冲区时，检查是否需要禁用 LSP 格式化
  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      
      if client then
        disable_lsp_formatting(client, bufnr)
      end
    end,
    desc = "Disable LSP formatting if Conform is available",
  })

  -- 当文件类型改变时，重新检查格式化器配置
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(args)
      local bufnr = args.buf
      
      -- 获取附加到此缓冲区的所有 LSP 客户端
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      
      for _, client in ipairs(clients) do
        disable_lsp_formatting(client, bufnr)
      end
    end,
    desc = "Check Conform formatters on FileType change",
  })
end

return M
