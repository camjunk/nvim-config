-- ============================================================================
-- LSP 全局处理器配置
-- 配置 LSP 的 UI 和行为
-- ============================================================================

local M = {}

-- ============================================================================
-- 诊断符号
-- ============================================================================

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

-- ============================================================================
-- 初始化处理器
-- ============================================================================

function M.setup()
  -- 设置诊断符号
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- ========================================================================
  -- 诊断配置
  -- ========================================================================
  vim.diagnostic.config({
    -- 虚拟文本
    virtual_text = {
      spacing = 4,
      prefix = "●",
      severity = vim.diagnostic.severity.ERROR, -- 只显示错误
    },
    
    -- 符号列
    signs = true,
    
    -- 下划线
    underline = true,
    
    -- 更新时机
    update_in_insert = false,
    
    -- 严重程度排序
    severity_sort = true,
    
    -- 浮动窗口
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      format = function(diagnostic)
        return string.format("[%s] %s", diagnostic.source or "LSP", diagnostic.message)
      end,
    },
  })

  -- ========================================================================
  -- 悬停文档处理器
  -- ========================================================================
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    focusable = true,
    max_width = 80,
  })

  -- ========================================================================
  -- 签名帮助处理器
  -- ========================================================================
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    focusable = false,
    close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
  })
end

-- ============================================================================
-- LSP 客户端附加时的设置
-- ============================================================================

---@param client table LSP 客户端
---@param bufnr number Buffer 编号
function M.on_attach(client, bufnr)
  local utils = require("lsp.utils")

  -- ========================================================================
  -- 快捷键映射
  -- ========================================================================
  utils.buf_keymaps(bufnr, {
    -- 跳转
    { "n", "gd", vim.lsp.buf.definition, { desc = "LSP: 跳转到定义" } },
    { "n", "gD", vim.lsp.buf.declaration, { desc = "LSP: 跳转到声明" } },
    { "n", "gr", vim.lsp.buf.references, { desc = "LSP: 查找引用" } },
    { "n", "gi", vim.lsp.buf.implementation, { desc = "LSP: 跳转到实现" } },
    { "n", "gt", vim.lsp.buf.type_definition, { desc = "LSP: 跳转到类型定义" } },

    -- 文档
    { "n", "K", vim.lsp.buf.hover, { desc = "LSP: 显示悬停文档" } },
    { "n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: 显示签名帮助" } },
    { "i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: 显示签名帮助" } },

    -- 编辑
    { "n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: 重命名" } },
    { "n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: 代码操作" } },
    { "v", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: 代码操作" } },

    -- 格式化
    {
      "n",
      "<leader>f",
      function()
        utils.format(bufnr)
      end,
      { desc = "LSP: 格式化" },
    },
    {
      "v",
      "<leader>f",
      function()
        utils.format(bufnr)
      end,
      { desc = "LSP: 格式化选区" },
    },

    -- 诊断
    { "n", "[d", utils.goto_prev_diagnostic, { desc = "LSP: 上一个诊断" } },
    { "n", "]d", utils.goto_next_diagnostic, { desc = "LSP: 下一个诊断" } },
    { "n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: 显示诊断" } },
    { "n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: 诊断列表" } },

    -- Inlay Hints
    {
      "n",
      "<leader>th",
      function()
        utils.toggle_inlay_hints(bufnr)
      end,
      { desc = "LSP: 切换 Inlay Hints" },
    },
  })

  -- ========================================================================
  -- 设置文档符号高亮
  -- ========================================================================
  utils.setup_document_highlight(client, bufnr)

  -- ========================================================================
  -- 设置自动格式化
  -- ========================================================================
  if client.server_capabilities.documentFormattingProvider then
    utils.setup_format_on_save(bufnr)
  end

  -- ========================================================================
  -- 启用 Inlay Hints（如果支持）
  -- ========================================================================
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- ========================================================================
  -- 日志
  -- ========================================================================
  vim.notify(
    string.format("LSP: %s attached to buffer %d", client.name, bufnr),
    vim.log.levels.DEBUG
  )
end

-- ============================================================================
-- LSP 客户端能力配置
-- ============================================================================

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- ========================================================================
  -- 补全能力（适配 blink.cmp）
  -- ========================================================================
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  -- ========================================================================
  -- 折叠能力
  -- ========================================================================
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

return M
