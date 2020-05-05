local RunService = game:GetService("RunService");
local Players = game:GetService("Players");

--[[
  Initializes the Viewport Frame
]]
local function initializeViewportFrame()
  
  local ViewportFrame = script.Parent;
  local RenderStepped = RunService.RenderStepped;

  --[[
    Gets the most up to date copy of the player's characterr model
  ]]
  local function getCurrentCharacterModel() 
    local Character = Players.LocalPlayer.Character:Clone();
    return Character;
  end

  --[[
    Updates the viewport when the `RenderStepped` event is called.
  ]]
  local function onRenderStepped()
    
    -- Get a pose from the character model
    local model = getCurrentCharacterModel();

    -- Flush out the last pose in ViewportFrame
    clearChildrenOfType();
  end

end

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

initializeViewportFrame();