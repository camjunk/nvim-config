-- ============================================================================
-- LuaSnip - 代码片段引擎配置
-- ============================================================================

return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")

    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "●", "GruvboxOrange" } },
          },
        },
      },
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    local custom_snippets_path = vim.fn.stdpath("config") .. "/snippets"
    if vim.fn.isdirectory(custom_snippets_path) == 1 then
      require("luasnip.loaders.from_lua").lazy_load({ paths = custom_snippets_path })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = custom_snippets_path })
    end

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "LuaSnip: 展开或跳转到下一个位置" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "LuaSnip: 跳转到上一个位置" })

    vim.keymap.set("i", "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "LuaSnip: 切换选择项" })
  end,
}
