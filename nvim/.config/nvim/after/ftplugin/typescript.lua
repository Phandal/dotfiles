vim.cmd("compiler tsc")
vim.opt_local.colorcolumn = "200"
vim.opt_local.commentstring = "// %s"

-- compiler! tsc
-- setlocal colorcolumn=200
-- setlocal commentstring=//\ %s
--
--
--
--
-- " switching between interfaces (.mli) and implementations (.ml)
-- if !exists("g:did_ocaml_switch")
--   let g:did_ocaml_switch = 1
--   nnoremap <Plug>OCamlSwitchEdit :<C-u>call OCaml_switch(0)<CR>
--   nnoremap <Plug>OCamlSwitchNewWin :<C-u>call OCaml_switch(1)<CR>
--   fun OCaml_switch(newwin)
--     if (match(bufname(""), "\\.mli$") >= 0)
--       let fname = s:Fnameescape(substitute(bufname(""), "\\.mli$", ".ml", ""))
--       if (a:newwin == 1)
--         exec "new " . fname
--       else
--         exec "arge " . fname
--       endif
--     elseif (match(bufname(""), "\\.ml$") >= 0)
--       let fname = s:Fnameescape(bufname("")) . "i"
--       if (a:newwin == 1)
--         exec "new " . fname
--       else
--         exec "arge " . fname
--       endif
--     endif
--   endfun
-- endif
