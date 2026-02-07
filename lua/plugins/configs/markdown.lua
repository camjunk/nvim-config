-- ============================================================================
-- Markdown 完整增强配置
-- ============================================================================

return {
  -- ========================================================================
  -- 1. render-markdown.nvim - 实时渲染 Markdown
  -- ========================================================================
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup({
        -- 代码块配置
        code = {
          enabled = true,
          sign = true,
          style = "full",
          position = "left",
          language_pad = 0,
          disable_background = { "diff" },
          width = "full",
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = "thin",
          above = "▄",
          below = "▀",
          highlight = "RenderMarkdownCode",
          highlight_inline = "RenderMarkdownCodeInline",
        },
        -- 标题配置
        heading = {
          enabled = true,
          sign = true,
          position = "overlay",
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          signs = { "󰫎 " },
          width = "full",
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = false,
          above = "▄",
          below = "▀",
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3",
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
        },
        -- 段落配置
        paragraph = {
          enabled = true,
          left_margin = 0,
          min_width = 0,
        },
        -- Checkbox 配置
        checkbox = {
          enabled = true,
          position = "inline",
          unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            icon = "󰱒 ",
            highlight = "RenderMarkdownChecked",
          },
          custom = {
            todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
          },
        },
        -- 引用块配置
        quote = {
          enabled = true,
          icon = "▋",
          repeat_linebreak = false,
          highlight = "RenderMarkdownQuote",
        },
        -- 表格配置
        pipe_table = {
          enabled = true,
          preset = "round",
          style = "full",
          cell = "padded",
          alignment_indicator = "━",
          border = {
            "┌", "┬", "┐",
            "├", "┼", "┤",
            "└", "┴", "┘",
            "│", "─",
          },
          head = "RenderMarkdownTableHead",
          row = "RenderMarkdownTableRow",
          filler = "RenderMarkdownTableFill",
        },
        -- Callout 配置
        callout = {
          note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
          tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
          important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
          warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
          caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
          abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
          summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
          tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
          info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
          todo = { raw = "[!TODO]", rendered = "󰥔 Todo", highlight = "RenderMarkdownInfo" },
          hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
          success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
          check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
          done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
          question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
          help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
          faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
          attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
          failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
          fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
          missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
          danger = { raw = "[!DANGER]", rendered = "󰳦 Danger", highlight = "RenderMarkdownError" },
          error = { raw = "[!ERROR]", rendered = "󰅖 Error", highlight = "RenderMarkdownError" },
          bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
          example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
          quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
          cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
        },
        -- 链接配置
        link = {
          enabled = true,
          image = "󰥶 ",
          email = "󰀓 ",
          hyperlink = "󰖟 ",
          highlight = "RenderMarkdownLink",
          custom = {
            web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
          },
        },
        -- 符号配置
        sign = {
          enabled = true,
          highlight = "RenderMarkdownSign",
        },
        -- 行内代码配置
        inline_code = {
          enabled = true,
          highlight = "RenderMarkdownCodeInline",
        },
        -- Dash 配置
        dash = {
          enabled = true,
          icon = "─",
          width = "full",
          highlight = "RenderMarkdownDash",
        },
        -- Bullet 配置
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
          left_pad = 0,
          right_pad = 0,
          highlight = "RenderMarkdownBullet",
        },
        -- LaTeX 配置
        latex = {
          enabled = true,
          converter = "latex2text",
          highlight = "RenderMarkdownMath",
          top_pad = 0,
          bottom_pad = 0,
        },
        -- 高亮配置
        win_options = {
          conceallevel = {
            default = vim.api.nvim_get_option_value("conceallevel", {}),
            rendered = 3,
          },
          concealcursor = {
            default = vim.api.nvim_get_option_value("concealcursor", {}),
            rendered = "",
          },
        },
      })
    end,
  },

  -- ========================================================================
  -- 2. markdown-preview.nvim - 浏览器预览
  -- ========================================================================
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "「${name}」"
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark"

      -- 快捷键设置
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })
    end,
  },

  -- ========================================================================
  -- 3. headlines.nvim - 标题美化
  -- ========================================================================
--   {
--     "lukas-reineke/headlines.nvim",
--     ft = { "markdown" },
--     dependencies = "nvim-treesitter/nvim-treesitter",
--     opts = {
--       markdown = {
--         query = vim.treesitter.query.parse(
--           "markdown",
--           [[
--             (atx_heading [
--                 (atx_h1_marker)
--                 (atx_h2_marker)
--                 (atx_h3_marker)
--                 (atx_h4_marker)
--                 (atx_h5_marker)
--                 (atx_h6_marker)
--             ] @headline)
--
--             (thematic_break) @dash
--
--             (fenced_code_block) @codeblock
--
--             (block_quote_marker) @quote
--             (block_quote (paragraph (inline (block_continuation) @quote)))
--             (block_quote (paragraph (block_continuation) @quote))
--             (block_quote (block_continuation) @quote)
--           ]]
--         ),
--         headline_highlights = {
--           "Headline1",
--           "Headline2",
--           "Headline3",
--           "Headline4",
--           "Headline5",
--           "Headline6",
--         },
--         bullet_highlights = {
--           "@text.title.1.marker.markdown",
--           "@text.title.2.marker.markdown",
--           "@text.title.3.marker.markdown",
--           "@text.title.4.marker.markdown",
--           "@text.title.5.marker.markdown",
--           "@text.title.6.marker.markdown",
--         },
--         bullets = { "◉", "○", "✸", "✿" },
--         codeblock_highlight = "CodeBlock",
--         dash_highlight = "Dash",
--         dash_string = "-",
--         quote_highlight = "Quote",
--         quote_string = "┃",
--         fat_headlines = true,
--         fat_headline_upper_string = "▃",
--         fat_headline_lower_string = "🬂",
--       },
--     },
--   },
}
