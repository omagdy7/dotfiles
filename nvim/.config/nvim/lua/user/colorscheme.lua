vim.cmd [[
try
  colorscheme onedark 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=background
endtry
]]
