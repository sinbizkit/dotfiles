local lspconfig = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function default_lsp_attach_handler()
  require 'keymap'.map_lsp_keys()
end

local servers = { 'clangd', 'gopls', 'cmake', 'pyright', 'bashls', 'tsserver' }
local default_config = {
  capabilities = capabilities,
  on_attach = default_lsp_attach_handler,
}

-- An LSP config dictionary which should be extended with custom per-server settings.
local configs = {
  clangd = {
    on_attach = function()
      default_lsp_attach_handler()
      require 'keymap'.map('n', '<Leader>gs', '<Cmd>ClangdSwitchSourceHeader<CR>')
    end,
  },
}

if (vim.fn.has('mac')) then
  table.insert(servers, 'sourcekit')
  configs['sourcekit'] = { filetypes = { "swift", "objective-c", "objective-cpp" } }
end

-- Returns configuration for provided `server` if found, empty value otherwise.
local function config_or_default(server)
  local config = configs[server]
  if config == nil then
    return default_config
  end
  return vim.tbl_extend('force', default_config, config)
end

for _, server in ipairs(servers) do
  local config = config_or_default(server)
  lspconfig[server].setup(config)
end

