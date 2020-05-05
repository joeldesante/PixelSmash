local BuildingBuilder = {}
local __buildingObject = {}
__buildingObject.d = Vector3.new(5,15,10)
__buildingObject.p = Vector3.new(0,0,0)
__buildingObject.__index = __buildingObject

local function newBuilding()
  local b = {}
  setmetatable(b, __buildingObject);
  return b;
end

function BuildingBuilder.Generate(size, pos)
  local build = newBuilding();
  build.d = size
  build.p = pos

  for x = 1, size.x, 1 do
    for z = 1, size.z, 1 do
      for y = 1, size.y, 1 do
        local part = Instance.new("Part");
        part.Size = Vector3.new(2,2,2);
        part.Position = Vector3.new(pos.x + x, pos.y + y, pos.z + z);
        part.Parent = workspace;
      end
    end
  end
end

return BuildingBuilder;