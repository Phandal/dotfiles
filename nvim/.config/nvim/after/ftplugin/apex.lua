-- Apex filetype plugin file
-- Language: Apex
-- Maintainer: Phandal
-- Last Change: 2024 Jun 10

if (vim.b.did_ftplugin) then
  return
end

vim.b.did_ftplugin = 1

vim.bo.shiftwidth = 4

vim.bo.commentstring = '// %s'

-- vim: sw=2 sts=2 et
