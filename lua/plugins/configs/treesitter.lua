-- ============================================================================
-- nvim-treesitter - 语法高亮与代码解析配置
-- ============================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<C-space>", desc = "增量选择" },
    { "<bs>", desc = "减量选择", mode = "x" },
  },
  opts = {
    ensure_installed = {
      -- 前端
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "html",
      "css",
      "scss",
      "json",
      "jsonc",

      -- Lua
      "lua",
      "luadoc",
      "luap",

      -- C/C++
      "c",
      "cpp",

      -- Rust ✅ 新增
      "rust",
      "toml",  -- Cargo.toml

      -- Markdown
      "markdown",
      "markdown_inline",

      -- 其他
      "bash",
      "regex",
      "vim",
      "vimdoc",
      "yaml",
      "git_config",
      "gitcommit",
      "gitignore",
      "diff",
      "comment",
    },

    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },

    indent = {
      enable = true,
      disable = { "python", "yaml" },
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ["<leader>swa"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>swA"] = "@parameter.inner",
        },
      },
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- ===== 折叠配置 =====
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
  end,
}
