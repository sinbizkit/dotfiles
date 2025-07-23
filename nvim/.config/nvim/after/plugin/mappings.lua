-- Remap default "comment" mappings.
local km = require "sinbizkit.keymap"
km.map({"n", "x", "n"}, "<Leader>gc", "gc")
km.map("n", "<Leader>gcc", "gcc")
