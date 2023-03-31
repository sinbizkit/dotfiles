local M = {
  "neovim/nvim-lspconfig",
  dependencies = { "ray-x/lsp_signature.nvim" },
}

function M.config()
  local lspconfig = require "lspconfig"

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  local function default_lsp_attach_handler(_, bufnr)
    require("lsp_signature").on_attach({}, bufnr)
    require("sinbizkit.lsp.mappings").map_buf()
  end

  local servers = { "clangd", "gopls", "cmake", "pyright", "bashls", "tsserver", "lua_ls" }
  local default_config = {
    capabilities = capabilities,
    on_attach = default_lsp_attach_handler,
  }

  -- An LSP config dictionary which should be extended with custom per-server settings.
  local configs = {
    clangd = {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--header-insertion-decorators=false",
        "--completion-style=detailed",
      },
      on_attach = function(client, bufnr)
        default_lsp_attach_handler(client, bufnr)
        require("sinbizkit.keymap").map("n", "<Leader>gs", "<Cmd>ClangdSwitchSourceHeader<CR>")
      end,
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = function(client)
        default_lsp_attach_handler()
        -- formatting provided by stylua.
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
      end,
    },
  }

  -- Returns configuration for provided `server` if found, empty value otherwise.
  local function config_or_default(server)
    local config = configs[server]
    if config == nil then
      return default_config
    end
    return vim.tbl_extend("force", default_config, config)
  end

  for _, server in ipairs(servers) do
    local config = config_or_default(server)
    lspconfig[server].setup(config)
  end
end

return M
