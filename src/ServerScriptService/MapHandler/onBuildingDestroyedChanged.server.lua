local function createHitzone(model)
    local HitZone = Instance.new("Part")
    HitZone.Name = model.Name .. "_hitzone"
    HitZone.CanCollide = false
    HitZone.Anchored = true
    HitZone.CFrame = model.CFrame - Vector3.new(0,1,0)
    HitZone.Size = model.Size + Vector3.new(0,1,0)
    HitZone.Material = Enum.Material.ForceField
    HitZone.BrickColor = BrickColor.Red()
    HitZone.CastShadow = false
    return HitZone
end

local function sprayParticles(particleCount, position)
	
	local BlockFragments = game.ServerStorage.BlockFragments:GetChildren()

	for particle = 0, particleCount, 1 do
		local fragment = BlockFragments[math.random(#BlockFragments)]:Clone()
        fragment.Parent = game.Workspace.temp
        fragment.CFrame = position
        fragment.Size = Vector3.new(
            math.random(2,8),
            math.random(2,8),
            math.random(2,8)
        )
        fragment.Velocity = Vector3.new(
            math.random(-100,100),
            math.random(-100,100),
            math.random(-100,100)
        )
        game:GetService("Debris"):AddItem(fragment, 10)
	end
end

script.Parent.MapLoaded.Event:Connect(function(mapData, map)

    local MapWaypoints = map:WaitForChild("Waypoints"):GetChildren()

    local HitZones = Instance.new("Folder")
    HitZones.Name = "temp_HitZones"
    HitZones.Parent = map

    for _,Waypoint in ipairs(MapWaypoints) do
        local WaypointConfig = Waypoint.Configuration
        local Model = WaypointConfig:FindFirstChild("Model")
        local IsDestroyed = WaypointConfig:FindFirstChild("IsDestroyed")

        if IsDestroyed and Model then

            local HitZone = createHitzone(Model.Value)

            IsDestroyed.Changed:Connect(function(modelIsDestroyed)

                if modelIsDestroyed then

                    -- Vanish the model and disable collisions
                    Model.Value.CanCollide = false
                    Model.Value.Transparency = 1

                    -- Spray particles
                    sprayParticles(10, Waypoint.CFrame)

                    -- Display the HitZone
                    HitZone.Parent = HitZones

                else

                    -- Inverted Spray Particles

                    -- Reveal the model and enable collisions
                    Model.Value.CanCollide = true
                    Model.Value.Transparency = 0

                    -- Destroy the hitzone
                    HitZone.Parent = nil

                end

            end)
        end
    end

end)