local TextService = game:GetService("TextService");
local TextHandler = {};

function TextHandler.CalculateWidth(input)
  return TextService:GetTextSize(input.Text, 14, input.Font, Vector2.new(300,30));
end

return TextHandler;