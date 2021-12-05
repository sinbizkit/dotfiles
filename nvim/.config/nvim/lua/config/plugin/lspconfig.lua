local lspconfig = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- LSP Servers.
lspconfig.clangd.setup{ capabilities = capabilities }
lspconfig.gopls.setup{}
lspconfig.cmake.setup{}
lspconfig.pylsp.setup{}
lspconfig.bashls.setup{}
lspconfig.tsserver.setup{}

if (vim.fn.has('mac')) then
  lspconfig.sourcekit.setup{ filetypes = { "swift", "objective-c", "objective-cpp" } }
end

