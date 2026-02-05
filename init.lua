-- ============================================================================
-- Neovim 配置主入口文件
-- 基于 Neovim 0.11+ 构建的现代化开发环境
-- ============================================================================

-- 设置 Leader 键为空格（必须在加载插件之前设置）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 加载核心配置模块
require("config.options")    -- 基础选项配置
require("config.keymaps")    -- 快捷键映射
require("config.autocmds")   -- 自动命令

-- 初始化 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件配置
require("plugins")
