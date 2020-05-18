--[[local Players = game:GetService("Players");

Players.PlayerAdded:Connect(function(player)

  player.CharacterAdded:Connect(function(character)

    character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    character.Archivable = true

    -- Move humanoid  
    local humanoid = character:WaitForChild("Humanoid");
    humanoid.Parent = game.ReplicatedStorage;
  
    -- Gut it
    character:ClearAllChildren();
  
    -- Build the character
    local Fixer2 = game.ReplicatedStorage.Models.Characters.Fixer2:Clone();
    Fixer2.HumanoidRootPart.Parent = character;
  
    -- Reinstall the humanoid
    humanoid.Parent = character

    character.Archivable = false
  
  end)

end)]]