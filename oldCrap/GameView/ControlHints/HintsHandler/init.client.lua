local ContextActionService = game:GetService("ContextActionService");
local TextHandler = require(script.TextHandler);
local parentView = game.Players.LocalPlayer.PlayerGui.Gui.GameView;

-- Functions
local function updateButtonSize(button, padding)
  button.Size = UDim2.new(0, TextHandler.CalculateWidth(button).x + padding, 1, 0);
end

for _,v in pairs(script.Parent:GetChildren()) do
  if v.ClassName == "TextButton" then

    -- Update the size
    updateButtonSize(v, 20);

    -- Load up the buttons data.
    local hintData = require(v:WaitForChild("action"));

    -- Setup the context checking
    v.isActive.Changed:Connect(function(active)

      -- Make sure that the game view is active.
      if parentView.Enabled == false then return end
      
      if active then
        -- When active, enable the context and make the hint visable
        ContextActionService:BindAction(hintData.name, hintData.context, false, hintData.inputs);
        v.Visible = true;
      else
        -- When inactive, disable the context and make the hint invisable
        ContextActionService:UnbindAction(hintData.name);
        v.Visible = false;
      end

    end)

    -- Checks to make sure the gameview is even active
    parentView:GetPropertyChangedSignal("Enabled"):Connect(function()
      local hintContextData = require(v:WaitForChild("action"));
      if parentView.Enabled == false then
        -- Disable the context
        v.isActive.Value = false
      end
    end)

    -- Bind click events
    v.MouseButton1Click:Connect(hintData.fire);

  end
end