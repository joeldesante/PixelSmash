local Action = {};
Action.name = "OpenSettingsAction";
Action.inputs = Enum.KeyCode.P;

function Action.context(actionName, inputState, inputObj)
  if inputState == Enum.UserInputState.Begin then
    Action.fire();
  end
end

function Action.fire()
  print("Opening Settings");
  local settingsEvent = game.ReplicatedStorage.Events:WaitForChild("SettingsEvent");
  settingsEvent:Fire();
end

return Action;