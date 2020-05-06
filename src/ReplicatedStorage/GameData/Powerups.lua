local RunService = game:GetService("RunService");

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
function Powerups.GigaBoost.Action(player)
  if RunService:IsClient() then return end    -- Just in case somebody trys to execute this on the client
  
  print("Applying GigaBoost to " .. player.Name)

end

return Powerups;