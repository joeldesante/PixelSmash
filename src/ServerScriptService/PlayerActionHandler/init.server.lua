local PrimaryActionBegan = game.ReplicatedStorage.Event.PrimaryActionBegan
local SecondaryActionBegan = game.ReplicatedStorage.Event.SecondaryActionBegan

local SmasherPrimaryAction = script.SmasherPrimaryAction
local SmasherSecondaryAction = script.SmasherSecondaryAction
local FixerPrimaryAction = script.FixerPrimaryAction
local FixerSecondaryAction = script.FixerSecondaryAction

PrimaryActionBegan.OnServerInvoke = function(player)
    
    if player.Team == game.Teams.Fixer then
        FixerPrimaryAction:Invoke(player)
    end

    if player.Team == game.Teams.Smasher then
        SmasherPrimaryAction:Invoke(player)
    end

    return nil;
end

SecondaryActionBegan.OnServerInvoke = function(player)

    if player.Team == game.Teams.Fixer then
        FixerSecondaryAction:Invoke(player)
    end

    if player.Team == game.Teams.Smasher then
        SmasherSecondaryAction:Invoke(player)
    end

    return nil;
end