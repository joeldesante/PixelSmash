local Player = game.Players.LocalPlayer
local PlayerData = Player:WaitForChild("PlayerData")

local debounce = false

-- Cooldown
if not PlayerData then
	error("PlayerData was not detected in time. Aborting!")
	return
end
local PrimaryActionCooldown = PlayerData:FindFirstChild("PrimaryActionCooldown")

if not PrimaryActionCooldown then
	error("PrimaryActionCooldown was not detected in time. Aborting!")
	return
end

-- Events
local OnPrimaryAction = Player.PlayerScripts:FindFirstChild("PlayerActionHandler").OnPrimaryAction
local PrimaryActionBeganRemoteFunction = game.ReplicatedStorage.Event.PrimaryActionBegan

OnPrimaryAction.Event:Connect(function()

    local PrimaryAnimation = Player.Character:FindFirstChild("PrimaryAnimation")
    if PrimaryAnimation and PrimaryActionCooldown.Value <= 0 and not debounce then

        debounce = true

        -- Play the animation
        local PrimaryAnimationTrack = Player.Character.Humanoid:LoadAnimation(PrimaryAnimation)
        PrimaryAnimationTrack.Priority = Enum.AnimationPriority.Action
        PrimaryAnimationTrack:Play()

        -- Fire the action on signal
        PrimaryAnimationTrack:GetMarkerReachedSignal("TouchDown"):Connect(function()
            local response = PrimaryActionBeganRemoteFunction:InvokeServer()
            debounce = false
        end)
    end
end)