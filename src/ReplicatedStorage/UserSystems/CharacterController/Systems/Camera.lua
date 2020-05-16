local Players = game:GetService("Players");
local Camera = {};
local camera_mt = { __index = Camera };

function Camera.new(player)
  self = Camera;
  
  Camera.player = player;
  Camera.currentCamera = workspace.CurrentCamera;
  Camera.distance = 100;
  Camera.height = 50;
  Camera.rotationSpeed = 10;      -- Degrees per second
  Camera.isRotationMode = false;
  Camera.maxRotationOffset = 8;   -- In degrees
  Camera.maxPartTransparency = 0.8;
  Camera.target = nil;

  -- Private variables
  Camera.__rotationOffset = 0;

  return setmetatable(self, camera_mt)
end

--[[
  Responsible for calculating the CFrame of the position which the Camera
  should appear.

  Returns CFrame a new CFrame for the camera.
]]
function Camera:calculateCameraPosition()
  --if self.target == nil then return CFrame.new(0,0,0); end
  print(1)
  local ISOMETRIC_OFFSET = self.distance / math.sqrt(2);  
  local TARGET_POSITION = self.target.Position;
  
  local initialCFrame = CFrame.new(TARGET_POSITION);
  local initialRotatedCFrame = initialCFrame * CFrame.Angles(0, math.rad(self.__rotationOffset), 0);
  local offsetCFrame = initialRotatedCFrame:ToWorldSpace(CFrame.new(ISOMETRIC_OFFSET, self.height, ISOMETRIC_OFFSET));
  local rotatedCFrame = CFrame.new(offsetCFrame.p, TARGET_POSITION);

  return rotatedCFrame;
end

--[[
  Vanishes any part between the camera and the player.    
]]
function Camera:clearViewToPlayer(delta)

  --[[
    Returns a table of parts that exist upon a given Ray
  ]]
  local function findObstructingPartsAlongRay(ray)
      local targets = {}
      repeat
        local target = workspace:FindPartOnRayWithIgnoreList(ray, targets);
        if target then
          local isPlayer = Players:GetPlayerFromCharacter(target.Parent); -- See if the part is part of a player
          if isPlayer ~= nil then break end
          table.insert(targets, target);
        end
      until not target;
      return targets;
  end

  --[[
    Adjusts the transparency of a given set of parts based on a set of paremeters.

    The two qualifications to be made transparent are existing within the "vanishables"
    folder and existing in the given parts list.
  ]]
  local function adjustTrasparency(parts)

    local vanishable = workspace.PlayzoneParts.Vanishable:GetChildren();

    for _,part in pairs(vanishable) do
      if part:IsA("BasePart") then
        if table.find(parts, part) ~= nil then
          part.Transparency = math.clamp(part.Transparency + delta*1.5, 0, self.maxPartTransparency);
        else
          part.Transparency = math.clamp(part.Transparency - delta*(1/2), 0, self.maxPartTransparency);
        end
      end
    end
  end

  if self.target == nil then return end
  local RAY_OFFSET = Vector3.new(0,3,0);
  local MAX_RAY_DISTANCE = 1000;
  local targetPosition = self.target.Position;
  local cameraCFrame = self.currentCamera.CFrame.p;
  local ray = Ray.new(cameraCFrame, ((targetPosition - RAY_OFFSET) - cameraCFrame).unit * MAX_RAY_DISTANCE);
  local foundParts = findObstructingPartsAlongRay(ray);
  adjustTrasparency(foundParts);
end

--[[
  Updates the entire camera system.
  This method will calculate the new position of the camera, trigger
  transparency updates, etc...

  Params:
    delta | Delta time variable. Time in seconds since the last frame (ie. 0.001s)
]]
function Camera:update(delta)
  local calculateCameraPosition = self:calculateCameraPosition();
  self.currentCamera.CFrame = calculateCameraPosition;
  self:clearViewToPlayer(delta);
end

return Camera.new();