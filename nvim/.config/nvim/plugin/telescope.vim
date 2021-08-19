lua << EOF
  require("telescope").setup ({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        }
      }
    }
  })
EOF

nnoremap <silent><leader>t :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent><leader>r :lua require('telescope.builtin').tags()<CR>
nnoremap <silent><leader>b :lua require('telescope.builtin').buffers()<CR>

nnoremap <silent><leader>gr :lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent><leader>gd :lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <silent><leader>gi :lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent><leader>gg :lua require('telescope.builtin').live_grep()<CR>

nnoremap <silent><leader>so :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent><leader>ss :lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>
