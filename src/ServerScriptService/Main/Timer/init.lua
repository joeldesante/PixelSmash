local Timer = {};
local __timers = {};

local __timerObject = {};
__timerObject.timeLeft = 0;
__timerObject.isRunning = true;
__timerObject.__index = __timerObject;

function __timerObject:IsRunning()
  return self.isRunning;
end

function __timerObject:SetRunning(bool)

  if type(bool) ~= 'boolean' then
    warn("Value must be a boolean.");
    return;
  end

  self.isRunning = bool;
end

function __timerObject:GetTime()
  return self.timeLeft;
end

function __timerObject:AddTime(amount)
  if type(amount) ~= 'number' then
    warn("Value must be a number.");
    return;
  end

  self.timeLeft = self.timeLeft + amount;
end

function __timerObject:SubtractTime(amount)
  if type(amount) ~= 'number' then
    warn("Value must be a number.");
    return;
  end

  self.timeLeft = self.timeLeft - amount;

  if self.timeLeft < 0 then
    self.timeLeft = 0;
  end
end

function __timerObject:SetTime(amount)
  if type(amount) ~= 'number' then
    warn("Value must be a number.");
    return;
  end

  self.timeLeft = amount;
end

function __timerObject:Increment()
  self.timeLeft = self.timeLeft + 1;
end

function __timerObject:Decrement()
  self.timeLeft = self.timeLeft - 1;
end

local function newTimer(time, isRunning)

  if type(time) ~= 'number' then
    warn("Time value must be a number.");
    return;
  end

  if type(isRunning) ~= 'boolean' then
    warn("isRunning value must be a boolean.");
    return;
  end

  local t = {}
  setmetatable(t, __timerObject);
  t:SetTime(time);
  t:SetRunning(isRunning);
  return t;
end

-- Exposed Functions
function Timer.CreateTimer(name, time, isRunning)

  if type(name) ~= 'string' then
    warn("Name value must be a string.");
    return;
  end

  local timer = newTimer(time, isRunning);
  __timers[name] = timer;

  return __timers[name];
end

function Timer.GetTimer(name)
  if type(name) ~= 'string' then
    warn("Name value must be a string.");
    return;
  end

  return __timers[name];
end

function Timer.IsRunning(name)
    return __timers[name]:IsRunning();
end

function Timer.SetRunning(name, value)
  __timers[name]:SetRunning(value);
end

function Timer.Decrement(name)
    __timers[name]:Decrement()
end

function Timer.Increment(name)
  __timers[name]:Increment()
end

function Timer.GetTime(name)
  return __timers[name]:GetTime()
end

function Timer.SetTime(name, amount)
  __timers[name]:SetTime(amount)
end

function Timer.Count(name)
    coroutine.resume(coroutine.create(function()
        while(Timer.IsRunning(name)) do
          Timer.Decrement(name);
          -- Emit a message to get let everyone know the status
          script.TimerEmitter:FireAllClients(name, Timer.GetTime(name));
          script.TimerEvent:Fire(name, Timer.GetTime(name));

          wait(1);

          if Timer.GetTime(name) <= 0 then
            Timer.SetRunning(name, false);
          end
        end
    end));
end

return Timer;