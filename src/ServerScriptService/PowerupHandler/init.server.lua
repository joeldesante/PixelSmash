local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Powerups = require(ReplicatedStorage.GameData.Powerups);
local PowerupsSpawner = require(script.PowerupsSpawner);

--[[
  This event activates upon a request to activate the powerup
]]
local PowerupEvent = ReplicatedStorage.Emitters.PowerupEmitter;

--[[
  This event fires when a request is made from the client to activate a powerup.
]]
local function onPowerupEvent(player)
  -- FIXME: Add checking
  -- Activate a powerup for the player.
  local activatedPowerup = player:WaitForChild("DataFolder"):WaitForChild("TempData"):WaitForChild("PowerupData"):WaitForChild("SelectedPowerup").Value;
  print(activatedPowerup);
  Powerups[activatedPowerup].Action(player);
  return true;
end

PowerupEvent.OnServerInvoke = onPowerupEvent;


-- FIXME

local spawnedPowerup = {}

--[[
  Limits a given table to just BaseParts
]]
local function limitTableToParts(tab)
  local newTab = {}
  for _,i in pairs(tab) do
    if i:IsA("BasePart") then
      table.insert(newTab, i);
    end
  end
  return newTab;
end

local POWERUP_RANGE = 8;
RunService.Stepped:Connect(function(delta)
  for _,powerup in pairs(spawnedPowerup) do
    -- Region 3 detection
    local lowerCorner = powerup.CFrame:PointToWorldSpace(Vector3.new(-POWERUP_RANGE, -POWERUP_RANGE, -POWERUP_RANGE))
    local upperCorner = powerup.CFrame:PointToWorldSpace(Vector3.new(POWERUP_RANGE, POWERUP_RANGE, POWERUP_RANGE))
    local region = Region3.new(lowerCorner, upperCorner);
    
    local ignoreList = limitTableToParts(workspace.PlayzoneParts:GetDescendants());
    local partsInRadius = workspace:FindPartsInRegion3WithIgnoreList(region, ignoreList);
    local target = nil;

    for _,part in pairs(partsInRadius) do
        local player = Players:GetPlayerFromCharacter(part.Parent);
        if player then
          target = player;
          break;
        end
    end

    if target ~= nil then
      -- Give a powerup for a given player
      target.DataFolder.TempData.PowerupData.SelectedPowerup.Value = powerup.Name;
      powerup:Destroy() -- TODO: Implemenent cool animation
    end
  end
end)

while wait(10) do
  table.insert(spawnedPowerup, PowerupsSpawner:spawnPowerup(Powerups.GigaBoost, Vector3.new(math.random()*40,10,math.random()*40)))
end

