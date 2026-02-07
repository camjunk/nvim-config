-- ============================================================================
-- nvim-highlight-colors 颜色可视化配置
-- 实时预览颜色值（HEX、RGB、HSL、Named colors、Tailwind）
-- ============================================================================

return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- ========================================================================
    -- 渲染模式
    -- ========================================================================
    render = "background", -- 'background' | 'foreground' | 'virtual'
    -- background: 用颜色填充背景
    -- foreground: 改变文本颜色
    -- virtual: 在虚拟文本中显示颜色块

    -- ========================================================================
    -- 虚拟文本配置
    -- ========================================================================
    virtual_symbol = "■",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    virtual_symbol_position = "inline", -- 'inline' | 'eol' | 'eow'

    -- ========================================================================
    -- 启用的颜色格式
    -- ========================================================================
    -- enable_named_colors = true,
    -- enable_tailwind = true,

       -- ========================================================================
    -- 自定义颜色模式
    -- ========================================================================
    custom_colors = {
      { label = "%-%-theme%-primary%-color", color = "#0f1219" },
      { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
    },

    -- ========================================================================
    -- 排除的文件类型
    -- ========================================================================
    exclude_filetypes = {},
    exclude_buftypes = {},
  },
--   require("nvim-highlight-colors").setup({
--   -- 核心：添加 blink.cmp 补全窗口的文件类型/窗口匹配
--   enable_named_colors = true, -- 渲染命名颜色（如 red/blue）
--   enable_tailwind = true, -- 兼容 Tailwind 颜色
--   -- 覆盖 blink.cmp 的补全弹窗窗口
--   custom_highlights = {
--     -- 匹配 blink.cmp 补全菜单的高亮组
--     BlinkCmpMenu = { fg = "none", bg = "none" },
--     BlinkCmpMenuSelection = { fg = "none", bg = "none" },
--   },
--   -- 强制高亮 blink.cmp 的补全窗口缓冲区
--   filetypes = {
--     "css", "scss", "less", "vue", "html", "javascript", "typescript",
--     -- 新增 blink.cmp 补全窗口的虚拟缓冲区类型
--     "blink-cmp",
--   },
--   -- 手动指定需要高亮的窗口（blink.cmp 补全窗口的 winhighlight 包含 BlinkCmpMenu）
--   winhighlight = { "BlinkCmpMenu", "BlinkCmpMenuSelection" },
-- })
--
-- -- 额外：自动触发 blink.cmp 补全窗口的颜色高亮
-- vim.api.nvim_create_autocmd("WinEnter", {
--   pattern = "*",
--   callback = function()
--     local winhl = vim.api.nvim_get_option_value("winhighlight", { win = 0 })
--     if winhl:find("BlinkCmpMenu") then
--       require("nvim-highlight-colors").turnOn()
--     end
--   end,
-- })
}
