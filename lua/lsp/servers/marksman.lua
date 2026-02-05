-- ============================================================================
-- Markdown LSP 配置
-- ============================================================================

return {
  name = "marksman",
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_patterns = { ".marksman.toml", ".git" },
  
  config = {
    settings = {},
  },
}
