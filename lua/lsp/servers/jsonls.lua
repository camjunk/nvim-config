-- ============================================================================
-- JSON LSP 配置
-- ============================================================================

return {
  name = "jsonls",
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_patterns = { "package.json", ".git" },
  
  config = {
    init_options = {
      provideFormatter = true,
    },
    
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
        format = {
          enable = true,
        },
      },
    },
    
    -- 如果 schemastore 不可用，使用基础配置
    on_new_config = function(config)
      local ok = pcall(require, "schemastore")
      if not ok then
        config.settings.json.schemas = {}
      end
    end,
  },
}
