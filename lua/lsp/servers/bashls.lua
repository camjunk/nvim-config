-- ============================================================================
-- Bash LSP 配置
-- ============================================================================

return {
  name = "bashls",
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_patterns = { ".git" },
  
  config = {
    settings = {
      bashIde = {
        -- Shellcheck 集成
        shellcheckPath = "shellcheck",
        shellcheckArguments = {},
        
        -- 格式化
        formatter = "shfmt",
        
        -- 其他选项
        explainshellEndpoint = "",
        globPattern = "**/*@(.sh|.inc|.bash|.command)",
      },
    },
  },
}
