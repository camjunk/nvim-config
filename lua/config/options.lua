-- ============================================================================
-- Neovim 基础选项配置
-- ============================================================================

local opt = vim.opt

-- ============================================================================
-- 通用设置
-- ============================================================================

-- 启用真彩色支持
opt.termguicolors = true

-- 设置文件编码
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- 启用鼠标支持
opt.mouse = "a"

-- 剪贴板设置（与系统剪贴板同步）
opt.clipboard = "unnamedplus"

-- 禁用交换文件和备份文件
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Undo 持久化
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ============================================================================
-- 界面显示
-- ============================================================================

-- 显示行号
opt.number = true
opt.relativenumber = true

-- 高亮当前行
opt.cursorline = true

-- 显示标尺列
opt.colorcolumn = "80,120"

-- 左侧标记列宽度
opt.signcolumn = "yes"

-- 命令行高度
opt.cmdheight = 1

-- 显示不可见字符
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}

-- 始终显示状态栏
opt.laststatus = 3  -- 全局状态栏

-- 更好的补全体验
opt.completeopt = "menu,menuone,noselect"

-- 弹出菜单高度
opt.pumheight = 10

-- 分割窗口方向
opt.splitright = true
opt.splitbelow = true

-- 折叠设置
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false  -- 默认不折叠

-- ============================================================================
-- 编辑行为
-- ============================================================================

-- 缩进设置
opt.tabstop = 4         -- Tab 宽度
opt.shiftwidth = 4      -- 自动缩进宽度
opt.expandtab = true    -- 使用空格替代 Tab
opt.smartindent = true  -- 智能缩进
opt.autoindent = true   -- 自动缩进

-- 搜索设置
opt.ignorecase = true   -- 搜索忽略大小写
opt.smartcase = true    -- 智能大小写（有大写字母时区分）
opt.hlsearch = true     -- 高亮搜索结果
opt.incsearch = true    -- 增量搜索

-- 行为设置
opt.wrap = false        -- 不自动换行
opt.scrolloff = 8       -- 垂直滚动时保持 8 行边距
opt.sidescrolloff = 8   -- 水平滚动时保持 8 列边距

-- 自动换行在单词边界
opt.linebreak = true

-- 更快的更新时间（用于 CursorHold 等事件）
opt.updatetime = 300

-- 超时设置
opt.timeoutlen = 500

-- 隐藏模式行
opt.showmode = false

-- 允许隐藏未保存的缓冲区
opt.hidden = true

-- ============================================================================
-- 性能优化
-- ============================================================================

-- 减少重绘
opt.lazyredraw = true

-- 更快的宏执行
opt.regexpengine = 1

-- ============================================================================
-- 特定文件类型设置
-- ============================================================================

-- 确保文件类型检测、插件和缩进启用
vim.cmd([[
  filetype plugin indent on
  syntax enable
]])
