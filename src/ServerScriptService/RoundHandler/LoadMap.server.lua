local Maps = require(game.ReplicatedStorage.Maps)
local MapHandler = game.ServerScriptService.MapHandler
local GameInSession = game.ReplicatedStorage.GameData.GameInSession
local GameClock = game.ReplicatedStorage.GameData.GameClock
local GameSettings = game.ReplicatedStorage.GameSettings

local LoadDebounce = false

GameClock.Changed:Connect(function(timeRemaining)

    if GameInSession.Value then 
        LoadDebounce = false    -- If the game is in session then unlock the system so that the next rounds map can be loaded.
        return  -- Prevents the map from "reloading" during a game session
    end
    
    if timeRemaining > GameSettings.MapLoadTimeTrigger.Value then return end
    if LoadDebounce then return end

    local MapLoaded = MapHandler.LoadMap:Invoke(Maps.Candyland)
    if not MapLoaded then
        error("Map failed to load!")
    end

    LoadDebounce = true
end)