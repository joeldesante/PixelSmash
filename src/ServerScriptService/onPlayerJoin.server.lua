local Players = game.Players

local SmasherCharacter = game.ReplicatedStorage.PlayerModels.SmasherCharacter
local FixerCharacter = game.ReplicatedStorage.PlayerModels.FixerCharacter

Players.PlayerAdded:Connect(function(player)
	
	-- Balance the teams
	if #game.Teams.Fixer:GetPlayers() < #game.Teams.Smasher:GetPlayers() then
		player.Team = game.Teams.Fixer
		
	else
		player.Team = game.Teams.Smasher
	end

	--player.Team = game.Teams.Fixer

	if player.Team == game.Teams.Fixer then
		-- Make the players starter character the fixer model
		local character = FixerCharacter:Clone()
		character.Name = "StarterCharacter"
		character.Parent = game.StarterPlayer
	else
		-- Make the players starter character the smasher model
		local character = SmasherCharacter:Clone()
		character.Name = "StarterCharacter"
		character.Parent = game.StarterPlayer
	end

end)