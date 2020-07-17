local Powerup = {}
Powerup.Model = Instance.new("Part")

function Powerup.new(powerupType)
  self = {};
  self.Model = powerupType;

  return setmetatable(self, {__index = Powerup});
end

function Powerup:update()
  print("Hajlula")
end