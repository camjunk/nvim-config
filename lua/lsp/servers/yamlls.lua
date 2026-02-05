-- ============================================================================
-- YAML LSP 配置
-- ============================================================================

return {
  name = "yamlls",
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_patterns = { ".git" },
  
  config = {
    settings = {
      yaml = {
        schemas = require("schemastore").yaml.schemas(),
        validate = true,
        hover = true,
        completion = true,
        format = {
          enable = true,
        },
        schemaStore = {
          enable = false, -- 使用 schemastore.nvim
          url = "",
        },
      },
    },
    
    -- 如果 schemastore 不可用，使用基础配置
    on_new_config = function(config)
      local ok = pcall(require, "schemastore")
      if not ok then
        config.settings.yaml.schemas = {}
        config.settings.yaml.schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        }
      end
    end,
  },
}
