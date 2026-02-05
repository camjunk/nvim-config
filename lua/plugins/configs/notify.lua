-- ============================================================================
-- nvim-notify - 美化通知系统配置
-- ============================================================================

return {
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 1000,
  opts = {
    -- 显示位置
    stages = "fade_in_slide_out",
    
    -- 通知位置（右上角）
    top_down = true,
    
    -- 超时时间
    timeout = 3000,
    
    -- 最大宽度
    max_width = 50,
    
    -- 最大高度
    max_height = 10,
    
    -- 背景透明度
    background_colour = "#000000",
    
    -- 渲染样式
    render = "default",
    
    -- 最小宽度
    minimum_width = 30,
    
    -- 图标
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
    
    -- 时间格式
    time_formats = {
      notification = "%T",
      notification_history = "%FT%T",
    },
  },
  
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    
    -- 设置为全局通知处理器
    vim.notify = notify
    
    -- 创建用户命令
    vim.api.nvim_create_user_command("NotifyHistory", function()
      require("telescope").extensions.notify.notify()
    end, { desc = "显示通知历史" })
    
    vim.api.nvim_create_user_command("NotifyDismiss", function()
      notify.dismiss({ silent = true, pending = true })
    end, { desc = "关闭所有通知" })
  end,
}
