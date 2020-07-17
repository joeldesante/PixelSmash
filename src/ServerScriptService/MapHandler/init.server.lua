local RegisteredMaps = require(game.ReplicatedStorage.Maps)

-- Events
local LoadMap = script.LoadMap
local MapLoaded = script.MapLoaded

--[[
	This function fires when the LoadMap BindableFunction is triggered.
	It loads the map given from the Maps meta module in ReplicatedStorage

	Params:
		map - Map Meta Object
	
	Notes:
	Validation is fairly weak as the BindableFunction only supplies a copy
	of the object preventing us from using a table.find validation.
]]
local function onLoadMap(map)

	--[[
		Validate the response
		Checks if the map is nil.
		The validation could be stronger but the time limitations 
		do not permit.
	]]
	if map == nil then
		warn("The given map is not a valid map")
		return false
	end

	-- Build the map into the world
	local LoadedMap = map.Root:Clone()
	LoadedMap.Name = "LoadedMap"
	LoadedMap.Parent = game.Workspace

	-- Emit the event
	MapLoaded:Fire(map, LoadedMap)
	return true
end

LoadMap.OnInvoke = onLoadMap