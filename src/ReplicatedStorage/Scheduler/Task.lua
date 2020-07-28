local Task = {}

function Task.new(rate, callback)
    local self = {}
    self.rate = rate
    self.callback = callback
    
end

return Task