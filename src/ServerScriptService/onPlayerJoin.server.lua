local Players = game.Players

Players.PlayerAdded:Connect(function(player)
	
	-- Balance the teams
	if #game.Teams.Fixer:GetPlayers() < #game.Teams.Smasher:GetPlayers() then
		player.Team = game.Teams.Fixer
		
	else
		player.Team = game.Teams.Smasher
	end

end)