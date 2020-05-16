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
  local isRotateMode = script:WaitForChild("isRotateMode");
  local rotateModeSpeed = script:WaitForChild("rotateModeSpeed");

  local OFFSET = 100;
  local FOV = 20;
  local MOUSE_X = 0;
  local TOTAL_MOUSE_DELTA = Vector2.new(0,0);

  local isMouseDown = false;

  --[[
    Calculates the CFrame of the camera given the position of the players HumanoidRootPart.
  
  local function calculatePosition(baseRotation)
    local CALCULATED_OFFSET = OFFSET / math.sqrt(2);  -- This calculates the distace of the cameras positional sides
    local CALCULATED_HEIGHT = 50

    local initialCFrame = CFrame.new(RootPart.Position);    -- This creates a Cframe with no rotation
    local baseRotationCFrame = initialCFrame * CFrame.Angles(0, math.rad(baseRotation), 0);
    local offsetCFrame = baseRotationCFrame:ToWorldSpace(CFrame.new(-CALCULATED_OFFSET, CALCULATED_HEIGHT, -CALCULATED_OFFSET));
    local rotatedCFrame = CFrame.new(offsetCFrame.p, RootPart.Position);

    return rotatedCFrame;
  end
  ]]
  local function clearViewToPlayer(delta)

    --[[local function findPartsOnRay(ray)
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
          part.Transparency = math.clamp(part.Transparency + delta*1.5, 0, 0.75);
        else
          part.Transparency = math.clamp(part.Transparency - delta*(1/2), 0, 0.75);
        end
      end
    end]]
  end

  --[[
    Updates the MOUSE_X value to make the camera spin around its subject.

    delta = The delta time value provided by the render loop
    speed = The speed which the rotation should go. (Degrees per second)
  ]]
  local function rotateModeHandler(delta, speed)
    if isRotateMode.Value then
      local rotationalOffset = math.fmod(MOUSE_X + (delta*speed), 360);
      MOUSE_X = rotationalOffset;
    else
      --[[ TODO: Make the snap back rotation have some kind of animation curve.
                  Right now the curve is linear and it looks a bit stiff. ]]
      MOUSE_X = math.clamp(MOUSE_X - (delta*480), 0, 360);
    end
  end

  --[[
    Hooke's law
      F = kx

    This creates a spring effect from a given CFrame
  ]]
  local function springCalculation(targetPosition, currentPosition, delta)
    -- FIXME
  end

  local function inverseParabola(value, maxValue)
    return math.clamp((1/2*math.pow(-value, 2)) + maxValue, 0, maxValue);
  end

  local function handleAngleOffset(delta)

    local MAX_ROTATION_OFFSET = 7;

    if isMouseDown then
      local x = math.clamp(TOTAL_MOUSE_DELTA.x - UserInputService:GetMouseDelta().x * delta, -MAX_ROTATION_OFFSET, MAX_ROTATION_OFFSET);
      TOTAL_MOUSE_DELTA = Vector2.new(x, 0)
    else
      local reducedXDelta = TOTAL_MOUSE_DELTA.x * 0.75;
      if math.abs(reducedXDelta) < 0.005 then
        reducedXDelta = 0;
      end
      
      TOTAL_MOUSE_DELTA = Vector2.new(reducedXDelta, 0);

    end

    MOUSE_X = MOUSE_X + TOTAL_MOUSE_DELTA.x;
  end

  local function onRenderStepped(delta)

    rotateModeHandler(delta, rotateModeSpeed.Value);
    handleAngleOffset(delta);
    local CalculatedCameraCFrame = calculatePosition(MOUSE_X);
    Camera.CFrame = CalculatedCameraCFrame;

    Camera.FieldOfView = FOV;
    clearViewToPlayer(delta);

  end

  local function onDragMouse(input, isGameProcessEvent)
    if isGameProcessEvent then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
      isMouseDown = true;
    end

  end

  local function onDragMouseEnded(input, isGameProcessEvent)
    if isGameProcessEvent then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
      isMouseDown = false;
    end

  end

  -- Setup the render step
  RenderStepped:Connect(onRenderStepped);
  InputBegan:Connect(onDragMouse);
  InputEnded:Connect(onDragMouseEnded);
end

initialize();