-- ============================================================================
-- LSP 工具函数
-- 提供 LSP 相关的实用工具函数
-- ============================================================================

local M = {}

-- ============================================================================
-- 错误处理工具
-- ============================================================================

-- 安全调用函数
---@param fn function 要调用的函数
---@param ... any 函数参数
---@return boolean, any 成功状态和返回值
function M.safe_call(fn, ...)
  local ok, result = pcall(fn, ...)
  if not ok then
    vim.notify("LSP Error: " .. tostring(result), vim.log.levels.ERROR)
    return false, nil
  end
  return true, result
end

-- ============================================================================
-- 快捷键映射工具
-- ============================================================================

-- 设置 buffer 局部快捷键
---@param bufnr number Buffer 编号
---@param mode string|table 模式
---@param lhs string 快捷键
---@param rhs string|function 命令或函数
---@param opts table? 可选配置
function M.buf_keymap(bufnr, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = bufnr
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- 批量设置快捷键
---@param bufnr number Buffer 编号
---@param mappings table 快捷键配置列表
function M.buf_keymaps(bufnr, mappings)
  for _, mapping in ipairs(mappings) do
    local mode = mapping[1]
    local lhs = mapping[2]
    local rhs = mapping[3]
    local opts = mapping[4] or {}
    M.buf_keymap(bufnr, mode, lhs, rhs, opts)
  end
end

-- ============================================================================
-- LSP 客户端检查
-- ============================================================================

-- 检查 buffer 是否有活动的 LSP 客户端
---@param bufnr number Buffer 编号
---@return boolean 是否有活动客户端
function M.has_active_clients(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  return #clients > 0
end

-- 获取 buffer 的所有 LSP 客户端
---@param bufnr number Buffer 编号
---@return table LSP 客户端列表
function M.get_clients(bufnr)
  return vim.lsp.get_clients({ bufnr = bufnr })
end

-- ============================================================================
-- 格式化工具
-- ============================================================================

-- 格式化当前 buffer
---@param bufnr number Buffer 编号
function M.format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  
  -- 检查是否有支持格式化的 LSP
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local has_formatter = false
  
  for _, client in ipairs(clients) do
    if client.server_capabilities.documentFormattingProvider then
      has_formatter = true
      break
    end
  end
  
  if not has_formatter then
    vim.notify("No LSP formatter available", vim.log.levels.WARN)
    return
  end
  
  -- 执行格式化
  vim.lsp.buf.format({
    bufnr = bufnr,
    timeout_ms = 5000,
  })
end

-- ============================================================================
-- 自动格式化管理
-- ============================================================================

-- 全局自动格式化状态
M.format_on_save = true

-- 切换自动格式化
function M.toggle_format_on_save()
  M.format_on_save = not M.format_on_save
  local status = M.format_on_save and "enabled" or "disabled"
  vim.notify("Format on save " .. status, vim.log.levels.INFO)
end

-- 设置自动格式化
---@param bufnr number Buffer 编号
function M.setup_format_on_save(bufnr)
  local group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })
  
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = bufnr,
    callback = function()
      if M.format_on_save then
        M.format(bufnr)
      end
    end,
    desc = "LSP: Format on save",
  })
end

-- ============================================================================
-- Inlay Hints 工具
-- ============================================================================

-- 切换 Inlay Hints
---@param bufnr number? Buffer 编号
function M.toggle_inlay_hints(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  
  -- 检查 Neovim 版本
  if not vim.lsp.inlay_hint then
    vim.notify("Inlay hints not supported in this Neovim version", vim.log.levels.WARN)
    return
  end
  
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  
  local status = not enabled and "enabled" or "disabled"
  vim.notify("Inlay hints " .. status, vim.log.levels.INFO)
end

-- ============================================================================
-- 诊断工具
-- ============================================================================

-- 跳转到下一个诊断
function M.goto_next_diagnostic()
  vim.diagnostic.goto_next({ float = true })
end

-- 跳转到上一个诊断
function M.goto_prev_diagnostic()
  vim.diagnostic.goto_prev({ float = true })
end

-- ============================================================================
-- 文档符号高亮
-- ============================================================================

-- 设置文档符号高亮
---@param client table LSP 客户端
---@param bufnr number Buffer 编号
function M.setup_document_highlight(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end
  
  local group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
  
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.document_highlight()
    end,
    desc = "LSP: Document highlight",
  })
  
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.clear_references()
    end,
    desc = "LSP: Clear document highlight",
  })
end

-- ============================================================================
-- LSP 信息显示
-- ============================================================================

-- 显示 LSP 信息
function M.show_lsp_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  
  if #clients == 0 then
    vim.notify("No LSP clients attached", vim.log.levels.INFO)
    return
  end
  
  local info = {}
  table.insert(info, "Active LSP Clients:")
  table.insert(info, "")
  
  for _, client in ipairs(clients) do
    table.insert(info, string.format("• %s (ID: %d)", client.name, client.id))
    
    if client.server_capabilities then
      local caps = {}
      if client.server_capabilities.documentFormattingProvider then
        table.insert(caps, "formatting")
      end
      if client.server_capabilities.completionProvider then
        table.insert(caps, "completion")
      end
      if client.server_capabilities.hoverProvider then
        table.insert(caps, "hover")
      end
      if client.server_capabilities.definitionProvider then
        table.insert(caps, "definition")
      end
      
      if #caps > 0 then
        table.insert(info, string.format("  Capabilities: %s", table.concat(caps, ", ")))
      end
    end
    
    table.insert(info, "")
  end
  
  vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
end

return M
