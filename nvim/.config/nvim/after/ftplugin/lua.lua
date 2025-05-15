local km = require "sinbizkit.keymap"
km.buf_map("n", "<Leader>x", ":.lua<CR>")
km.buf_map("v", "<Leader>x", ":lua<CR>")
