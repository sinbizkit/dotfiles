lua << EOF
vim.g.symbols_outline = {
  auto_preview = false,
  position = 'right'
  }
EOF

nnoremap <silent><F7> :SymbolsOutline<CR>
