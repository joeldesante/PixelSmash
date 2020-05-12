local Action = {};
Action.name = "PurchasePowerup";
Action.inputs = Enum.KeyCode.E 

function Action.context(actionName, inputState, inputObj)
  if inputState == Enum.UserInputState.Begin then
    Action.fire();
  end
end

function Action.fire()
  
  -- Pause the count down

  -- Request the purchase

end

return Action;