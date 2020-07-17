local Maps = require(game.ReplicatedStorage.Maps)
local MapHandler = game.ServerScriptService.MapHandler

wait(1)
MapHandler.LoadMap:Invoke(Maps.Test)