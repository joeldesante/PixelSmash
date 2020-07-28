local RunService = game:GetService("RunService")
local Scheduler = {}

function Scheduler.new()

    local elapsed = 0
    RunService.Stepped:Connect(function(time, e)
        elapsed = elapsed + e
    end)

end

return Scheduler.new()