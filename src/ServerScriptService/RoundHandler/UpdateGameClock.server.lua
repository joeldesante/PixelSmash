--[[
    Updates the game clock. Makes it count down every second
]]
local RunService = game:GetService("RunService")
local GameClock = game.ReplicatedStorage.GameData.GameClock

local elapsed = 0
RunService.Stepped:Connect(function(e, delta)
    elapsed = elapsed + delta
    while elapsed >= 1 do
        GameClock.Value = math.clamp(GameClock.Value - 1, 0, math.huge)
        elapsed = elapsed - 1
    end
end)