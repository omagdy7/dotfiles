vim.cmd [[
try
  colorscheme material
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=background
endtry
]]
