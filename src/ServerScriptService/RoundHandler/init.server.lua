local GameInSession = game.ReplicatedStorage.GameData.GameInSession
local GameClock = game.ReplicatedStorage.GameData.GameClock
local GameSettings = game.ReplicatedStorage.GameSettings

GameInSession.Changed:Connect(function(isInSession)
    if isInSession then
		GameClock.Value = GameSettings.RoundTime.Value
	else
		GameClock.Value = GameSettings.IntermissionTime.Value
	end
end)

GameClock.Changed:Connect(function(remainingTime)
	if remainingTime <= 0 then
		GameInSession.Value = not GameInSession.Value
	end
end)