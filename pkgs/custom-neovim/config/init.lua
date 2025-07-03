fennel = require "fennel"
configdir = debug.getinfo(1).source:sub(2, string.len('/init.lua'))

do
  local fnldir = (configdir .. "/fnl")
  for _, dir in ipairs({"/?.fnl", "/?/init.fnl"}) do
    fennel["path"] = (fnldir .. dir .. ";" .. fennel.path)
    fennel["macro-path"] = (fnldir .. dir .. ";" .. fennel["macro-path"])
  end
end

fennel.install()
