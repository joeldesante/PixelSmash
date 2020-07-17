local FixerPrimaryAction = game.ServerScriptService.PlayerActionHandler.FixerPrimaryAction

local RADIUS = 20  -- NOTE: Make this upgradable
local HEALING = 10

FixerPrimaryAction.OnInvoke = function(player)

    if player.Character == nil then return false end
    local Character = player.Character
    local RootCFrame = Character.HumanoidRootPart.CFrame

    -- Get models in the radius
    local LoadedMapModels = game.Workspace.LoadedMap.Models:GetChildren()
    local ModelsInRadius = {}
    for _,model in ipairs(LoadedMapModels) do
        local modelVec = Vector3.new(model.CFrame.p.X, 0, model.CFrame.p.Z)
        local rootVec = Vector3.new(RootCFrame.p.X, 0, RootCFrame.p.Z)

        if (modelVec - rootVec).magnitude <= RADIUS then
            -- Is in the radius
            table.insert(ModelsInRadius, model)
        end
    end

    for _,part in ipairs(ModelsInRadius) do
        
        if part:FindFirstChild("Waypoint") ~= nil then
            local waypoint = part.Waypoint.Value;
            local WaypointHealth = waypoint.Configuration.Health
            local WaypointMaxHealth = waypoint.Configuration.MaxHealth
            local IsDestroyed = waypoint.Configuration.IsDestroyed
            local MainModel = waypoint.Configuration.Model.Value

            if WaypointHealth.Value > 0 and WaypointHealth.Value < WaypointMaxHealth.Value then
                WaypointHealth.Value = WaypointHealth.Value + HEALING
            elseif WaypointHealth.Value >= WaypointMaxHealth.Value then 
                WaypointHealth.Value = WaypointMaxHealth.Value
            else
                WaypointHealth.Value = 0
            end

            if IsDestroyed.Value == true and WaypointHealth.Value <= 0 then
                MainModel.CanCollide = true
                MainModel.Transparency = 0
            end

        end
    end

    return;

end