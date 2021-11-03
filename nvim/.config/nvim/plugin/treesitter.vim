lua << EOF
local modules = { "cpp", "rust", "go", "lua", "python", "cmake", "javascript" }
if vim.fn.has("mac") == 1 then
  table.insert(modules, "swift")
end
require 'nvim-treesitter.configs'.setup {
    -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
    ensure_installed = modules,
    highlight = { -- enable highlighting for all file types
      enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    },
}
EOF
