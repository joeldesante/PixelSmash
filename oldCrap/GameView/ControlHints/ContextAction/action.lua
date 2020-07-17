local Action = {};
Action.name = "myAction";
Action.inputs = Enum.KeyCode.X 

function Action.context(actionName, inputState, inputObj)
  if inputState == Enum.UserInputState.Begin then
    Action.fire();
  end
end

function Action.fire()
  print("Handling action.");
end

return Action;