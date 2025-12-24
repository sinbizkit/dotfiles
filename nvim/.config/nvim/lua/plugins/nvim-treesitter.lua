local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

M.opts = {
  ensure_installed = {
    "c",
    "cpp",
    "query",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "rust",
    "go",
    "lua",
    "python",
    "sql",
    "cmake",
    "bash",
    "javascript",
    "json",
  },
}

function M.config(_, opts)
  local ts = require "nvim-treesitter"
  ts.install(opts.ensure_installed)

  vim.api.nvim_create_autocmd("FileType", {
    desc = "enable nvim-treesitter features",
    group = vim.api.nvim_create_augroup("sb-treesitter-filetype", { clear = true }),
    callback = function(args)
      -- Search for an installed parser compatible with the buffer.
      local bufnr = args.buf
      local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
      if not ok or not parser then
        return
      end
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start()
      -- folds, provided by Neovim
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  })
end

return M
