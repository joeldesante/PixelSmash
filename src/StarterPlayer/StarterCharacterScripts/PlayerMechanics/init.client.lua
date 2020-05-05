local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Humanoid = Player.Character:WaitForChild("Humanoid")

-- Unbind the default jumping behavior
ContextActionService:UnbindAction("jumpAction");

-- Jump

local DEFAULT_JUMP_POWER = 50;
local MAX_JUMP_POWER = 1000;
local POWER = 50;
local POWER_UP = false;
UserInputService.InputBegan:Connect(function(input, gameProcess)
  if gameProcess then return end
  if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

  if input.KeyCode == Enum.KeyCode.Space then
    POWER_UP = true
  end
end)

UserInputService.InputEnded:Connect(function(input, gameProcess)
  if gameProcess then return end
  if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

  if input.KeyCode == Enum.KeyCode.Space then
    
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    POWER_UP = false
    Humanoid.JumpPower = DEFAULT_JUMP_POWER

  end
end)

-- Power Up Loop
while true do

  if POWER_UP and Humanoid.JumpPower < MAX_JUMP_POWER then
    Humanoid.JumpPower = Humanoid.JumpPower + 100
  end
  wait(1/20)
end