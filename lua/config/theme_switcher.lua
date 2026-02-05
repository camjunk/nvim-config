-- ============================================================================
-- 主题切换器
-- ============================================================================

local M = {}

-- 支持的主题列表（按照 Issue #1 规范）
M.themes = {
  { name = "gruvbox",      plugin = "ellisonleao/gruvbox.nvim" },
  { name = "nord",         plugin = "shaunsingh/nord.nvim" },
  { name = "onedark",      plugin = "navarasu/onedark.nvim" },
  { name = "catppuccin",   plugin = "catppuccin/nvim" },
  { name = "tokyonight",   plugin = "folke/tokyonight.nvim" },
  { name = "dracula",      plugin = "Mofiqul/dracula.nvim" },
  { name = "github_dark",  plugin = "projekt0n/github-nvim-theme" },
  { name = "everforest",   plugin = "neanias/everforest-nvim" },
}

-- 当前主题索引（持久化存储）
M.current_index = 1

-- 主题配置文件路径
local config_path = vim.fn.stdpath("data") .. "/theme_config.json"

-- ============================================================================
-- 辅助函数
-- ============================================================================

-- 保存当前主题配置
local function save_theme()
  local file = io.open(config_path, "w")
  if file then
    file:write(vim.json.encode({ current_index = M.current_index }))
    file:close()
  end
end

-- 加载保存的主题配置
local function load_theme()
  local file = io.open(config_path, "r")
  if file then
    local content = file:read("*all")
    file:close()
    local ok, data = pcall(vim.json.decode, content)
    if ok and data.current_index then
      M.current_index = data.current_index
    end
  end
end

-- 应用主题
local function apply_theme(theme_name)
  local ok, err = pcall(function()
    -- 特殊处理某些主题的设置
    if theme_name == "catppuccin" then
      vim.cmd.colorscheme("catppuccin-mocha")
    elseif theme_name == "github_dark" then
      vim.cmd.colorscheme("github_dark_high_contrast")
    elseif theme_name == "tokyonight" then
      vim.cmd.colorscheme("tokyonight-night")
    else
      vim.cmd.colorscheme(theme_name)
    end
  end)

  if not ok then
    vim.notify(
      "Failed to load theme: " .. theme_name .. "\nError: " .. tostring(err),
      vim.log.levels.ERROR,
      { title = "Theme Switcher" }
    )
    return false
  end

  vim.notify(
    "Theme changed to: " .. theme_name,
    vim.log.levels.INFO,
    { title = "Theme Switcher" }
  )
  return true
end

-- ============================================================================
-- 公开接口
-- ============================================================================

-- 初始化主题（在启动时调用）
function M.setup()
  -- 加载保存的主题配置
  load_theme()

  -- 应用保存的主题
  local theme = M.themes[M.current_index]
  if theme then
    apply_theme(theme.name)
  end
end

-- 切换到下一个主题
function M.next_theme()
  M.current_index = M.current_index + 1
  if M.current_index > #M.themes then
    M.current_index = 1
  end

  local theme = M.themes[M.current_index]
  if apply_theme(theme.name) then
    save_theme()
  end
end

-- 切换到上一个主题
function M.prev_theme()
  M.current_index = M.current_index - 1
  if M.current_index < 1 then
    M.current_index = #M.themes
  end

  local theme = M.themes[M.current_index]
  if apply_theme(theme.name) then
    save_theme()
  end
end

-- 选择主题（通过菜单）
function M.select_theme()
  -- 创建主题列表
  local theme_list = {}
  for i, theme in ipairs(M.themes) do
    local prefix = (i == M.current_index) and "* " or "  "
    table.insert(theme_list, prefix .. theme.name)
  end

  -- 使用 vim.ui.select 显示选择菜单
  vim.ui.select(theme_list, {
    prompt = "Select a theme:",
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if idx then
      M.current_index = idx
      local theme = M.themes[idx]
      if apply_theme(theme.name) then
        save_theme()
      end
    end
  end)
end

-- 获取当前主题名称
function M.get_current_theme()
  return M.themes[M.current_index].name
end

-- ============================================================================
-- 自动初始化
-- ============================================================================

-- 延迟初始化以确保插件已加载
vim.defer_fn(function()
  M.setup()
end, 100)

return M
