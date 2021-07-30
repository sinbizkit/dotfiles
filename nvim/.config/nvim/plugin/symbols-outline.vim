lua << EOF
vim.g.symbols_outline = {
  auto_preview = false,
  position = 'left'
  }
EOF

nnoremap <silent><F7> :SymbolsOutline<CR>
