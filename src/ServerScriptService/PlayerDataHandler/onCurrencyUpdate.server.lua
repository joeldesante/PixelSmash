game.ServerScriptService.PlayerDataHandler.ClonedDataModel.Event:Connect(function(player, DataModel)

    local Currency = DataModel:FindFirstChild("Currency")
    local PremiumCurrency = DataModel:FindFirstChild("PremiumCurrency")
    if not Currency or not PremiumCurrency then
        warn("Failed to load currency")
        return
    end

    Currency.Changed:Connect(function(value)
        Currency.Value = math.clamp(Currency.Value, 0, math.huge)
        game.ServerScriptService.PlayerDataHandler.SaveData:Fire(player, "currency", Currency.Value)
    end)

    PremiumCurrency.Changed:Connect(function(value)
        PremiumCurrency.Value = math.clamp(PremiumCurrency.Value, 0, math.huge)
        game.ServerScriptService.PlayerDataHandler.SaveData:Fire(player, "premiumCurrency", PremiumCurrency.Value)
    end)

end)