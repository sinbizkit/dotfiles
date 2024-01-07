local M = {
  "neovim/nvim-lspconfig",
}

local km = require "sinbizkit.keymap"

function M.config()
  local lspconfig = require "lspconfig"

  -- An LSP config dictionary which need be extended with server settings.
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
      on_attach = function()
        km.map("n", "<Leader>gs", "<Cmd>ClangdSwitchSourceHeader<CR>")
      end,
    },
    gopls = {
      settings = {
        gopls = {
          semanticTokens = true,
          usePlaceholders = true,
        },
      },
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
          format = {
            -- turn-off in case if stylua is found.
            enable = vim.fn.executable "stylua" == 0,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    },
    cmake = {},
    pyright = {},
    bashls = {},
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities()
  end

  for name, config in pairs(configs) do
    config.capabilities = capabilities
    lspconfig[name].setup(config)
  end
end

return M
