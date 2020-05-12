-- TODO: Clean up this script to make it more readable and elegant
--[[
  CONTROL OVERVIEW:

  W, A, S, D = Standard movement

  Space = Jump, Hold Space = Power up your Jump, Hold then Release Space = Power Jump
    Note: During the Super Jump Powerup period, smashing will cause the
    powering up to be lost. Moving will be disabled and swaped with rotate on 
    horizontal mouse movement.

  Left Click = Smash Down, Left Click Hold / Release = Super Smash
    Note: During the Super Smash Powerup period, smashing will cause the
    powering up to be lost. Moving will be disabled and swaped with rotate on 
    horizontal mouse movement.

  Fixers may attack at any time, even during power up periods.

  Further note, A full power smash should level most buildings and make the rest extreamly low in health
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ContextActionService = game:GetService("ContextActionService");   -- This will handle the click controls
local Players = game:GetService("Players");

-- Local variables
local indicator = Instance.new("Part");  -- Client smash location indicator. Shows where a given attack will hit
indicator.Size = Vector3.new(1,1,1);
indicator.BrickColor = BrickColor.Red();
indicator.CanCollide = false;
indicator.Anchored = true;

--[[
  Player click emitter is a remote function which upon 
]]
local PlayerClickEmitter = ReplicatedStorage.Emitters.PlayerClickEmitter;
local ClickResponse = require(PlayerClickEmitter.ClickResponse);
local AnimationResponse = require(PlayerClickEmitter.AnimationResponse);

--[[
  The click function that fires when the Context Action of clicking occurs.
]]
local function onClick(actionName, inputState, inputObj)

  
  local function renderSmashIndicator(indicator, relativePosition)
    local smasherCharacter = Players.LocalPlayer.Character;
    local rootPart = smasherCharacter.HumanoidRootPart;

    -- Get the Vector3 relative to the CFrame
    local worldPosition = rootPart.CFrame:PointToWorldSpace(relativePosition);

    -- Update the position
    indicator.CFrame = CFrame.new(worldPosition);

  end

  local function handleAction()
    if actionName ~= "Attack" then return end   -- Block any irrelevant actions

    if inputState == Enum.UserInputState.Begin then

      -- This indicator will be replaced with something nicer at release time
      indicator.Parent = workspace

      -- Render the indicator
      RunService:BindToRenderStep("RenderIndicator", Enum.RenderPriority.Last.Value, function()
        renderSmashIndicator(indicator, Vector3.new(0,-3,-5));
      end);

      -- Send the click trigger (Begin powering up)
      local response = PlayerClickEmitter:InvokeServer(ClickResponse.Activate);

      --[[
        Response come in the following form:
        {
          clickResponse: ClickResponseValue,
          animation: Code (not RBX but custom code) of the animation that needs to be played
        }
      ]]
      if response ~= nil then

        -- TODO: Setup the animation handler

      end

    elseif inputState == Enum.UserInputState.End then
      
      -- Remove the idicator from the workspace
      indicator.Parent = nil;
      
      -- Unbind the render script
      local success, err = pcall(function()
        RunService:UnbindFromRenderStep("RenderIndicator")
      end);
      if success == false then warn("An unbind was attempted but failed\n" .. err) end;

      -- Send click trigger (Activate the smash)
      local response = PlayerClickEmitter:InvokeServer(ClickResponse.Activate);

    end
  end
  handleAction();

end
 

ContextActionService:BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1);
PlayerClickEmitter.OnServerInvoke:Connect(function());