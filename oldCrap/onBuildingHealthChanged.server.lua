-- Listen for the map to be added
--local LoadedMap = game.Workspace:FindFirstChild("LoadedMap")

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == "LoadedMap" then
        local Waypoints = child.Waypoints:GetChildren()
        for _,Waypoint in ipairs(Waypoints) do
            local WaypointHealth = Waypoint.Configuration.Health
            local WaypointModel = Waypoint.Configuration.Model.Value

            local oldHealthValue = WaypointHealth.Value

            WaypointHealth.Changed:Connect(function(value)

                if value < oldHealthValue then
                    -- Do breaking particles
                    local HarmParticles = game.ReplicatedStorage.ParticleSystems.HarmEffect:Clone()
                    HarmParticles.Parent = WaypointModel
                    game:GetService("Debris"):AddItem(HarmParticles, 1)
                end

                if value > oldHealthValue then
                    -- Do heal particles
                    local RepairParticles = game.ReplicatedStorage.ParticleSystems.RepairEffect:Clone()
                    RepairParticles.Parent = WaypointModel
                    game:GetService("Debris"):AddItem(RepairParticles, 1)
                end

                oldHealthValue = value
            end)

        end
    end
end)