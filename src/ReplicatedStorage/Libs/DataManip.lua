local DataManip = {};

--[[
  Creates a new folder, names it, and nests it.
]]
function DataManip.createDataFolder(name, parent)
  local DataFolder = Instance.new("Folder");
  DataFolder.Name = name;
  DataFolder.Parent = parent;
  return DataFolder;
end

--[[
  Creates a small data node and places it in the correct place.
]]
function DataManip.createDataNode(name, instance, parent)
    instance.Name = name;
    instance.Parent = parent;
    return instance;
end

return DataManip;