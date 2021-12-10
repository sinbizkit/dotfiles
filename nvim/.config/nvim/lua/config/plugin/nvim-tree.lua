require 'nvim-tree'.setup {
  auto_close = true,
  view = {
    width = 30,
    height = 30,
    side = 'left',
    auto_resize = true,
    number = true,
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  git = {
    enable = true,
    ignore = false,
  },
}

