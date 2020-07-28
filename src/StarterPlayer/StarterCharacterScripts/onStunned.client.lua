local Player = game.Players.LocalPlayer
local PlayerData = Player:WaitForChild("PlayerData")

if not PlayerData then
    error("PlayerData failed to load in time. Aborting!")
    return
end

local CharacterData = PlayerData:FindFirstChild("CharacterData")
if not CharacterData then
    error("CharacterData failed to load in time. Aborting!")
    return
end

local isStunned = CharacterData:FindFirstChild("isStunned")

isStunned.Changed:Connect(function(value)

    if value ~= true then return end

    -- Grab the player info (team)
    if Player.Team ~= game.Teams.Smasher then return end
    if not Player.Character then
        warn("Character not found. Ignoring Stun Signal.") 
        return
    end

    -- Grab the character and humanoid
    local Character = Player.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then
        warn("Humanoid not found. Ignoring Stun Signal.")
        return
    end

    -- Animations
    local PreStunAnimation = Character:FindFirstChild("PreStunAnimation")
    local StunAnimation = Character:FindFirstChild("StunAnimation")

    -- Load The Animations
    local PreStunAnimationTrack = Humanoid:LoadAnimation(PreStunAnimation)
    local StunAnimationTrack = Humanoid:LoadAnimation(StunAnimation)

    PreStunAnimationTrack:Play()
    PreStunAnimationTrack:GetMarkerReachedSignal("InitStun"):Connect(function()
        StunAnimationTrack:Play()
    end)

end)
