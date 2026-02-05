-- ============================================================================
-- Vue 3 LSP 配置
-- ============================================================================

return {
  name = "volar",
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_patterns = { "package.json", "vue.config.js", ".git" },
  
  config = {
    init_options = {
      typescript = {
        -- 自动检测 TypeScript SDK
        tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
      },
      vue = {
        hybridMode = false, -- 禁用混合模式（使用单一 Volar 实例）
      },
    },
    
    settings = {
      vue = {
        -- 代码格式化
        format = {
          enable = true,
        },
        -- 自动补全
        autoInsert = {
          dotValue = true,
          bracketSpacing = true,
        },
      },
    },
  },
}
