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
  -- 核心插件（第一阶段仅包含必要的基础插件）
  -- ========================================================================

  -- 注意：更多插件（snacks.nvim、mini.nvim、treesitter 等）
  -- 将在后续阶段（阶段 2-4）中添加
  --
  -- 第一阶段重点：
  -- 1. 建立项目结构
  -- 2. 配置主题系统
  -- 3. 设置基础选项和快捷键
  -- 4. 确保配置可以正常加载
}

-- ============================================================================
-- 初始化 Lazy.nvim
-- ============================================================================

require("lazy").setup(plugins, lazy_config)

-- ============================================================================
-- 注释说明：后续阶段将添加的插件
-- ============================================================================

--[[
阶段 2（编辑器增强）将添加：
- snacks.nvim（搜索、文件树、终端、Dashboard）
- mini.nvim 套件（ai, comment, surround, pairs, indent-scope）
- oil.nvim（文件系统编辑器）
- flash.nvim（快速跳转）

阶段 3（LSP 和补全）将添加：
- blink.cmp（补全引擎）
- nvim-treesitter（语法高亮）
- conform.nvim（格式化）
- nvim-lint（代码检查）
- lazydev.nvim（Lua LSP）

阶段 4（Git 和 AI）将添加：
- gitsigns.nvim（Git 集成）
- lazygit.nvim（LazyGit 集成）
- diffview.nvim（Git diff 视图）
- copilot.lua（GitHub Copilot）
- codecompanion.nvim（AI 助手）

阶段 5（Markdown）将添加：
- render-markdown.nvim（Markdown 渲染）
- markdown.nvim（Markdown 增强）
]]
