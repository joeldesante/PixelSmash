--[[
  Updates the game clock to reflect the metadata emitted from the server.
]]

local Metadata = game.ReplicatedStorage:WaitForChild("Metadata");
local ConvertTime = require(game.ReplicatedStorage:WaitForChild("Libs"):WaitForChild("ConvertTime"));

local gameTime = Metadata:WaitForChild("gametime");

gameTime.Changed:Connect(function()
  local time = gameTime.Value;
  local converted = ConvertTime.SecondsToMinutes(time);

  -- Update the String
  if converted.minutes > 0 then
    script.Parent.Text = string.format("%i:%i", converted.minutes, converted.seconds);

    if converted.seconds < 10 then
      script.Parent.Text = string.format("%i:0%i", converted.minutes, converted.seconds);
    end
  else
    script.Parent.Text = string.format("%i", converted.seconds);
  end

end)
