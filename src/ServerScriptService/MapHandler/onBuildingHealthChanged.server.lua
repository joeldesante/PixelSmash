script.Parent.MapLoaded.Event:Connect(function(mapData, map)
    local MapWaypoints = map:WaitForChild("Waypoints"):GetChildren()

    for _,Waypoint in ipairs(MapWaypoints) do
        local WaypointConfig = Waypoint.Configuration
        local MaxHealth = WaypointConfig:FindFirstChild("MaxHealth")
        local Health = WaypointConfig:FindFirstChild("Health")
        local Model = WaypointConfig:FindFirstChild("Model")
        local IsDestroyed = WaypointConfig:FindFirstChild("IsDestroyed")
        if MaxHealth and Health and IsDestroyed then
            local PreviousHealth = Health.Value
            Health.Changed:Connect(function(value)

                -- Clamp the health value
                Health.Value = math.clamp(value, 0, MaxHealth.Value)

                -- Toggle IsDestroyed
                if Health.Value <= 0 then
                    IsDestroyed.Value = true
                end

                if Health.Value >= MaxHealth.Value then
                    IsDestroyed.Value = false
                end

                -- Summon Health Effects
                if Model and PreviousHealth ~= Health.Value then
                    local ModelEffect = Model.Value:Clone()
                    ModelEffect.CanCollide = false
                    ModelEffect.Material = Enum.Material.SmoothPlastic
                    ModelEffect.Anchored = true
                    ModelEffect.Transparency = 0
                    ModelEffect.Parent = game.Workspace.temp

                    if ModelEffect:IsA("MeshPart") then
                        -- If it is a MeshPart then strip the texture
                        ModelEffect.Texture = ""
                    end
                    
                    game:GetService("TweenService"):Create(ModelEffect, TweenInfo.new(1), {
                        Size = ModelEffect.Size + Vector3.new(5,5,5),
                        Transparency = 1
                    }):Play()

                    game:GetService("Debris"):AddItem(ModelEffect, 2)

                    if Health.Value < PreviousHealth then
                        ModelEffect.BrickColor = BrickColor.Red()
                    elseif Health.Value > PreviousHealth then
                        ModelEffect.BrickColor = BrickColor.Green()
                    end

                    PreviousHealth = Health.Value

                end

            end)
        end
    end
end)