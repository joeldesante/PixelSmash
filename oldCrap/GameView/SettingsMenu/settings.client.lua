local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local SettingsMenu = script.Parent;

local SettingsEvent = ReplicatedStorage.Events.SettingsEvent.Event;
local SettingsRemoteEvent = ReplicatedStorage.Listeners.SettingsMenuListener.OnClientEvent;

local isActive = SettingsMenu.Visible;

--[[
  Initializes the settings menu.
  Connects the events and creates the blur effect.
]]
local function initializeSettingsMenu()

  -- The blur effect that is turned on when the settings are visible
  local Blur = Instance.new("BlurEffect");
  Blur.Name = "SettingsBlur";
  Blur.Parent = Lighting;
  Blur.Enabled = isActive;

  --[[
    An event listener to be fired when `SettingsEvent` is triggered from an external
    script.
    @param active {bool} Wheter the settings menu should be opened or closed.
  ]]
  local function onSettingsEvent(active)

    -- Toggle Active State
    isActive = active or (not isActive);
    
    -- Update the visability of the menu
    SettingsMenu.Visible = isActive;
    Lighting.Blur.Enabled = isActive;

  end

  --[[
  Listens for incoming events which will set the settings
  menu to be toggled on and off.
  ]]
  SettingsEvent:Connect(onSettingsEvent);

  --[[
  Listens for incoming remote events which will set the 
  settings menu active state.
  ]]
  SettingsRemoteEvent:Connect(onSettingsEvent);
end

initializeSettingsMenu();