vim.api.nvim_command('compiler tsc')
vim.opt_local.colorcolumn = '200'
vim.opt_local.commentstring = '// %s'

---@class TSConfig
---@field compilerOptions CompilerOptions

---@class CompilerOptions
---@field outDir string
---@field rootDir string

---Finds the path to the 'tsconfig.json' upwards
---@param path string The path to start searching from
---@return string|nil
local function getTSConfig(path)
  local matches = vim.fs.find('tsconfig.json', { upward = true, path })

  return matches[1] or nil
end

---Reads the tsconfig and json decodes it
---@param  path string The path to the tsconfig
---@return CompilerOptions|nil The config options
local function readTSConfig(path)
  local file = io.open(path, 'r')
  if (not file) then return nil end

  local contents = file:read('*a')
  file:close()

  local status, obj = pcall(vim.json.decode, contents)

  if (status) then
    ---@type TSConfig
    local config = obj

    if (not config or not config.compilerOptions or not config.compilerOptions.rootDir or not config.compilerOptions.outDir) then
      return nil
    end

    ---@type CompilerOptions
    local compilerOptions = { outDir = config.compilerOptions.outDir, rootDir = config.compilerOptions.rootDir }
    return compilerOptions
  end

  return nil
end

--- Convert a source file path to its output path
---@param filepath string Full path to the source file
---@param config CompilerOptions The compiler options from tsconfig
---@return string|nil
local function convert_to_out_path(filepath, config)
  local i = filepath:find(config.rootDir, 1, true)
  if not i then return nil end

  local newpath = filepath:sub(1, i - 1) .. config.outDir .. filepath:sub(i + #config.rootDir)
  return newpath:sub(1, #newpath - 2) .. 'js'
end

-- Switching between comppiled javascript and typescript source
if (not vim.g.did_tsjs_switch) then
  vim.g.did_tsjs_switch = true

  ---@param newwin boolean
  local function ts_js_switch(newwin)
    local buf = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(buf)

    local path = getTSConfig(vim.fs.dirname(bufname))
    if (not path) then
      vim.notify('Could not find \'tsconfig.json\'', vim.log.levels.ERROR)
      return
    end

    local config = readTSConfig(path);
    if (not config) then
      vim.notify('Could not read \'outDir\' and/or \'rootDir\' from \'tsconfig.json\'', vim.log.levels.ERROR)
      return
    end

    local jsPath = convert_to_out_path(bufname, config)
    if (not jsPath) then
      vim.notify('Could not convert path from rootDir to outDir', vim.log.levels.ERROR)
      return
    end

    if (newwin) then
      vim.api.nvim_command('edit' .. vim.fn.fnameescape(jsPath))
    else
      vim.api.nvim_command('split' .. vim.fn.fnameescape(jsPath))
    end
  end

  vim.keymap.set('n', [[<localleader>s]], function() ts_js_switch(false) end, { noremap = true, buffer = true })
  vim.keymap.set('n', [[<localleader>S]], function() ts_js_switch(true) end, { noremap = true, buffer = true })
end
