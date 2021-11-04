command! -nargs=? -complete=file Shipwright :lua require('shipwright').build(<f-args>)
