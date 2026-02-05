-- ============================================================================
-- Lazy.nvim 插件配置
-- 基于 Issue #1 的分阶段实施计划
-- ============================================================================

-- lazy.nvim 配置选项
local lazy_config = {
  -- 性能优化
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- UI 配置
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  -- 检测配置文件更改时自动重载
  change_detection = {
    enabled = true,
    notify = true,
  },
}

-- ============================================================================
-- 插件列表（第一阶段：基础架构）
-- ============================================================================

local plugins = {
  -- ========================================================================
  -- 主题插件（8 个主题）
  -- ========================================================================
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })
    end,
  },

  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    lazy = true,
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = true,
    config = function()
      require("onedark").setup({
        style = "dark",
      })
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "night",
      })
    end,
  },

  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    lazy = true,
  },

  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    lazy = true,
  },

  {
    "neanias/everforest-nvim",
    priority = 1000,
    lazy = true,
    config = function()
      require("everforest").setup({
        background = "hard",
      })
    end,
  },

  -- ========================================================================
  -- 基础依赖
  -- ========================================================================
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ========================================================================
  -- 阶段 2：核心插件配置
  -- ========================================================================
  require("plugins.configs.snacks"),     -- snacks.nvim 多功能工具集
  require("plugins.configs.mini"),       -- mini.nvim 编辑增强套件
  require("plugins.configs.oil"),        -- Oil.nvim 文件系统编辑器
  require("plugins.configs.flash"),      -- Flash.nvim 快速跳转
  require("plugins.configs.colors"),     -- nvim-highlight-colors 颜色可视化
  require("plugins.configs.ui"),         -- lualine + bufferline UI 组件

  -- ========================================================================
  -- 阶段 3：补全与 AI 系统
  -- ========================================================================
  require("plugins.configs.completion"),    -- blink.cmp 现代化补全引擎
  require("plugins.configs.copilot"),       -- GitHub Copilot AI 补全
  require("plugins.configs.snippets"),      -- LuaSnip 代码片段引擎
  require("plugins.configs.treesitter"),    -- Treesitter 语法高亮与解析
  require("plugins.configs.codecompanion"), -- CodeCompanion AI 助手
}

-- ============================================================================
-- 初始化 Lazy.nvim
-- ============================================================================

require("lazy").setup(plugins, lazy_config)

-- ============================================================================
-- 注释说明：后续阶段将添加的插件
-- ============================================================================

--[[
阶段 4（原生 LSP 配置）将添加：
- nvim-lspconfig（LSP 配置）
- mason.nvim（LSP 管理器）
- conform.nvim（格式化）
- nvim-lint（代码检查）

阶段 5（Markdown + LazyGit）将添加：
- render-markdown.nvim（Markdown 渲染）
- gitsigns.nvim（Git 集成）
- lazygit.nvim（LazyGit 集成）

阶段 6：最终优化与测试
]]
