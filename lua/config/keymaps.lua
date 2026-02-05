-- ============================================================================
-- 快捷键映射配置
-- ============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- 基础操作
-- ============================================================================

-- 退出插入模式
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- 保存和退出
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })

-- 全选
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- 取消高亮
map("n", "<Esc>", ":noh<CR>", opts)

-- ============================================================================
-- 窗口管理
-- ============================================================================

-- 分割窗口
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
map("n", "<leader>sc", ":close<CR>", { desc = "Close window" })

-- 窗口导航
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- 调整窗口大小
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ============================================================================
-- Buffer 管理
-- ============================================================================

-- Buffer 导航
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- ============================================================================
-- 编辑增强
-- ============================================================================

-- 移动选中行
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- 保持粘贴寄存器
map("v", "p", '"_dP', opts)

-- 连续缩进
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- 更好的向上/向下移动
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- 行首行尾快速移动
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)

-- 快速插入空行
map("n", "[<space>", "O<Esc>j", { desc = "Insert line above" })
map("n", "]<space>", "o<Esc>k", { desc = "Insert line below" })

-- ============================================================================
-- 文件操作（预留位置，由插件实现）
-- ============================================================================

-- 文件浏览器（将由 snacks.nvim 或 oil.nvim 实现）
map("n", "<leader>e", ":echo 'File explorer not configured yet'<CR>", { desc = "Toggle file explorer" })
map("n", "-", ":echo 'Oil.nvim not configured yet'<CR>", { desc = "Open parent directory" })

-- 文件查找（将由 snacks.nvim 实现）
map("n", "<leader>ff", ":echo 'File finder not configured yet'<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":echo 'Grep not configured yet'<CR>", { desc = "Live grep" })
map("n", "<leader>fb", ":echo 'Buffer finder not configured yet'<CR>", { desc = "Find buffers" })
map("n", "<leader>fr", ":echo 'Recent files not configured yet'<CR>", { desc = "Recent files" })

-- ============================================================================
-- Git 操作（预留位置，由插件实现）
-- ============================================================================

map("n", "<leader>gg", ":echo 'LazyGit not configured yet'<CR>", { desc = "LazyGit" })
map("n", "<leader>gd", ":echo 'Git diff not configured yet'<CR>", { desc = "Git diff" })
map("n", "<leader>gb", ":echo 'Git blame not configured yet'<CR>", { desc = "Git blame" })

-- ============================================================================
-- LSP 操作（预留位置，将在 LSP 配置时设置）
-- ============================================================================

map("n", "gd", ":echo 'LSP not configured yet'<CR>", { desc = "Go to definition" })
map("n", "gr", ":echo 'LSP not configured yet'<CR>", { desc = "References" })
map("n", "K", ":echo 'LSP not configured yet'<CR>", { desc = "Hover" })
map("n", "<leader>rn", ":echo 'LSP not configured yet'<CR>", { desc = "Rename" })
map("n", "<leader>ca", ":echo 'LSP not configured yet'<CR>", { desc = "Code action" })

-- ============================================================================
-- AI 助手（预留位置，由 Copilot/CodeCompanion 实现）
-- ============================================================================

map("n", "<leader>aa", ":echo 'AI assistant not configured yet'<CR>", { desc = "AI chat" })
map("n", "<leader>at", ":echo 'AI toggle not configured yet'<CR>", { desc = "Toggle AI suggestions" })

-- ============================================================================
-- 主题切换
-- ============================================================================

map("n", "<leader>tn", ":lua require('config.theme_switcher').next_theme()<CR>", { desc = "Next theme" })
map("n", "<leader>tp", ":lua require('config.theme_switcher').prev_theme()<CR>", { desc = "Previous theme" })
map("n", "<leader>ts", ":lua require('config.theme_switcher').select_theme()<CR>", { desc = "Select theme" })

-- ============================================================================
-- 诊断和调试
-- ============================================================================

-- Trouble plugin (will be added in later phases)
map("n", "<leader>xx", ":echo 'Trouble plugin not configured yet'<CR>", { desc = "Toggle Trouble" })
map("n", "<leader>xd", ":echo 'Trouble plugin not configured yet'<CR>", { desc = "Document diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- ============================================================================
-- 终端
-- ============================================================================

-- 终端模式快捷键
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- 打开终端（将由 snacks.nvim 实现）
map("n", "<leader>tt", ":echo 'Terminal not configured yet'<CR>", { desc = "Toggle terminal" })
