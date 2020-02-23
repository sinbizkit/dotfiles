let &colorcolumn="80,".join(range(121, 999),",")
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4

let b:ale_fixers = ['autopep8', 'black']
