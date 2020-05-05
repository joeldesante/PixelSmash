--[[
  Loads up the gui and does a fair amount of managment upon it
]]

local GUI = game.ReplicatedStorage:WaitForChild("Gui");

local cloned = GUI:Clone();
cloned.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");

