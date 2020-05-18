local Action = {};
Action.name = "myAction";
Action.inputs = Enum.KeyCode.Q;

function Action.context(actionName, inputState, inputObj)
  if inputState == Enum.UserInputState.Begin then
    Action.fire();
  end
end

function Action.fire()
  --print("Activate Powerup.");
  game.ReplicatedStorage.Emitters:WaitForChild("PowerupEmitter"):InvokeServer();
end

return Action;