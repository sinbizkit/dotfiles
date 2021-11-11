local lspconfig = require 'lspconfig'

-- LSP Servers.
lspconfig.clangd.setup{ filetypes = { "c", "cpp" } }
lspconfig.rust_analyzer.setup{}
lspconfig.gopls.setup{}
lspconfig.cmake.setup{}
lspconfig.pylsp.setup{}
lspconfig.tsserver.setup{}

if (vim.fn.has('mac')) then
  lspconfig.sourcekit.setup{ filetypes = { "swift", "objective-c", "objective-cpp" } }
end


