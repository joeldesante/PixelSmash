local SmasherPrimaryAction = game.ServerScriptService.PlayerActionHandler.SmasherPrimaryAction

local RADIUS = 20  -- NOTE: Make this upgradable
local DAMAGE = 10

SmasherPrimaryAction.OnInvoke = function(player)

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
            local currentHealth = waypoint.Configuration.Health
            local WaypointMaxHealth = waypoint.Configuration.MaxHealth
            local IsDestroyed = waypoint.Configuration.IsDestroyed
            local MainModel = waypoint.Configuration.Model.Value

            if currentHealth.Value > 0 then
                currentHealth.Value = currentHealth.Value - DAMAGE
            else
                currentHealth.Value = 0
            end

            if IsDestroyed.Value == true and WaypointHealth.Value >= WaypointMaxHealth.Value then
                MainModel.CanCollide = false
                MainModel.Transparency = 1
            end
        end
    end

    return;

end