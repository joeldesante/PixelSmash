--[[
  FIXME: May need some refactoring
  Loads up the gui and does a fair amount of managment upon it
]]

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local debouce = false;

--[[
  Initializes the user interface by cloning a copy from `ReplicatedStorage`
  and then placing it into the player gui.
]]
local function initializeUserInterface()
  local Gui = ReplicatedStorage:WaitForChild("Gui"):Clone();
  Gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
end

--[[
  Fires in the event that the player dies (even though they shouldn't).
]]
local function setupCharacterConnects(character)
  local CharacterAdded = Players.LocalPlayer.CharacterAdded;
  CharacterAdded:Connect(function()
    if debouce then
      initializeUserInterface();
    end
    debouce = true;
  end);
end

-- On first join setup the interface
initializeUserInterface();

-- After each death make sure to re-initialize the user interface
setupCharacterConnects();
