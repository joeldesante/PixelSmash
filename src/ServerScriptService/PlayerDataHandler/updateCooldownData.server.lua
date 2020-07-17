local RunService = game:GetService("RunService")

game.ServerScriptService.PlayerDataHandler.ClonedDataModel.Event:Connect(function(player, DataModel)
    
    local PrimaryActionCooldown = DataModel:FindFirstChild("PrimaryActionCooldown")
    local SecondaryActionCooldown = DataModel:FindFirstChild("SecondaryActionCooldown")

    if not PrimaryActionCooldown or not SecondaryActionCooldown then
        warn("Failure to discover the cooldowns. Aborting!")
        return
    end

    PrimaryActionCooldown.Changed:Connect(function(value)
        PrimaryActionCooldown.Value = math.clamp(PrimaryActionCooldown.Value, 0, math.huge)
    end)

    SecondaryActionCooldown.Changed:Connect(function(value)
        SecondaryActionCooldown.Value = math.clamp(SecondaryActionCooldown.Value, 0, math.huge)
    end)

end)

local function onStep(e, delta)

    local Players = game.Players:GetPlayers()

    for _,Player in ipairs(Players) do

        local DataModel = Player:FindFirstChild("PlayerData")
        if not DataModel then return end

        local PrimaryActionCooldown = DataModel:FindFirstChild("PrimaryActionCooldown")
        local SecondaryActionCooldown = DataModel:FindFirstChild("SecondaryActionCooldown")
        if not PrimaryActionCooldown or not SecondaryActionCooldown then return end

        if PrimaryActionCooldown.Value > 0 then
            PrimaryActionCooldown.Value = PrimaryActionCooldown.Value - delta;
        end
    
        if SecondaryActionCooldown.Value > 0 then
            SecondaryActionCooldown.Value = SecondaryActionCooldown.Value - delta;
        end

    end
end

RunService.Stepped:Connect(onStep)