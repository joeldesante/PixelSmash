local function calculateXPfromRank(rank)
    return ((math.pow(rank, 2) - rank) * 50)/2
end

game.ServerScriptService.PlayerDataHandler.ClonedDataModel.Event:Connect(function(player, DataModel)

    local Xp = DataModel:FindFirstChild("Currency")
    local Rank = DataModel:FindFirstChild("PremiumCurrency")
    if not Xp or not Rank then
        warn("Failed to load xp and rank")
        return
    end

    Xp.Changed:Connect(function(value)
        Xp.Value = math.clamp(Xp.Value, 0, math.huge)
        game.ServerScriptService.PlayerDataHandler.SaveData:Fire(player, "xp", Xp.Value)

        -- Handle rank updates
    end)

    Rank.Changed:Connect(function(value)
        Rank.Value = math.clamp(Rank.Value, 0, math.huge)
        game.ServerScriptService.PlayerDataHandler.SaveData:Fire(player, "rank", Rank.Value)
    end)

end)