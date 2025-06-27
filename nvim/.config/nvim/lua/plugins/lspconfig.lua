local M = {
  "neovim/nvim-lspconfig",
  dependecies = { "saghen/blink.cmp" },
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
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = false,
            compositeLiteralTypes = false,
            functionTypeParameters = true,
            parameterNames = true,
            constantValues = true,
            rangeVariableTypes = true,
          },
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
          hint = {
            enable = true,
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
  local has_blink_cmp, blink_cmp = pcall(require, "blink.cmp")
  if has_blink_cmp then
    capabilities = blink_cmp.get_lsp_capabilities(capabilities)
  end

  for name, config in pairs(configs) do
    config.capabilities = capabilities
    lspconfig[name].setup(config)
  end
end

return M
