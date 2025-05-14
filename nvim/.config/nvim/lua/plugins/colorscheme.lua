local M = {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
}

-- Default options:
M.opts = {
  compile = false, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    palette = {
      dragonBlack6 = "#44413e",
    },
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {
      ["@lsp.type.comment"] = { link = "@comment" },
    }
  end,
}

M.config = function(_, opts)
  local kanagawa = require "kanagawa"
  kanagawa.setup(opts)
  kanagawa.load "dragon"
end

return M
