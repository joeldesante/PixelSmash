local RunService = game:GetService("RunService");
local Players = game:GetService("Players");

--[[
  Destroys any child of a given type residing within the top level of the instance.
  @param {any} instance - The instance that will be traversed.
  @param {string} type - The ClassName of the instances you'de like to destroy.
]]
local function clearChildrenOfType(instance, type)
  local Children = instance:GetChildren();
  for _,c in ipairs(Children) do
    if c:IsA(type) then c:Destroy() end
  end
end

--[[
  Initializes the Viewport Frame
]]
local function initializeViewportFrame()
  
  local ViewportFrame = script.Parent;
  local Heartbeat = RunService.Heartbeat;

  -- Setup the viewports camera
  local Camera = Instance.new("Camera");
  ViewportFrame.CurrentCamera = Camera;
  Camera.Parent = ViewportFrame;

  --[[
    Gets the most up to date copy of the player's characterr model
  ]]
  local function getCurrentCharacterModel() 
    local Character = Players.LocalPlayer.Character;
    if Character == nil then return end   -- Depart if the the Character has not yet loaded.
    
    Character.Archivable = true;  -- Temporarily allow cloning.
    local Frame = Character:Clone();
    Character.Archivable = false;  -- Temporarily allow cloning.
    
    return Frame;
  end

  --[[
    Updates the viewport when the `RenderStepped` event is called.
  ]]
  local function onRenderStepped()
    
    -- Get a pose from the character model
    local Model = getCurrentCharacterModel();
    if Model == nil then return end   -- Depart if the the Character has not yet loaded.

    -- Flush out the last pose in ViewportFrame
    clearChildrenOfType(ViewportFrame, "Model");

    -- Parent the model to the View Port frame
    Model.Parent = ViewportFrame

    -- Update the Camera
    local Root = Model.HumanoidRootPart;
    local InitialCFrame = Root.CFrame * CFrame.Angles(0, math.rad(-12), 0);
    local OffsetCFrame = InitialCFrame:ToWorldSpace(
      CFrame.new(Vector3.new(0, 0.75, -4.5)) * CFrame.Angles(0, math.rad(180), 0)
    );
    Camera.CFrame = OffsetCFrame;
  end

  --[[
    Triggers the `onRenderStepped` function which updates the viewport frame.
  ]]
  Heartbeat:Connect(onRenderStepped);

end

initializeViewportFrame();