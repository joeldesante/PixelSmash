--[[
  Updates the bash bar to reflect the metadata emitted from the server.
]]

-- Metadata
local Metadata = game.ReplicatedStorage:WaitForChild("Metadata");
local amountDestroyed = Metadata:WaitForChild("amountdestroyed");   -- Must be between the values 0 and 1

-- The UI Elements
local innerBar = script.Parent.InnerBar;

-- Update functions
local function updateInnerBar(value)
  innerBar.Size = UDim2.new(value, 0, 1, 0);
end

-- Initilize the bar and the percent text
updateInnerBar(amountDestroyed.Value)

-- Set up the event listener
amountDestroyed.Changed:Connect(function(value)
  updateInnerBar(value);
end);
