local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
--[[
  This table of Powerups holds all the relevant information needed for most systems
  to use. This way I can update information in one place and it updates everywhere.

  Note: All powerups are intentionally generalized, this way they can be applied to
  either the smasher or the fixer.
]]
local Powerups = {};

--[[
  Gigaboost offers the ability to increase the speed/power of a given characters ability.
  Ie. Smashers will smash harder, jump higher, and walk faster
      Fixers will fix faster, hit harder (when attempting to stun the smasher), and walk faster.
]]
Powerups.GigaBoost = {}
Powerups.GigaBoost.Name = "GigaBoost";    -- Maybe Gigablast?
Powerups.GigaBoost.Description = "Increase overall power, speed, and efficency by a factor of 2.5x";
Powerups.GigaBoost.IconId = "10889910";
Powerups.GigaBoost.Meta = {
  ["multiplier"] = 2.5
}
Powerups.GigaBoost.Model = ReplicatedStorage.Models.Lootables.Powerups.GigaBoost
function Powerups.GigaBoost.Action(player)
  if RunService:IsClient() then 
    warn("You may NOT activate powerup from the client.");
    return
  end    -- Just in case somebody trys to execute this on the client
  
  print("Applying GigaBoost to " .. player.Name);

end

--[[
  Speed Boost
  This powerup gives the player a 2.5x increase in speed
]]
Powerups.Speed = {}
Powerups.Speed.Name = "Speed Boost";    -- Maybe Gigablast?
Powerups.Speed.Description = "Increase speed by 2.5x for duration of 25 seconds";
Powerups.Speed.IconId = "1587991485";
Powerups.Speed.Meta = {
  ["multiplier"] = 2.5
}
Powerups.Speed.Model = ReplicatedStorage.Models.Lootables.Powerups.Speed
function Powerups.Speed.Action(player)
  if RunService:IsClient() then 
    warn("You may NOT activate powerup from the client.");
    return
  end    -- Just in case somebody trys to execute this on the client
  
  print(string.format("Applying %s to %s", Powerups.Speed.Name, player.Name));
  local originalSpeed = player.Character.Humanoid.WalkSpeed;
  player.Character.Humanoid.WalkSpeed = originalSpeed + (originalSpeed * 2.5);

end

return Powerups;