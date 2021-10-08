lua << EOF
local lspconfig = require'lspconfig'

local OS = {
  WIN = 1,
  LINUX = 2,
  MACOS = 3,
}

-- Detect OS.
local system
local system_name

if vim.fn.has("mac") == 1 then
  system = OS.MACOS
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system = OS.LINUX
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system = OS.WIN
  system_name = "Windows"
end

-- LSP Servers.
lspconfig.clangd.setup{ filetypes = { "c", "cpp" } }
lspconfig.rust_analyzer.setup{}
lspconfig.gopls.setup{}
lspconfig.cmake.setup{}
lspconfig.pylsp.setup{}

if (system == OS.MACOS) then
  lspconfig.sourcekit.setup{ filetypes = { "swift", "objective-c", "objective-cpp" } }
end

-- -- Lua.
local sumneko_lua_path = os.getenv('SUMNEKO_LUA_PATH')
if sumneko_lua_path then
  if system_name then
    local sumneko_binary_fpath = sumneko_lua_path .. '/bin/' .. system_name .. '/lua-language-server'
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconfig.sumneko_lua.setup {
      cmd = {sumneko_binary_fpath, '-E', sumneko_lua_path .. "/main.lua"},
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end
end
EOF

" s - show.
nnoremap <silent><leader>sh :lua vim.lsp.buf.hover()<CR>
nnoremap <silent><leader>si :lua vim.lsp.buf.signature_help()<CR>

" g - go.
nnoremap <silent><leader>ge :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><leader>gn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent><leader>gp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>gs :ClangdSwitchSourceHeader<Cr>

" d - do
nnoremap <silent><leader>di :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>dr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent><leader>df :lua vim.lsp.buf.formatting()<CR>
vnoremap <silent><leader>df :lua vim.lsp.buf.range_formatting()<CR>

sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=  texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=💡 texthl=LspDiagnosticsSignHint linehl= numhl=

lua << EOF
require('cmp').setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' }
  }
}
EOF
