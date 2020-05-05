local ConvertTime = {};

function ConvertTime.SecondsToMinutes(seconds)
  if type(seconds) ~= "number" then
    warn("Type of seconds must be a number. Aborting.");
    return {
      ["minutes"] = 0;
      ["seconds"] = 0;
    };
  end

  local minutes = math.floor(seconds / 60);
  local seconds = seconds % 60;

  return {
    ["minutes"] = minutes;
    ["seconds"] = seconds;
  };
end

return ConvertTime;