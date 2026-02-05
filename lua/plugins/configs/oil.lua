-- ============================================================================
-- Oil.nvim 文件系统编辑器配置
-- 像编辑文本一样编辑目录结构
-- ============================================================================

return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- ========================================================================
    -- 基础配置
    -- ========================================================================
    default_file_explorer = true,
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },

    -- ========================================================================
    -- 删除文件行为
    -- ========================================================================
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,

    -- ========================================================================
    -- 清理函数
    -- ========================================================================
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },

    -- ========================================================================
    -- 限制
    -- ========================================================================
    constrain_cursor = "editable",
    watch_for_changes = false,
    experimental_watch_for_changes = false,

    -- ========================================================================
    -- 按键映射
    -- ========================================================================
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",

      -- ✅ 完美 Vim 操作的 hjkl 导航
      ["h"] = "actions.parent",         -- h = 返回上一级目录
      ["l"] = "actions.select",         -- l = 进入目录 / 打开文件
      -- j/k 使用默认行为（上下移动）

      -- ✅ 文件管理操作
      ["a"] = "actions.create",         -- a = 新建文件/目录
      ["dd"] = "actions.delete",        -- dd = 删除文件/目录
      ["r"] = "actions.rename",         -- r = 重命名
      ["yy"] = "actions.copy_entry_path", -- yy = 复制文件名
      ["yp"] = "actions.copy_entry_path", -- yp = 复制完整路径
    },

    -- ========================================================================
    -- 使用 {{{marker}}} 标记折叠
    -- ========================================================================
    use_default_keymaps = false,

    -- ========================================================================
    -- 视图选项
    -- ========================================================================
    view_options = {
      show_hidden = false,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = true,
      case_insensitive = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },

    -- ========================================================================
    -- 浮动窗口选项
    -- ========================================================================
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      override = function(conf)
        return conf
      end,
    },

    -- ========================================================================
    -- 预览窗口选项
    -- ========================================================================
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      update_on_cursor_moved = true,
    },

    -- ========================================================================
    -- 进度窗口选项
    -- ========================================================================
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },

    -- ========================================================================
    -- SSH 配置
    -- ========================================================================
    ssh = {
      border = "rounded",
    },

    -- ========================================================================
    -- 文件类型配置
    -- ========================================================================
    keymaps_help = {
      border = "rounded",
    },
  },

  -- ========================================================================
  -- 快捷键配置
  -- ========================================================================
  keys = {
    -- 在当前目录打开 Oil
    {
      "-",
      "<cmd>Oil<cr>",
      desc = "Open parent directory",
    },
    -- 主文件树快捷键
    {
      "<leader>e",
      "<cmd>Oil<cr>",
      desc = "Open file explorer",
    },
    -- 在浮动窗口打开 Oil
    {
      "<leader>E",
      function()
        require("oil").toggle_float()
      end,
      desc = "Open file explorer (float)",
    },
  },
}
