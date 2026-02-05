-- ============================================================================
-- Rust LSP 配置
-- ============================================================================

return {
  name = "rust_analyzer",
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_patterns = { "Cargo.toml", "rust-project.json", ".git" },
  
  config = {
    settings = {
      ["rust-analyzer"] = {
        -- 导入
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        
        -- Cargo
        cargo = {
          buildScripts = {
            enable = true,
          },
          allFeatures = true,
        },
        
        -- 过程宏
        procMacro = {
          enable = true,
        },
        
        -- 检查
        check = {
          command = "clippy", -- 使用 clippy
          extraArgs = { "--all-features" },
        },
        
        -- Inlay Hints
        inlayHints = {
          bindingModeHints = {
            enable = false,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          closureReturnTypeHints = {
            enable = "never",
          },
          lifetimeElisionHints = {
            enable = "never",
            useParameterNames = false,
          },
          maxLength = 25,
          parameterHints = {
            enable = true,
          },
          reborrowHints = {
            enable = "never",
          },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
      },
    },
  },
}
