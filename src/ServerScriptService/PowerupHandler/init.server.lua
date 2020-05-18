local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Powerups = require(ReplicatedStorage.GameData.Powerups);

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

