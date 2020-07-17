local Players = game:GetService("Players");
local Camera = {};
local camera_mt = { __index = Camera };

--[[
  Base function for creating a new Camera object
]]
function Camera.new(player)
  self = Camera;
  
  Camera.player = player;
  Camera.currentCamera = workspace.CurrentCamera;
  Camera.distance = 100;
  Camera.height = 50;
  Camera.fieldOfView = 20;
  Camera.rotationSpeed = Vector3.new(0, 5, 0);      -- Degrees per second
  Camera.rotationalOffset = Vector3.new(0,0,0);   -- How much added spin is on the camera
  Camera.isRotationMode = false;
  Camera.maxRotationOffset = 8;   -- In degrees
  Camera.maxPartTransparency = 0.8;
  Camera.target = workspace.Root;

  -- Init
  self.currentCamera.FieldOfView = self.fieldOfView;

  return setmetatable(self, camera_mt)
end

--[[
  Responsible for calculating the CFrame of the position which the Camera
  should appear.

  Returns CFrame a new CFrame for the camera.
]]
function Camera:calculateCameraPosition()
  if not self.target then 
    return CFrame.new(0,0,0);
  end
  local ISOMETRIC_OFFSET = self.distance / math.sqrt(2);  
  local TARGET_POSITION = self.target.Position;
  
  local initialCFrame = CFrame.new(TARGET_POSITION);
  local initialRotatedCFrame = initialCFrame 
    * CFrame.Angles(
      math.rad(self.rotationalOffset.x),          -- Convert the degrees on the X
      math.rad(self.rotationalOffset.y),          -- and the Y
      math.rad(self.rotationalOffset.z)           -- and the Z
    );
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

    for _,part in pairs(parts) do
      do
        local LoadedMap = game.Workspace:FindFirstChild("LoadedMap")
        if not LoadedMap then
          return -- ANCHOR: Watch for this
        end
        
        local LoadedMapModels = LoadedMap:FindFirstChild("Models")
        if not LoadedMapModels then
          warn("The models folder does not exist.")
          return -- ANCHOR: Watch for this
        end

        -- Makes sure the model is parent to the models folder
        if part.Parent ~= LoadedMapModels then break end

        -- Extract the waypoint from the model and use the refrence to manipulate the model
        local WaypointRefrence = part:FindFirstChild("Waypoint")
        if not WaypointRefrence then 
          return -- ANCHOR: Watch for this 
        end

        local Waypoint = WaypointRefrence.Value
        if not Waypoint then
          warn("Model " .. part.Name .. " waypoint refrence is invalid or nil.")
          return -- ANCHOR: Watch for this
        end

        local Configuration = Waypoint:FindFirstChild("Configuration")
        if not Configuration then 
          warn("Config not found for " .. part.Name .. ".")
          return -- ANCHOR: Watch for this
        end
        
        local IsVanishable = Configuration:FindFirstChild("Vanishable")
        local IsDestroyed = Configuration:FindFirstChild("IsDestroyed")

        if not IsVanishable or not IsDestroyed then break end
        if IsVanishable.Value and not IsDestroyed.Value then
            -- Make it Transparent
            part.Transparency = math.clamp(part.Transparency + delta*1.5, 0, self.maxPartTransparency);

            -- Turn it back to solid
            game:GetService("TweenService"):Create(part, TweenInfo.new(1), {
              Transparency = 0
            }):Play()
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
  Updates the the rotational offset to rotate on "rotationMode"
]]
function Camera:updateRotationalOffset(delta)

  -- First, normalize the rotation to 360 degrees
  self.rotationalOffset = Vector3.new(
    math.fmod(self.rotationalOffset.x, 360),
    math.fmod(self.rotationalOffset.y, 360),
    math.fmod(self.rotationalOffset.z, 360)
  );

  -- Calculate the value with delta
  local CALCULATED_ROTATION_SPEED = Vector3.new(
    self.rotationSpeed.x * delta,
    self.rotationSpeed.y * delta,
    self.rotationSpeed.z * delta
  );

  -- Apply
  if self.isRotationMode == true then
    self.rotationalOffset = self.rotationalOffset + CALCULATED_ROTATION_SPEED;
  else
    self.rotationalOffset = self.rotationalOffset * delta;
  end

end

--[[
  Updates the entire camera system.
  This method will calculate the new position of the camera, trigger
  transparency updates, etc...

  Params:
    delta | Delta time variable. Time in seconds since the last frame (ie. 0.001s)
]]
function Camera:update(delta)

  self:updateRotationalOffset(delta);

  local calculateCameraPosition = self:calculateCameraPosition();
  self.currentCamera.CFrame = calculateCameraPosition;
  self:clearViewToPlayer(delta);
end

return Camera.new();