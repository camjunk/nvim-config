-- ============================================================================
-- Lua LSP 配置（专为 Neovim 优化）
-- ============================================================================

return {
  name = "lua_ls",
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_patterns = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  
  config = {
    settings = {
      Lua = {
        -- 运行时
        runtime = {
          version = "LuaJIT",
        },
        
        -- 诊断
        diagnostics = {
          globals = { "vim" }, -- 识别 vim 全局变量
          disable = { "missing-fields" },
        },
        
        -- 工作区
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library",
          },
          checkThirdParty = false, -- 不检查第三方库
        },
        
        -- 补全
        completion = {
          callSnippet = "Replace",
        },
        
        -- 遥测
        telemetry = {
          enable = false,
        },
        
        -- 格式化
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
        
        -- Hint
        hint = {
          enable = true,
          setType = true,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  },
}
