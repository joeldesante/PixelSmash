--[[
  The basic camera system for the game
]]

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");

local function initialize()

  local Camera = workspace.CurrentCamera;
  local Character = Players.LocalPlayer.Character;
  local RootPart = Character.HumanoidRootPart;
  local RenderStepped = RunService.RenderStepped;
  local InputBegan = UserInputService.InputBegan;
  local InputEnded = UserInputService.InputEnded;

  local OFFSET = 100;
  local FOV = 20;
  local MOUSE_DELTA = Vector2.new(0,0)

  --[[
    Calculates the CFrame of the camera given the position of the players HumanoidRootPart
  ]]
  local function calculatePosition(mouseDelta)
    local CALCULATED_OFFSET = OFFSET / math.sqrt(2);  -- This calculates the distace of the cameras positional sides
    local CALCULATED_HEIGHT = 50

    local initialCFrame = CFrame.new(RootPart.Position);    -- This creates a Cframe with no rotation
    local offsetCFrame = initialCFrame:ToWorldSpace(CFrame.new(-CALCULATED_OFFSET + mouseDelta.X, CALCULATED_HEIGHT, -CALCULATED_OFFSET + mouseDelta.X));
    local rotatedCFrame = CFrame.new(offsetCFrame.p, RootPart.Position);

    return rotatedCFrame;
  end

  local function clearViewToPlayer(delta)

    local function findPartsOnRay(ray)
      local targets = {}
      repeat
        local target = workspace:FindPartOnRayWithIgnoreList(ray, targets);
        if target then
          local isPlayer = Players:GetPlayerFromCharacter(target.Parent); -- See if the part is part of a player
          if isPlayer ~= nil then break end
          table.insert(targets, target);
        end

      until not target;
      return targets;
    end

    local raycast = Ray.new(Camera.CFrame.p, ((RootPart.Position - Vector3.new(0,3,0)) - Camera.CFrame.p).unit * 1000);
    local foundParts = findPartsOnRay(raycast);
    local vanishable = workspace.PlayzoneParts.Vanishable:GetChildren();

    -- Changes the transparency of a given block
    for _,part in pairs(vanishable) do
      if part:IsA("BasePart") then
        if table.find(foundParts, part) ~= nil then
          print(1)
          part.Transparency = math.clamp(part.Transparency + delta*1.5, 0, 0.9);
        else
          print(2)
          part.Transparency = math.clamp(part.Transparency - delta*(1/2), 0, 0.9);
        end
      end
    end
  end

  local function onRenderStepped(delta)
    MOUSE_DELTA = UserInputService:GetMouseDelta();
    Camera.CFrame = calculatePosition(MOUSE_DELTA);
    Camera.FieldOfView = FOV;
    clearViewToPlayer(delta);
  end

  local function onDragMouse(input, isGameProcessEvent)
    if isGameProcessEvent then return end

    --if input.

  end

  local function onDragMouseEnded(input, isGameProcessEvent)
    if isGameProcessEvent then return end


  end

  -- Setup the render step
  RenderStepped:Connect(onRenderStepped);
  InputBegan:Connect(onDragMouse);
  InputEnded:Connect(onDragMouseEnded);
end

initialize();