-- ============================================================================
-- 自动命令配置
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ============================================================================
-- 通用自动命令组
-- ============================================================================

local general = augroup("General", { clear = true })

-- 保存时自动删除行尾空格
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace on save",
})

-- 高亮复制的文本
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- 打开文件时恢复光标位置
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})

-- 自动创建目录（保存文件时）
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto create dir when saving file",
})

-- ============================================================================
-- 窗口管理
-- ============================================================================

local windows = augroup("Windows", { clear = true })

-- 自动调整窗口大小
autocmd("VimResized", {
  group = windows,
  pattern = "*",
  command = "wincmd =",
  desc = "Automatically resize windows",
})

-- 关闭某些文件类型时自动关闭窗口
autocmd("FileType", {
  group = windows,
  pattern = { "qf", "help", "man", "lspinfo", "null-ls-info" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q",
})

-- ============================================================================
-- 文件类型特定设置
-- ============================================================================

local filetype = augroup("FileType", { clear = true })

-- Lua 文件缩进
autocmd("FileType", {
  group = filetype,
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "Lua indentation",
})

-- JavaScript/TypeScript 缩进
autocmd("FileType", {
  group = filetype,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "JS/TS indentation",
})

-- HTML/CSS 缩进
autocmd("FileType", {
  group = filetype,
  pattern = { "html", "css", "scss", "vue" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "HTML/CSS indentation",
})

-- Markdown 设置
autocmd("FileType", {
  group = filetype,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us,cjk"
  end,
  desc = "Markdown settings",
})

-- Git commit 消息设置
autocmd("FileType", {
  group = filetype,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
  desc = "Git commit settings",
})

-- ============================================================================
-- LSP 相关
-- ============================================================================

local lsp = augroup("LSP", { clear = true })

-- 格式化相关的自动命令将在 LSP 配置完成后添加

-- ============================================================================
-- 性能优化
-- ============================================================================

local performance = augroup("Performance", { clear = true })

-- 大文件优化
autocmd("BufReadPre", {
  group = performance,
  pattern = "*",
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 1024 * 1024 then -- 1MB
      vim.b.large_file = true
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.cmd("syntax off")
      vim.cmd("IlluminatePauseBuf") -- 如果使用 vim-illuminate
    end
  end,
  desc = "Disable certain features for large files",
})
