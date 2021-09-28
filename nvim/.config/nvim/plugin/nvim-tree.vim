lua << EOF
require'nvim-tree'.setup {
  auto_close = true,
  view = {
    width = 40
  }
}
EOF

nnoremap <silent><F6> :NvimTreeToggle<CR>
nnoremap <silent><Leader><F6> :NvimTreeFindFile<CR>
