script.Parent.MapLoaded.Event:Connect(function(mapData, map)

    local MapWaypoints = map:WaitForChild("Waypoints"):GetChildren()
    for _,Waypoint in ipairs(MapWaypoints) do
        local WaypointConfig = Waypoint.Configuration
        local Model = WaypointConfig:FindFirstChild("Model")
        local Health = WaypointConfig:FindFirstChild("Health")

        if Health and Model then
            do
                if not Model.Value then return end
                local ModelYOffset = (Model.Value.Size.Y/2) - 5  

                -- Clone the health UI
                local HealthBar = game.ReplicatedStorage.Effects.WaypointHealth:Clone()
                HealthBar.StudsOffset = Vector3.new(0, ModelYOffset, 0)
                HealthBar.Parent = Waypoint
            end
        end
    end
end)