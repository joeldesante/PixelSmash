local Camera = require(script.Parent.Camera);
local Player = game.Players.LocalPlayer;
 
Player.CharacterAdded:Connect(function(char) Camera.target = char:WaitForChild("HumanoidRootPart"); end)

local RunService = game:GetService("RunService");
RunService.RenderStepped:Connect(function(delta) Camera:update(delta); end)