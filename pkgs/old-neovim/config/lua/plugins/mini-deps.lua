if (mnw ~= nil) then
  require("mini.deps").setup()
end
AddPlugin = function(plugin)
  if (mnw ~= nil) then
    MiniDeps.add(plugin)
  end
end
