local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  priority = 200,
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
  },
}

function M.config()
  local cmp = require "cmp"

  local has_luasnip, luasnip = pcall(require, "luasnip")
  local lsp_expand
  if has_luasnip then
    lsp_expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  end

  cmp.setup {
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    snippet = {
      expand = lsp_expand,
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
    formatting = {
      format = function(entry, item)
        item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          path = "[Path]",
        })[entry.source.name]

        local content = item.abbr
        -- Predefined max content width.
        local fixed_max_width = 50
        -- Get the width of the current window.
        local win_width = vim.api.nvim_win_get_width(0)
        -- Set the max content width based percentage of the window width, in this case 35%.
        local max_content_width = math.min(fixed_max_width, math.floor(win_width * 0.35))
        -- Truncate the completion entry text if it's longer than the
        -- max content width. We subtract 3 from the max content width
        -- to account for the "..." that will be appended to it.
        if #content > max_content_width then
          item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
        else
          item.abbr = content .. (" "):rep(max_content_width - #content)
        end
        return item
      end,
    },
  }
end

return M
