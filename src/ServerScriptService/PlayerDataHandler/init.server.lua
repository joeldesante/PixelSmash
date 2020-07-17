local DataStore2 = require(game.ServerScriptService.DataStore2)

DataStore2.Combine("DATA", "xp", "rank", "currency", "premiumCurrency")
game.Players.PlayerAdded:Connect(function(player)

    -- Clone the data model
    local PlayerDataModel = game.ReplicatedStorage.PlayerData:Clone()

    -- Load in data
    local xpStore = DataStore2("xp", player)
    local rankStore = DataStore2("rank", player)
    local currencyStore = DataStore2("currency", player)
    local premiumCurrencyStore = DataStore2("premiumCurrency", player)
    
    -- Apply data
    PlayerDataModel.Xp.Value = xpStore:Get(0)
    PlayerDataModel.Rank.Value = rankStore:Get(0)
    PlayerDataModel.Currency.Value = currencyStore:Get(100)
    PlayerDataModel.PremiumCurrency.Value = premiumCurrencyStore:Get(12)

    -- Parent the data model
    PlayerDataModel.Parent = player
    script.ClonedDataModel:Fire(player, PlayerDataModel)

end)

game.ServerScriptService.PlayerDataHandler.SaveData.Event:Connect(function(player, key, value)
    local store = DataStore2(key, player)
    store:Set(value)
end)