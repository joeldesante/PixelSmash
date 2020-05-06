local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Powerups = require(ReplicatedStorage.GameData.Powerups);

local PowerupViewFrame = script.Parent;

--[[
  Is triggered when the player attempts to activater a powerup.
]]
local PowerupActivatedEvent = ReplicatedStorage.Events.ActivatePowerup;

--[[
  Used to query the server for powerup information regarding the player.
]]
local PowerupUpdaterListener = ReplicatedStorage.Listeners.PowerupUpdaterListener;

--[[
  Fired when the Active Powerup value is changed in order to update the powerup display.
  FIXME: Generally this script needs to be reorganized but this particular function is prone to error.
]]
local ControlHintActivatePowerup = Players.LocalPlayer:WaitForChild("PlayerGui").Gui.GameView.ControlHints.ActivatePowerUp;
local function onSelectedPowerupUpdate(value)

  if value ~= nil or value ~= "" then
    PowerupViewFrame.Image = string.format("rbxassetid://%i", Powerups[value].IconId);
    ControlHintActivatePowerup.isActive.Value = true;
  else
    ControlHintActivatePowerup.isActive.Value = false;
  end
end

Players.LocalPlayer:WaitForChild("DataFolder").TempData.PowerupData.SelectedPowerup.Changed:Connect(onSelectedPowerupUpdate);
