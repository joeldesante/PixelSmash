local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local PlayerJoined = Players.PlayerAdded;
local PlayerLeft = Players.PlayerRemoving;

local DataManip = require(ReplicatedStorage.Libs.DataManip);

--[[
  Initializes the players powerup data upon join.
]]
local function initializePlayerOnJoin(player)
  
  local DataFolder = player:WaitForChild("DataFolder");
  local TempData = DataFolder:WaitForChild("TempData");

  -- Create the data folder for the powerup data
  local PowerupData = DataManip.createDataFolder("PowerupData", TempData);

  -- Init data values
  local SelectedPowerup = DataManip.createDataNode("SelectedPowerup", Instance.new("StringValue"), PowerupData);
  local PowerupActive = DataManip.createDataNode("PowerupActive", Instance.new("BoolValue"), PowerupData);
  local PowerupTimeRemaining = DataManip.createDataNode("PowerupTimeRemaining", Instance.new("NumberValue"), PowerupData);

end

--[[
  Updates any nessisary data upon departure
]]
local function onPlayerLeave(player)
  -- TODO: Make sure any player who leaves the game without using up a given power up is credited that power up again.
end


PlayerJoined:Connect(initializePlayerOnJoin);
PlayerLeft:Connect(onPlayerLeave);