# 🚀 Neovim 一体化开发环境配置

> 基于 Neovim 0.11 构建的现代化多语言开发环境，支持前端（TS/JS/React/Vue）、Lua、C、Markdown

## ✨ 特性

- 🎨 **8 个主流主题**：一键切换 gruvbox、nord、catppuccin 等
- ⚡ **性能优化**：启动时间 < 50ms
- 🔧 **原生 LSP**：无 nvim-lspconfig，完全基于 Neovim 0.11 原生 API
- 🎯 **snacks.nvim + mini.nvim**：轻量高效的插件生态
- 🤖 **AI 集成**：GitHub Copilot + CodeCompanion
- 📝 **Markdown 增强**：渲染美化 + AI 辅助

## 📂 项目结构

```
nvim/
├── init.lua                    # 主入口
├── lua/
│   ├── config/
│   │   ├── options.lua         # 基础选项
│   │   ├── keymaps.lua         # 快捷键映射
│   │   ├── autocmds.lua        # 自动命令
│   │   └── theme_switcher.lua  # 主题切换器
│   └── plugins/
│       ├── init.lua            # lazy.nvim 插件声明
│       └── configs/            # 插件配置目录（后续阶段添加）
└── README.md
```

## 🚀 快速开始

### 前置要求

- Neovim >= 0.11.0
- Git
- Node.js >= 18（前端 LSP）
- GCC/Clang（C LSP）
- ripgrep（全局搜索）
- fd（文件查找）

### 安装

```bash
# 1. 备份现有配置
mv ~/.config/nvim ~/.config/nvim.backup

# 2. 克隆此仓库
git clone https://github.com/camjunk/nvim-config.git ~/.config/nvim

# 3. 启动 Neovim（自动安装插件）
nvim
```

### 首次启动

1. Lazy.nvim 会自动安装所有插件
2. 等待安装完成
3. 执行 `:checkhealth` 检查环境

## ⌨️ 核心快捷键

### 基础操作

| 快捷键       | 功能         | 模式   |
| ------------ | ------------ | ------ |
| `<Space>`    | Leader 键    | -      |
| `jk`         | 退出插入模式 | Insert |
| `<leader>w`  | 保存文件     | Normal |
| `<leader>qq` | 关闭窗口     | Normal |

### 文件管理

| 快捷键       | 功能                 |
| ------------ | -------------------- |
| `<leader>e`  | 切换文件树（snacks） |
| `-`          | Oil.nvim 编辑目录    |
| `<leader>ff` | 查找文件             |
| `<leader>fg` | 全局搜索             |
| `<leader>fb` | 查找 Buffer          |

### Git 操作

| 快捷键       | 功能            |
| ------------ | --------------- |
| `<leader>gg` | 打开 LazyGit    |
| `<leader>gd` | Git diff 覆盖层 |
| `<leader>gb` | Git blame       |

### 主题切换

| 快捷键       | 功能       |
| ------------ | ---------- |
| `<leader>tn` | 下一个主题 |
| `<leader>tp` | 上一个主题 |
| `<leader>ts` | 选择主题   |

### LSP 快捷键

| 快捷键       | 功能       |
| ------------ | ---------- |
| `gd`         | 跳转到定义 |
| `gr`         | 查找引用   |
| `K`          | 悬停文档   |
| `<leader>rn` | 重命名     |
| `<leader>ca` | 代码操作   |

### AI 助手

| 快捷键       | 功能         |
| ------------ | ------------ |
| `<leader>aa` | 打开 AI 对话 |
| `<leader>at` | 切换 AI 建议 |

完整快捷键列表见：[keymaps.lua](lua/config/keymaps.lua)

## 🎨 支持的主题

1. **gruvbox** - 复古温暖配色
2. **nord** - 极地冷色调
3. **onedark** - Atom 风格
4. **catppuccin** - 柔和马卡龙
5. **tokyonight** - 东京夜景
6. **dracula** - 吸血鬼风格
7. **github_dark** - GitHub 暗色
8. **everforest** - 森林绿

## 📚 插件列表

### 核心插件

- **lazy.nvim** - 插件管理器
- **snacks.nvim** - 搜索/文件树/终端/Dashboard
- **mini.nvim** - 编辑增强套件
- **nvim-treesitter** - 语法高亮
- **blink.cmp** - 补全引擎
- **copilot.lua** - GitHub Copilot
- **oil.nvim** - 文件系统编辑
- **flash.nvim** - 快速跳转

详细插件配置见：[Issue #1](https://github.com/camjunk/nvim-config/issues/1)

## 🔧 自定义配置

### 修改缩进

编辑 `lua/config/options.lua`:

```lua
opt.tabstop = 2       -- 改为 2 空格
opt.shiftwidth = 2
```

### 添加快捷键

编辑 `lua/config/keymaps.lua`:

```lua
map("n", "<leader>custom", ":YourCommand<CR>", { desc = "Custom command" })
```

### 更换主题

使用快捷键 `<leader>ts` 或编辑 `lua/config/theme_switcher.lua`

## 🤝 贡献

e迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

