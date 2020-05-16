local Camera = require(script.Parent.Camera);
local Player = game.Players.LocalPlayer;

local c = Camera.new(Player);

Player.CharacterAdded:Connect(function(char)
  c.target = char:WaitForChild("HumanoidRootPart");
end)

local RunService = game:GetService("RunService");
RunService.RenderStepped:Connect(function(delta)
  c:update(delta);
end)