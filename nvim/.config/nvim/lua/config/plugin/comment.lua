local has_comment, comment = pcall(require, "Comment")
if not has_comment then
  return
end

comment.setup {
  toggler = {
    ---Line-comment toggle keymap
    line = "<Leader>cc",
    ---Block-comment toggle keymap
    block = "<Leader>bc",
  },
  opleader = {
    ---Line-comment keymap
    line = "<Leader>c",
    ---Block-comment keymap
    block = "<Leader>b",
  },
}
