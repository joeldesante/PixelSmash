local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlayerJoined = Players.PlayerAdded;

local DataManip = require(ReplicatedStorage.Libs.DataManip);

--[[
  Initializes the plyers Data folder and fetches some relevant data from the datastore
]]
local function initializePlayerData(player)
  
  --[[
    Top level data folder. Holds the rest of the data.
  ]]
  local DataFolder = DataManip.createDataFolder("DataFolder", player);

  --[[
    Long term data that will be stored in a DataStore will reside here.
    This includes money, unused powerups and other inventory, cosmetic changes,
    and experience points.
  ]]
  local PersistentData = DataManip.createDataFolder("PersistentData", DataFolder);

  --[[
    Temporary data which will not be saved into any datastore once the player has left
    the game. Includes data such as active powerup data and 
    the liklyhood of becoming the smasher.
  ]]
  local TempData = DataManip.createDataFolder("TempData", DataFolder);

end

PlayerJoined:Connect(initializePlayerData);