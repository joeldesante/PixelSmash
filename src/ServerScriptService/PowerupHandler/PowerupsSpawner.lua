local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Powerups = require(ReplicatedStorage.GameData.Powerups);
local PowerupSpawner = {};

function PowerupSpawner.new()
  return setmetatable({}, {__index = PowerupSpawner})
end

--[[
  Spawns a single powerup at a given location

  Params
    Location = Vector3
]]
function PowerupSpawner:spawnPowerup(powerupType, location)
  local PowerupInstance = powerupType.Model:Clone();
  PowerupInstance.CFrame = CFrame.new(location);
  PowerupInstance.Anchored = true;
  PowerupInstance.Parent = workspace.PlayzoneParts.Static.Powerups;

  return PowerupInstance;
end

return PowerupSpawner.new();